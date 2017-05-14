//
//  JGCache.m
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGCache.h"
#import "NSString+MD5.h"

@interface JGCache ()

@property (nonatomic, strong) NSCache * memCache;

@end

@implementation JGCache

+(JGCache *)shared
{
    static dispatch_once_t once;
    static JGCache * instance;
    
    dispatch_once(&once, ^{
        instance = [[JGCache alloc]init];
    });
    
    return instance;
}

-(JGCache *)init
{
    self = [super init];
    if(self != nil)
    {
        self.memCache = [[NSCache alloc]init];
    }
    return self;
}

-(NSData *)queryCacheForKey:(NSString *)key
{
    NSString * cacheKey = [self cacheKeyForkey:key];
    NSData * dataFromCache = [self dataFromMemoryCacheForCacheKey:cacheKey];
    return dataFromCache;
}

-(void)storeData:(NSData *)data inCacheForKey:(NSString *)key
{
    NSString * cacheKey = [self cacheKeyForkey:key];
    [self.memCache setObject:data forKey:cacheKey cost:data.length];
}

-(NSString *)cacheKeyForkey:(NSString *)key
{
    return [key MD5String];
}

//Returns data from memory cache agaisnt the key.
//Key should be cache key, not the key user sends. (CacheKey can be created using cacheKeyFromKey
-(NSData *)dataFromMemoryCacheForCacheKey:(NSString *)key
{
    NSData * data = [self.memCache objectForKey:key];
    return data;
}

@end
