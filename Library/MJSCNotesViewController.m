//
//  MJSCNotesViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNotesViewController.h"
#import "MJSCNotesTableViewController.h"
#import "MJSCNotesMapViewController.h"
#import "MJSCNoteViewController.h"
#import "Book.h"

@interface MJSCNotesViewController () <MJSCNotesMapViewControllerDelegate, MJSCNotesTableViewControllerDelegate>
@property (nonatomic, retain) UITabBarController *tab;
@property (strong, nonatomic) Book *book;
@end



@implementation MJSCNotesViewController

-(id)initWithBook:(Book *)book {

    if (self = [super init])  {
        _book = book;
    }
    
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

#pragma maark - Actions
-(IBAction)addNote:(id)sender {
    
    MJSCNoteViewController *noteVC = [[MJSCNoteViewController alloc] initWithBook:self.book page:0];
    [self.navigationController pushViewController:noteVC animated:YES];
    
}

#pragma mark - MJSCNoteTableViewControllerDelegate
-(void)didSelectNote:(Note *)note {
    [self showNoteDetails:note];
}

#pragma mark - MJSCNoteMapViewControllerDelegate
-(void)didSelectNoteOnMap:(Note *)note {
    [self showNoteDetails:note];
}


#pragma mark - Utils

-(void)configureView{
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Book Notes";
    
    // Vcs
    MJSCNotesTableViewController *notesTableVC = [[MJSCNotesTableViewController alloc] initWithBook:self.book];
    MJSCNotesMapViewController *notesMapVC = [[MJSCNotesMapViewController alloc] initWithBook:self.book];
    
    // Set the MJSCNoteViewControllerDelegate Delegate
    notesTableVC.delegate = self;
    notesMapVC.delegate = self;
    
    
    // Prepare Vcs to the etabbar
    notesTableVC.tabBarItem.image = [UIImage imageNamed:@"Table"];
    notesMapVC.tabBarItem.image = [UIImage imageNamed:@"ic_map"];
    
    
    self.tab = [[UITabBarController alloc] init];
    
    // Tab bar appearance
    self.tab.view.frame = self.view.frame;
    [[self.tab tabBar] setTranslucent:NO];
    
    
    [[UITabBar appearance] setTintColor:[MJSCStyles accentColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    
    
    // Set the VCs to the tab bar
    self.tab.viewControllers = @[notesTableVC, notesMapVC];
    
    // Ad the tabbar to the view
    [self.view addSubview:self.tab.view];
    
    
    //Button add to add notes
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;

    
}


-(void)showNoteDetails:(Note *)note {
    MJSCNoteViewController *noteVC = [[MJSCNoteViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:noteVC animated:YES];
}


@end
