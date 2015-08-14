//
//  MJSCLibraryTableViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "Book.h"
#import "MJSCLibraryTableViewController.h"
#import "MJSCBookDetailsViewController.h"
#import "MJSCBookManager.h"
#import "MJSCLibraryTableViewCell.h"
#import "MJSCTableViewHeader.h"
#import "MJSCLibraryHeaderCollectionReusableView.h"
#import "MJSCCoreDataManager.h"

@interface MJSCLibraryTableViewController ()

@property(strong, nonatomic) MJSCBookManager *library;

@end

@implementation MJSCLibraryTableViewController

-(id)initWithModel:(MJSCBookManager *)library {

    if (self = [super init]) {
        _library = library;
    }

    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
    self.fetchedResultsController = [coreManager fetchedResultsControllerBooks];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self registerNibs];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureView];
}

#pragma mark - TableView DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [MJSCLibraryTableViewCell height];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [MJSCTableViewHeader height];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Create the cell and load the book data
    MJSCLibraryTableViewCell *bookCell =[tableView dequeueReusableCellWithIdentifier:[MJSCLibraryTableViewCell cellId] forIndexPath:indexPath];
    [bookCell configureWithBook:book];
    
    return bookCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MJSCTableViewHeader *headerCell = [tableView dequeueReusableCellWithIdentifier:[MJSCTableViewHeader headerID]];
    
    headerCell.sectionTitle.text = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    
    return headerCell;
}


#pragma mark - TablewView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Set the book and indexpath to the delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    }
}


#pragma mark - Utils
-(void)registerNibs {
    
    // Cell
    [self.tableView registerNib:[UINib nibWithNibName:[MJSCLibraryTableViewCell cellId] bundle:nil]
         forCellReuseIdentifier:[MJSCLibraryTableViewCell cellId]];
    
    // Header
    [self.tableView registerNib:[UINib nibWithNibName:[MJSCTableViewHeader headerID] bundle:nil]
         forCellReuseIdentifier:[MJSCTableViewHeader headerID]];

}

-(void)configureView {
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}




@end
