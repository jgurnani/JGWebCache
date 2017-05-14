//
//  ViewController.m
//  JGWebCacheExample
//
//  Created by GlobalLogic on 12/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "ViewController.h"
#import "JGWebCache/JGWebCache.h"
#import "JGModel.h"
#import "JGTableViewCell.h"
#import "UIImageView+JGWebCache.h"
#import "JGFancyTransition.h"
#import "DetailViewController.h"

#define NAVIGATION_BAR_HEIGHT 64.0
#define TABLEVIEW_HEADER_HEIGHT 400.0

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray<JGModel *> * modelArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeaderHeightConstraint;
@property (strong, nonatomic) JGFancyTransition * animationController;

@end

@implementation ViewController
{
    CGRect selectedRowRect;
    UIImage * selectedImageForTrasition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViewTransperantHeader];
    self.animationController = [[JGFancyTransition alloc]init];
    
    [[JGWebCacheManager shared]loadDataFromUrl:@"http://pastebin.com/raw/wgkJgazE" withCompletionBlock:^(NSData *data, NSString * url) {
        
        NSError * error;
        if (error)
            NSLog(@"%@", error);
        else
        {
            [self createModelObjectsFromData:data];
        }
        
    }];

    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)setupTableViewTransperantHeader
{
    UIView * tableViewTransperantHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, TABLEVIEW_HEADER_HEIGHT)];
    tableViewTransperantHeader.alpha = 0.0;
    self.tableView.tableHeaderView = tableViewTransperantHeader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createModelObjectsFromData:(NSData *)data
{
    NSError * error;
    NSArray<NSDictionary *> * response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error)
    {
        return;
    }
    
    self.modelArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary * dictionary in response) {
        
        [self.modelArray addObject:[[JGModel alloc]initWithDictionary:dictionary]];
        
    }
    
    [self.tableView reloadData];
    
    
}

#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JGTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JGTableViewCell"];
    
//    if(cell == nil)
//    {
//        cell = [[JGTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JGTableViewCell"];
//    }
    
    JGModel * model = [self.modelArray objectAtIndex:indexPath.row];
    
    [cell.cardImageView setImageWithUrl:model.imageUrl withPlaceHolder:[UIImage imageNamed:@"Placeholder"]];
    cell.nameLabel.text = model.name;
    [cell.profileImageView setImageWithUrl:model.profileImageUrl withPlaceHolder:[UIImage imageNamed:@"Placeholder"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JGTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedRowRect = [tableView rectForRowAtIndexPath:indexPath];
    selectedRowRect.origin.y -= self.tableView.contentOffset.y;
    
    //Cell padding is 16
    selectedRowRect.origin.x = 16;
    selectedRowRect.size.width -= 32;
    
    selectedImageForTrasition = cell.cardImageView.image;
    
    JGModel * model = [self.modelArray objectAtIndex:indexPath.row];
    DetailViewController * detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.transitioningDelegate = self;
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    detailViewController.model = model;
    detailViewController.placeHolderImage = cell.cardImageView.image;
    [self presentViewController:detailViewController animated:true completion:nil];
    
    
}


#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y >= TABLEVIEW_HEADER_HEIGHT - NAVIGATION_BAR_HEIGHT)
    {
        self.tableViewHeaderHeightConstraint.constant = NAVIGATION_BAR_HEIGHT;
    }
    else
    {
        self.tableViewHeaderHeightConstraint.constant = TABLEVIEW_HEADER_HEIGHT - scrollView.contentOffset.y;
    }
}


#pragma mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animationController.type = AnimationTypeDismiss;
    return self.animationController;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animationController.type = AnimationTypePresent;
    self.animationController.animationStartRect = selectedRowRect;
    self.animationController.animatingImage = selectedImageForTrasition;
    return self.animationController;
}

@end
