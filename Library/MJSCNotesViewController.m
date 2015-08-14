//
//  MJSCNotesViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNotesViewController.h"
#import "MJSCNoteTableViewCell.h"
#import "MJSCNoteViewController.h"
#import "Note.h"
#import "Book.h"
#import "MJSCCoreDataStack.h"
#import "MJSCCoreDataManager.h"


@interface MJSCNotesViewController ()
@property(nonatomic, strong) Book *book;

@end

@implementation MJSCNotesViewController


-(id)initWithBook:(Book*)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerNibs];
    
    [self configureView];
    
    
    if (self.book) {
    
       
        MJSCCoreDataStack *coreStack = [MJSCCoreDataStack sharedInstance];
        
        Note *note = [Note noteWithContext:coreStack.managedObjectContext
                                   address:nil
                                  bookPage:0
                                 createdAt:[NSDate date]
                                     image:nil latitude:@0.0
                                 longitude:@0.0
                                      text:@"texto nota"
                                     title:@"title"
                                 updatedAt:[NSDate date]];
        
        note.note_book = self.book;
        
        [coreStack saveContext];
        
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
    
    MJSCNoteViewController *noteVC = [[MJSCNoteViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:noteVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MJSCNoteTableViewCell height];
}


#pragma mark - Utils

-(void) registerNibs{
    UINib *nib = [UINib nibWithNibName:[MJSCNoteTableViewCell cellId] bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:[MJSCNoteTableViewCell cellId]];
}


-(void)configureView{
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
 
}


-(IBAction)addNote:(id)sender {
    
    MJSCNoteViewController *noteVC = [[MJSCNoteViewController alloc] init];
    [self.navigationController pushViewController:noteVC animated:YES];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NoteViewController *noteVC = segue.destinationViewController;
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    Note *selectedNote = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
    
    // Le paso la nota al siguiente view controller
    noteVC.note = selectedNote;
    
    // KVO - Enterarse de que el titulo de la nota ha cambiado
    
    [selectedNote addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}
*/

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"Han modificado la nota con este nuevo valor %@", [change objectForKey:NSKeyValueChangeNewKey]);
    
    
}

/*

- (IBAction)addNote:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Note *note  = [Note noteWithContext:appDelegate.managedObjectContext title:@"Nueva nota" text:nil];
    note.notebook = self.notebook;
}
 */

@end
