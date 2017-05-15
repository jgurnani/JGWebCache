//
//  JGCache.h
//  JGWebCache
//
//  Created by Jaygurnani on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JGCache : NSObject

+(JGCache *)shared;
-(NSData *)queryCacheForKey:(NSString *)key;
-(void)storeData:(NSData *)data inCacheForKey:(NSString *)key;


@end
