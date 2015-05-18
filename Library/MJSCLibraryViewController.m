//
//  MJSCLibraryViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 15/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryViewController.h"
#import "MJSCLibrary.h"
#import "MJSCLibraryTableViewController.h"
#import "MJSCLibraryCollectionViewController.h"
#import "MJSCBookDetailsViewController.h"
#import "Settings.h"


@interface MJSCLibraryViewController ()
@property(nonatomic, strong) MJSCLibrary* library;
 @property (nonatomic, retain) UITabBarController *tab;
@end

@implementation MJSCLibraryViewController

-(id)initWithModel:(MJSCLibrary *)library {
    
    if (self = [super init]) {
        _library = library;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    // Eliminamos comportamiento por defcto de iOS 7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Library";
    
    
    
   
    MJSCLibraryTableViewController *libraryTableVC = [[MJSCLibraryTableViewController alloc] initWithModel:self.library];
    MJSCLibraryCollectionViewController *libraryCollectionVC = [[MJSCLibraryCollectionViewController alloc] initWithModel:self.library];

    
    [libraryTableVC setDelegate:self];
    [libraryCollectionVC setDelegate:self];
    
    
    libraryTableVC.tabBarItem.image = [UIImage imageNamed:@"Table"];
    libraryCollectionVC.tabBarItem.image = [UIImage imageNamed:@"Collection"];
    
    self.tab = [[UITabBarController alloc] init];
    self.tab.viewControllers = @[libraryTableVC, libraryCollectionVC];
    self.tab.view.frame = self.view.frame;
    
    
    
    
    [[self.tab tabBar] setTranslucent:NO];
    
    
    [[UITabBar appearance] setTintColor:UIColorFromRGB(0x03A9F4)];
    [[UITabBar appearance] setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.view addSubview:self.tab.view];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - LibraryViewControllerDelegate
-(void)libraryViewController:(UIViewController *)libraryVC didSelectBook:(MJSCBook *)book indexPath:(NSIndexPath *)indexPath {
    
    // Save the book selected in user preferences
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray *coords = @[@(indexPath.section), @(indexPath.row)];
    
    
    [def setObject:coords forKey:LAST_SELECTED_BOOK_KEY];
    
    [def synchronize];
    
    
    // Send the notificación to MJSCPDFViewController
    NSDictionary *dict = @{BOOK_KEY: book};
    NSNotification *n = [NSNotification notificationWithName:BOOK_DID_CHANGE_NOTIFICATION object:self userInfo:dict];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotification:n];

    
    // Go to book details
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    } else {
        MJSCBookDetailsViewController *bookDetailsVC = [[MJSCBookDetailsViewController alloc] initWithBook:book];
        [self.navigationController pushViewController:bookDetailsVC animated:YES];
    }
 
    
}



@end
