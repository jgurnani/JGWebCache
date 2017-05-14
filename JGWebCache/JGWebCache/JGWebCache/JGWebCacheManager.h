//
//  JGWebCacheManager.h
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JGCacheQueryCompletionBlock)(NSData * data, NSString * url);

@interface JGWebCacheManager : NSObject

+(JGWebCacheManager *)shared;
-(void)loadDataFromUrl:(NSString *)url withCompletionBlock:(JGCacheQueryCompletionBlock)completionBlock;

@end
