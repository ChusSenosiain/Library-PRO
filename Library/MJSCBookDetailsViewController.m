//
//  MJSCBookDetailsViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBookDetailsViewController.h"
#import "MJSCBookPDFViewController.h"
#import "MJSCBook.h"
#import "MJSCLibraryViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface MJSCBookDetailsViewController () 

@property (strong, nonatomic) MJSCBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookCategory;
@property (weak, nonatomic) IBOutlet UILabel *bookSummary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIView *btnRead;

@end

@implementation MJSCBookDetailsViewController

-(id)initWithBook:(MJSCBook *)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureView];
    [self syncViewWithModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.bookImage cancelImageRequestOperation];
}


#pragma mark - IBAction

- (IBAction)viewPDF:(id)sender {
    MJSCBookPDFViewController *pdfVC = [[MJSCBookPDFViewController alloc] initWithBook:self.book];
    [self.navigationController pushViewController:pdfVC animated:YES];
}

#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)splitVC
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    if (displayMode != UISplitViewControllerDisplayModeAllVisible) {
        // We've to put a button on the navigation bar to show the primary controller (left)
        self.navigationItem.rightBarButtonItem = splitVC.displayModeButtonItem;
    }
}

#pragma mark - MJSCLibraryViewControllerDelegate

-(void)libraryViewController:(UIViewController *)libraryVC didSelectBook:(MJSCBook *)book indexPath:(NSIndexPath *)indexPath {
    self.book = book;
    [self syncViewWithModel];
}

#pragma mark - Utils

-(void)syncViewWithModel {
    self.bookTitle.text = self.book.title;
    self.bookAuthor.text = self.book.author;
    self.bookCategory.text = self.book.category;
    self.bookSummary.text = self.book.summary;
    
    [self.bookImage setImageWithURL:self.book.imageURL];
}

-(void)configureView {
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.bookImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.bookImage.layer.borderWidth = 1;
    self.bookImage.layer.cornerRadius = 2;
    
    self.btnRead.clipsToBounds = YES;
    self.btnRead.layer.cornerRadius = 4;
    self.btnRead.backgroundColor = [MJSCStyles accentColor];
    
}

@end
