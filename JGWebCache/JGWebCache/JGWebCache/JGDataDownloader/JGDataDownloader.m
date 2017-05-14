//
//  JGDataDownloader.m
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGDataDownloader.h"
#import "JGDataDownloaderOperation.h"
#import "NSString+MD5.h"

@interface JGDataDownloader () <JGDownloadDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSOperation *> * URLRequests;
@property (strong, nonatomic, nullable) dispatch_queue_t barrierQueue;
@property (nonatomic, strong) NSMutableDictionary<NSString *, JGDataResponseBlock> * ResponseHandlers;
@property (nonatomic, strong) NSOperationQueue * downloadQueue;

@end

@implementation JGDataDownloader

+(JGDataDownloader *)shared
{
    static JGDataDownloader * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JGDataDownloader alloc]init];
    });
    return instance;
}

-(JGDataDownloader *)init
{
    self = [super init];
    if (self != nil)
    {
        self.ResponseHandlers = [[NSMutableDictionary alloc]init];
        self.URLRequests = [[NSMutableDictionary alloc]init];
        _barrierQueue = dispatch_queue_create("BarrierQueue", DISPATCH_QUEUE_CONCURRENT);
        self.downloadQueue = [NSOperationQueue new];
    }
    return self;
}

-(void)loadDataFromUrl:(NSString *)url withDoneBlock:(JGDataResponseBlock)doneBlock
{
    JGDataDownloaderOperation * dataDownloadOperation = [[JGDataDownloaderOperation alloc]initWithUrl:url withDelegate:self withRequestToken:[url MD5String]];
    
    __weak JGDataDownloaderOperation * weakDataDownloadOperation = dataDownloadOperation;
    
    NSString * urlToken = [url MD5String];
    
    if(urlToken == nil)
    {
        return;
    }
    
    dispatch_barrier_sync(self.barrierQueue, ^{
        
        [self.URLRequests setObject:dataDownloadOperation forKey:urlToken];
        [self.ResponseHandlers setObject:doneBlock forKey:urlToken];
        
        __weak typeof(self) weakSelf = self;
        dataDownloadOperation.completionBlock = ^{
            if(weakSelf != nil && weakSelf.URLRequests[urlToken] == weakDataDownloadOperation)
            {
                [weakSelf.URLRequests removeObjectForKey:urlToken];
                [weakSelf.ResponseHandlers removeObjectForKey:urlToken];
            }
        };

        NSLog(@"Barrier code worked");
        
    });
    
    [self.downloadQueue addOperation:dataDownloadOperation];
    
    
}

-(void)didRecievedData:(NSData *)data withError:(NSError *)error forRequestToken:(NSString *)requestToken
{
    JGDataResponseBlock responseBlock = [self.ResponseHandlers objectForKey:requestToken];
    if (responseBlock)
    {
        responseBlock(data, error);
        [self.URLRequests removeObjectForKey:requestToken];
        [self.ResponseHandlers removeObjectForKey:requestToken];

    }
}

@end
