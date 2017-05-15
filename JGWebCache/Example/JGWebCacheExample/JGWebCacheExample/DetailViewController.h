//
//  DetailViewController.h
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGModel.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage * placeHolderImage;
@property (nonatomic, strong) JGModel * model;
@end
