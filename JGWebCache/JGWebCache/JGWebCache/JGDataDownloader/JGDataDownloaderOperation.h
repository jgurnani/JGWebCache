//
//  JGDataDownloaderOperation.h
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JGDownloadDelegate <NSObject>

-(void)didRecievedData:(NSData *)data withError:(NSError *)error forRequestToken:(NSString *)requestToken;

@end

@interface JGDataDownloaderOperation : NSOperation
//For simple get request
-(JGDataDownloaderOperation *)initWithUrl:(NSString *)url withDelegate:(id<JGDownloadDelegate>)delegate withRequestToken:(NSString *)requestToken;

//For customised requests like POST, PUT etc.
-(JGDataDownloaderOperation *)initWithRequest:(NSURLRequest *)request withDelegate:(id<JGDownloadDelegate>)delegate withRequestToken:(NSString *)requestToken;


@end
