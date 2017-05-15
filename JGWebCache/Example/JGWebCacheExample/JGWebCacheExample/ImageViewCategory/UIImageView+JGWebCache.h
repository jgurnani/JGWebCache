//
//  UIImageView+JGWebCache.h
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^JGImageViewLoadingCompletionBlock)(UIImage * image);

@interface UIImageView (JGWebCache)

-(void)setImageWithUrl:(NSString *)url;
-(void)setImageWithUrl:(NSString *)url withPlaceHolder:(UIImage *)placeHolder;
-(void)setImageWithUrl:(NSString *)url withPlaceHolder:(UIImage *)placeHolder andCompletionHandler:(JGImageViewLoadingCompletionBlock)completionBlock;

@end
