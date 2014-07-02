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
    emptyViewController.title = @"You're out of octopuses!";
    emptyViewController.subtitle = @"When you follow some blogs, their latest octopuses will show up here!";
    emptyViewController.actionButtonTitle = @"Get an octopus";
    emptyViewController.imageName = @"octopus";
    emptyViewController.delegate = self;
    
    // Configure empty view controller
    [self configureEmptyViewController:emptyViewController];
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
    // Create activity indicator and position hackishly
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.center = tableView.center;
    [tableView addSubview:activityIndicator];
    
    // Simulate non-empty data source, but temporarily prohibit empty view display
    // Center activity indicator
    [activityIndicator startAnimating];
    [self disableEmptyViewController];
    
    [self.items removeLastObject];
    [self.tableView reloadData];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.5);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
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
