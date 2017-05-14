//
//  JGTableViewCell.h
//  JGWebCacheExample
//
//  Created by GlobalLogic on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIView *cardContainerView;
@property (weak, nonatomic) IBOutlet UIView *cardDetailView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@end
