//
//  TableViewController.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "TableViewController.h"
#import "UITableView+EmptyView.h"

@interface TableViewController () <JUSDefaultEmptyViewController>
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup fake items array
    self.items = [NSMutableArray array];
    
    // Configure datasource
    self.tableView.dataSource = self;
    
    // Create empty view controller
    JUSDefaultEmptyViewController *emptyViewController = [JUSDefaultEmptyViewController new];
    emptyViewController.delegate = self;
    
    // Configure empty view controller
    [self configureEmptyViewController:emptyViewController];
    
    // Customize view
    emptyViewController.titleLabel.text = @"You're out of octopuses!";
    emptyViewController.subtitleLabel.text = @"When you follow some blogs, their latest octopuses will show up here!";
    [emptyViewController.actionButton setTitle:@"Get an octopus!" forState:UIControlStateNormal];
    emptyViewController.imageView.image = [UIImage imageNamed:@"emptyimage2"];
    emptyViewController.imageView.alpha = 0.5f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Simulate non-empty data source, but temporarily prohibit empty view display
    [self.activityIndicator startAnimating];
    [self disableEmptyViewController];
    
    [self.items removeLastObject];
    [self.tableView reloadData];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.5);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self.activityIndicator stopAnimating];
        [self enableEmptyViewController];
        [tableView reloadData];
    });
}

#pragma mark - JUSEmptyViewControllerDelegate

- (void)emptyViewDidTapButton
{
    NSLog(@"Getting an octopus!");    
    [self.items addObject:@"Octopus"];
    [self.tableView reloadData];
}

@end
