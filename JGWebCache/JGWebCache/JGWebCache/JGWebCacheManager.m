//
//  JGWebCacheManager.m
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGWebCacheManager.h"
#import "JGCache.h"
#import "JGDataDownloader.h"

@interface JGWebCacheManager ()

@end

@implementation JGWebCacheManager

+(JGWebCacheManager *)shared
{
    static JGWebCacheManager * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JGWebCacheManager new];
    });
    return instance;
}

-(void)loadDataFromUrl:(NSString *)url withCompletionBlock:(JGCacheQueryCompletionBlock)completionBlock
{
    NSData * cachedData = [[JGCache shared] queryCacheForKey:url];
    if (cachedData)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(cachedData, url);

        });
        return;
    }
    
    
    [[JGDataDownloader shared] loadDataFromUrl:url withDoneBlock:^(NSData *data, NSError *error) {
       
        if (error == nil)
        {
            [[JGCache shared] storeData:data inCacheForKey:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(data, url);
            });
        }
        return;
    }];
    
}



@end
