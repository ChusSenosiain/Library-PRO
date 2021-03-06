//
//  MJSCBookDetailsViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBookDetailsViewController.h"
#import "MJSCBookPDFViewController.h"
#import "MJSCLibraryViewController.h"
#import "MJSCNetworkManager.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "MJSCNotesViewController.h"

@interface MJSCBookDetailsViewController () 

@property (strong, nonatomic) Book *book;
@property (strong, nonatomic) MJSCBookManager *bookManager;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookCategory;
@property (weak, nonatomic) IBOutlet UILabel *bookSummary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIButton *btnRead;


@end

@implementation MJSCBookDetailsViewController

-(id)initWithBook:(Book *)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.bookManager = [[MJSCBookManager alloc] init];
    self.bookManager.delegate = self;
    [self configureView];
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


- (IBAction)showNotes:(id)sender {
    
    MJSCNotesViewController *notesTableVC = [[MJSCNotesViewController alloc] initWithBook:self.book];
    [self.navigationController pushViewController:notesTableVC animated:YES];
}


-(IBAction)share:(id)sender{
    
    
    UIAlertController *notebookDialog = [UIAlertController alertControllerWithTitle:@"Share a comment" message:@"Share a comment about this book" preferredStyle:UIAlertControllerStyleAlert];
    
    
    __weak typeof (self) weakSelf = self;
    [notebookDialog addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (weakSelf) {
            
            __strong typeof (weakSelf) strongSelf = weakSelf;
            
            UITextField *commentTextFiled = notebookDialog.textFields.firstObject;
            NSString *textToShare = [NSString stringWithFormat:@"%@: %@", self.book.title, commentTextFiled.text];
            NSArray *activityItems = @[textToShare];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
            
            [strongSelf presentViewController:activityVC animated:YES completion:nil];
        }
        
    }]];
    
    [notebookDialog addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [notebookDialog dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [notebookDialog addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comment";
    }];
    
    
    [self presentViewController:notebookDialog animated:YES completion:nil];
    


}




#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)splitVC
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if (displayMode != UISplitViewControllerDisplayModeAllVisible) {
        // We've to put a button on the navigation bar to show the primary controller (on the left)
        self.navigationItem.rightBarButtonItem = splitVC.displayModeButtonItem;
    }
}

#pragma mark - MJSCLibraryViewControllerDelegate

-(void)libraryViewController:(UIViewController *)libraryVC didSelectBook:(Book *)book indexPath:(NSIndexPath *)indexPath {
    self.book = book;
    // cancelar anterior descarga
    [self.bookImage cancelImageRequestOperation];
    
    // Obtener detalles del libro
    [self.bookManager loadBookDetails:[self.book bookID]];

}

#pragma mark - MJSCBookManagerDelegate
-(void)bookDidFinishLoad:(Book *)book {
    self.book = book;
    [self syncViewWithModel];
}


#pragma mark - Utils

-(void)syncViewWithModel {
    self.bookTitle.text = self.book.title;
    self.bookAuthor.text = self.book.author;
    self.bookCategory.text = self.book.category;
    self.bookSummary.text = self.book.summary;
    
    [self.bookImage setImageWithURL:[NSURL URLWithString:self.book.imageURL]];
}


-(void)configureView {
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.bookImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.bookImage.layer.borderWidth = 0.5;
    self.bookImage.layer.cornerRadius = 2;
    
    self.bookCategory.textColor = [MJSCStyles secondaryTextColor];
    self.bookTitle.textColor = [MJSCStyles primaryTextColor];
    self.bookAuthor.textColor = [MJSCStyles primaryTextColor];
    self.bookSummary.textColor = [MJSCStyles primaryTextColor];
    
    self.btnRead.clipsToBounds = YES;
    self.btnRead.layer.cornerRadius = 4;
    self.btnRead.layer.borderWidth = 1;
    self.btnRead.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.btnRead.layer.borderColor = [[MJSCStyles accentColor] CGColor];
    [self.btnRead setTitleColor:[MJSCStyles accentColor] forState:UIControlStateNormal];
    [self.btnRead setTitleColor:[MJSCStyles lightPrimaryColor] forState:UIControlStateSelected];
    
    
    
    UIBarButtonItem *showNotesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showNotes:)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItems = @[showNotesButton, shareButton];

    
    if (self.book) {
        // TODO: load books details
        [self syncViewWithModel];
        [self.bookManager loadBookDetails:[self.book bookID]];
        
    }
    
    
}

@end
