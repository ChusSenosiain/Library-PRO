//
//  MJSCNotesTableViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNotesTableViewController.h"
#import "MJSCNoteTableViewCell.h"
#import "MJSCNoteViewController.h"
#import "Note.h"
#import "Book.h"
#import "MJSCCoreDataStack.h"
#import "MJSCCoreDataManager.h"
#import "MJSCNotesMapViewController.h"
#import "MJSCTableViewHeader.h"


@interface MJSCNotesTableViewController ()
@property(nonatomic, strong) Book *book;

@end

@implementation MJSCNotesTableViewController


-(id)initWithBook:(Book*)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerNibs];
    
    if (self.book) {
        MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
        self.fetchedResultsController = [coreManager fetchedResultsControllerBookNotes:self.book];
        
    }
    
}

#pragma mark - TablewViewDelegate

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJSCNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MJSCNoteTableViewCell cellId] forIndexPath:indexPath];
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureWithNote:note];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(didSelectNote:)]) {
        [self.delegate didSelectNote:note];
    } else {
        MJSCNoteViewController *noteVC = [[MJSCNoteViewController alloc] initWithNote:note];
        [self.navigationController pushViewController:noteVC animated:YES];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MJSCNoteTableViewCell height];
}


#pragma mark - Utils

-(void) registerNibs{
    
    // Cell
    UINib *nib = [UINib nibWithNibName:[MJSCNoteTableViewCell cellId] bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:[MJSCNoteTableViewCell cellId]];
    
    
    // Header
    // Header
    [self.tableView registerNib:[UINib nibWithNibName:[MJSCTableViewHeader headerID] bundle:nil]
         forCellReuseIdentifier:[MJSCTableViewHeader headerID]];

}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"Han modificado la nota con este nuevo valor %@", [change objectForKey:NSKeyValueChangeNewKey]);
    
    
}


@end
