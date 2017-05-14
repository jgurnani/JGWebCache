//
//  JGFancyTransition.h
//  JGWebCacheExample
//
//  Created by GlobalLogic on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AnimationTypeDismiss,
    AnimationTypePresent,
} AnimationType;

@interface JGFancyTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType * type;
@property (nonatomic) CGRect animationStartRect;
@property (nonatomic, strong) UIImage * animatingImage;

@end
