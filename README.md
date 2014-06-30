![Screenshot](https://raw.githubusercontent.com/juzzin/JUSEmptyViewController/master/screenshot.png)

### JUSEmptyViewController
Displays an empty view controller for table and collection Views whose datasource is empty.

### How to use
Import the appropriate header file:
```
#import "UICollectionView+EmptyView.h"
#import "UITableView+EmptyView.h"
```

Configure the empty view controller:
```
[self configureEmptyViewController:emptyViewController];
```

### Default Empty View Controller
You may use a custom view controller or the included ```JUSDefaultEmptyViewController```. Instantiate with:

```
JUSDefaultEmptyViewController *emptyViewController = [JUSDefaultEmptyViewController new];
emptyViewController.delegate = self;
```

Optionally implement the ```JUSDefaultEmptyViewController``` protocol which currently only declares ```emptyViewDidTapButton```.