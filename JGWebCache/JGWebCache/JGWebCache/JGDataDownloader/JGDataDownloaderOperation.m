//
//  JGDataDownloaderOperation.m
//  JGWebCache
//
//  Created by Jaygurnani on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGDataDownloaderOperation.h"

@interface JGDataDownloaderOperation ()

@property (nonatomic, weak) id<JGDownloadDelegate> delegate;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * requestToken;
@property (nonatomic, strong) NSURLRequest * request;

@end

@implementation JGDataDownloaderOperation

-(JGDataDownloaderOperation *)initWithUrl:(NSString *)url withDelegate:(id<JGDownloadDelegate>)delegate withRequestToken:(NSString *)requestToken
{
    self = [super init];
    if (self != nil)
    {
        self.delegate = delegate;
        self.url = url;
        self.requestToken = requestToken;
    }
    return self;
}

-(JGDataDownloaderOperation *)initWithRequest:(NSURLRequest *)request withDelegate:(id<JGDownloadDelegate>)delegate withRequestToken:(NSString *)requestToken
{
    self = [super init];
    if (self != nil)
    {
        self.delegate = delegate;
        self.request = request;
        self.requestToken = requestToken;
    }
    return self;
}


-(void)start
{
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    if (self.request == nil)
    {
        NSURL * url = [NSURL URLWithString:self.url];
        self.request = [[NSURLRequest alloc]initWithURL:url];
    }
    
    NSURLSessionTask * task = [session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            if ([self.delegate respondsToSelector:@selector(didRecievedData:withError:forRequestToken:)])
            {
                [self.delegate didRecievedData:data withError:error forRequestToken:self.requestToken];
            }

        
    }];
    
    [task resume];
    
}
    

@end
