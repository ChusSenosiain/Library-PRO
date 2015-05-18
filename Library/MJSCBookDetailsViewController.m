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

@interface MJSCBookDetailsViewController ()

@property(nonatomic, strong) MJSCBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookCategory;
@property (weak, nonatomic) IBOutlet UILabel *bookSummary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;

- (IBAction)viewPDF:(id)sender;

@end

@implementation MJSCBookDetailsViewController


-(id)initWithBook:(MJSCBook *)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Eliminar comportamiento por defecto de iOS 7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.bookImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.bookImage.layer.borderWidth = 1;
    self.bookImage.layer.cornerRadius = 2;
    
    // Update the view with the model
    [self syncViewWithModel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        // Tenemos que poner un botón en mi barra
        // de navegación que permita mostrar el controlador
        // primario (el de la izquierda)
        self.navigationItem.rightBarButtonItem = splitVC.displayModeButtonItem;
    }
    
}



#pragma mark - MJSCLibraryViewControllerDelegate
-(void)libraryViewController:(UIViewController *)libraryVC didSelectBook:(MJSCBook *)book indexPath:(NSIndexPath *)indexPath{
    
    // Update the model
    self.book = book;
    
    // Update the view
    
    [self syncViewWithModel];
}

#pragma mark - Utils
-(void)syncViewWithModel {
    
    self.bookTitle.text = self.book.title;
    self.bookAuthor.text = self.book.author;
    self.bookCategory.text = self.book.category;
    self.bookSummary.text = self.book.summary;
    
  
    __weak typeof (self) weakSelf = self;
    [self.book image:^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.bookImage.image = self.book.image;
    }];
    
}


@end
