//
//  CollectionViewController.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "CollectionViewController.h"
#import "UICollectionView+EmptyView.h"

@interface CollectionViewController () <JUSDefaultEmptyViewController>
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setup fake items array
    self.items = [NSMutableArray array];
    
    // Configure datasource
    self.collectionView.dataSource = self;
    
    // Create empty view controller
    JUSDefaultEmptyViewController *emptyViewController = [JUSDefaultEmptyViewController new];
    emptyViewController.delegate = self;
    
    // Configure empty view controller
    [self configureEmptyViewController:emptyViewController];
    
    // Customize view
    emptyViewController.titleLabel.text = @"You're out of monkeys.";
    emptyViewController.subtitleLabel.text = @"When you follow some blogs, their latest monkeys will show up here!";
    [emptyViewController.actionButton setTitle:@"Get monkeys!" forState:UIControlStateNormal];
    emptyViewController.imageView.image = [UIImage imageNamed:@"emptyimage"];
    emptyViewController.imageView.alpha = 0.5f;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.items.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Simulate non-empty data source, but temporarily prohibit empty view display
    [self.activityIndicator startAnimating];
    [self disableEmptyViewController];
    
    [self.items removeLastObject];
    [collectionView reloadData];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.5);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self.activityIndicator stopAnimating];
        [self enableEmptyViewController];
        [collectionView reloadData];
    });
}

#pragma mark - JUSEmptyViewControllerDelegate

- (void)emptyViewDidTapButton
{
    NSLog(@"Getting monkeys!");
    [self.items addObject:@"Monkey"];
    [self.collectionView reloadData];
}

@end
