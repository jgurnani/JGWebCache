//
//  DetailViewController.m
//  JGWebCacheExample
//
//  Created by GlobalLogic on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+JGWebCache.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *detailViewFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userProfileName;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBarHeightConstraint;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addShadowToDetailViewFooter];
    [self populateUIViewElements];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addShadowToDetailViewFooter];
    [self addShadowToTopBarView];
}


-(void)populateUIViewElements
{
    [self.imageView setImageWithUrl:_model.imageUrl withPlaceHolder:self.placeHolderImage];
    self.userProfileName.text = _model.name;
    [self.userProfileImage setImageWithUrl:_model.profileImageUrl];

}

-(void)addShadowToTopBarView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.topBarHeightConstraint.constant = 64.0;
        [self.topBarView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.topBarView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.topBarView.layer.masksToBounds = false;
        self.topBarView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        self.topBarView.layer.shadowOpacity = 1.0;
        
    }];

}

-(void)addShadowToDetailViewFooter
{
    [UIView animateWithDuration:0.2 animations:^{
        self.footerViewHeightConstraint.constant = 75.0;
        [self.detailViewFooter layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.detailViewFooter.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.detailViewFooter.layer.masksToBounds = false;
        self.detailViewFooter.layer.shadowOffset = CGSizeMake(-5.0, -5.0);
        self.detailViewFooter.layer.shadowOpacity = 1.0;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
