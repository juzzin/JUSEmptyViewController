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
    emptyViewController.title = @"You're out of monkeys.";
    emptyViewController.subtitle = @"When you follow some blogs, their latest monkeys will show up here!";
    emptyViewController.actionButtonTitle = @"Get a monkey";
    emptyViewController.image = [UIImage imageNamed:@"monkey"];
    emptyViewController.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    emptyViewController.enableMotionEffects = YES;
    emptyViewController.delegate = self;
    
    // Configure empty view controller
    [self configureEmptyViewController:emptyViewController];
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
