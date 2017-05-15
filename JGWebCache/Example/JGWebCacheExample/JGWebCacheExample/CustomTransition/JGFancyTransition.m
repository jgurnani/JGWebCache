//
//  JGFancyTransition.m
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGFancyTransition.h"

@implementation JGFancyTransition

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView * containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.type == AnimationTypePresent) {
        UIImageView * animationImageView = [[UIImageView alloc]initWithFrame:self.animationStartRect];
        [animationImageView setImage:self.animatingImage];
        animationImageView.contentMode = UIViewContentModeScaleAspectFit;
        animationImageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [containerView insertSubview:animationImageView aboveSubview:fromViewController.view];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0 animations:^{
            
            animationImageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext]/2.0 animations:^{
                
                animationImageView.frame = [UIScreen mainScreen].bounds;
                
            } completion:^(BOOL finished) {
                
                [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
                [animationImageView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];

            
        }];

        
    } else if (self.type == AnimationTypeDismiss) {
        
        UIImageView * animationImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [animationImageView setImage:self.animatingImage];
        animationImageView.contentMode = UIViewContentModeScaleAspectFit;
        animationImageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [containerView insertSubview:animationImageView aboveSubview:fromViewController.view];
        
        fromViewController.view.hidden = true;
        containerView.backgroundColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            animationImageView.frame = self.animationStartRect;
//            fromViewController.view.frame = CGRectZero;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }

}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
        return 0.4;
    
}

@end
