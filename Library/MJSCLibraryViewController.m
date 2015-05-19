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

@property (strong, nonatomic) MJSCLibrary *library;
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
   
    [self configureView];
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
    NSNotification *notification = [NSNotification notificationWithName:BOOK_DID_CHANGE_NOTIFICATION object:self userInfo:dict];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotification:notification];

    // Go to book details
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    } else {
        MJSCBookDetailsViewController *bookDetailsVC = [[MJSCBookDetailsViewController alloc] initWithBook:book];
        [self.navigationController pushViewController:bookDetailsVC animated:YES];
    }
    
}

#pragma mark - Utils

-(void)configureView{
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Library";
  
    // Vcs
    MJSCLibraryTableViewController *libraryTableVC = [[MJSCLibraryTableViewController alloc] initWithModel:self.library];
    MJSCLibraryCollectionViewController *libraryCollectionVC = [[MJSCLibraryCollectionViewController alloc] initWithModel:self.library];
    
    // Set the LibraryViewController Delegate
    [libraryTableVC setDelegate:self];
    [libraryCollectionVC setDelegate:self];
    
    
    // Prepare Vcs to the etabbar
    libraryTableVC.tabBarItem.image = [UIImage imageNamed:@"Table"];
    libraryCollectionVC.tabBarItem.image = [UIImage imageNamed:@"Collection"];
    
    self.tab = [[UITabBarController alloc] init];

    // Tab bar appearance
    self.tab.view.frame = self.view.frame;
    [[self.tab tabBar] setTranslucent:NO];
    
    
    [[UITabBar appearance] setTintColor:[MJSCStyles accentColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor groupTableViewBackgroundColor]];

    
    // Set the VCs to the tab bar
    self.tab.viewControllers = @[libraryTableVC, libraryCollectionVC];
    
    
    // Ad the tabbar to the view
    [self.view addSubview:self.tab.view];
    
}

@end
