//
//  UIImageView+JGWebCache.m
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "UIImageView+JGWebCache.h"
#import "JGWebCache/JGWebCache.h"
#import "objc/runtime.h"

static char imageURLKey;

@implementation UIImageView (JGWebCache)


- (nullable NSString *)imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}


-(void)setImageWithUrl:(NSString *)url
{
    [self setImageWithUrl:url withPlaceHolder:nil andCompletionHandler:nil];
}

-(void)setImageWithUrl:(NSString *)url withPlaceHolder:(UIImage *)placeHolder
{
    [self setImageWithUrl:url withPlaceHolder:placeHolder andCompletionHandler:nil];
}

-(void)setImageWithUrl:(NSString *)url withPlaceHolder:(UIImage *)placeHolder andCompletionHandler:(JGImageViewLoadingCompletionBlock)completionBlock
{
    
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(placeHolder)
    {
        self.image = placeHolder;
    }
    else
    {
        self.image = nil;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[JGWebCacheManager shared] loadDataFromUrl:url withCompletionBlock:^(NSData *data, NSString * url) {
       
        __strong typeof(self) sself = weakSelf;
        
        if(sself == nil)
        {
            return;
        }
        
        if([[sself imageURL] isEqualToString:url])
        {
            [sself setImageWithData:data withCompletionBlock:completionBlock];
        }
        
        
    }];
}

-(void)setImageWithData:(NSData *)data withCompletionBlock:(JGImageViewLoadingCompletionBlock)completionBlock
{
    UIImage * image = [UIImage imageWithData:data];
    if(image != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
            [self setNeedsLayout];
            
            if(completionBlock)
                completionBlock(image);
        });
        

            
    }
    
}

@end
