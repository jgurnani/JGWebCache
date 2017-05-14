//
//  JGTableViewCell.m
//  JGWebCacheExample
//
//  Created by GlobalLogic on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGTableViewCell.h"

@implementation JGTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cardDetailView.layer.cornerRadius = 2.0;
    self.cardDetailView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cardDetailView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.cardDetailView.layer.shadowRadius = 2.0;
    
    self.cardImageView.layer.shadowRadius = 2.0;
    self.cardImageView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.cardImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.cardDetailView.layer.shadowOpacity = 1.0;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
