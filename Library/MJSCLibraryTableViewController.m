//
//  MJSCLibraryTableViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBook.h"
#import "MJSCLibraryTableViewController.h"
#import "MJSCBookDetailsViewController.h"
#import "MJSCLibrary.h"
#import "MJSCLibraryTableViewCell.h"
#import "MJSCLibraryHeaderCollectionReusableView.h"


@interface MJSCLibraryTableViewController ()

@property(nonatomic, strong) MJSCLibrary *library;

@end

@implementation MJSCLibraryTableViewController

-(id)initWithModel:(MJSCLibrary *)library {
    
    if (self = [super init]) {
        _library = library;
        
    }
    
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.library sectionCount];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.library countBooksAtSection:section];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MJSCLibraryTableViewCell height];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    MJSCBook *book = [self.library bookAtSection:indexPath.section index:indexPath.row];
    
    // Create the cell
    MJSCLibraryTableViewCell *bookCell =[tableView dequeueReusableCellWithIdentifier:[MJSCLibraryTableViewCell cellId] forIndexPath:indexPath];
    
    bookCell.bookTitle.text = book.title;
    bookCell.bookAuthor.text = book.author;
    bookCell.bookImage.image = nil;
    
    
    if (book.image) {
        bookCell.bookImage.image = book.image;
    } else {
         [book image:^{
            // Comprobar que la celda esta visible
            if([tableView.indexPathsForVisibleRows containsObject:indexPath]) {
                // hacer el reload
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        
    }
    
    
    return bookCell;
}


-(NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    return [self.library sectionTitle:section];
}


#pragma mark - TablewView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    MJSCBook *book = [self.library bookAtSection:indexPath.section index:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    }
    
}


#pragma mark - Utils
-(void) registerNibs{
    
    [self.tableView registerNib:[UINib nibWithNibName:[MJSCLibraryTableViewCell cellId] bundle:nil]
         forCellReuseIdentifier:[MJSCLibraryTableViewCell cellId]];
    
 }






@end
