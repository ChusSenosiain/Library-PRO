//
//  MJSCNoteViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNoteViewController.h"
#import "MJSCNotesMapViewController.h"
#import "Book.h"
#import "Note.h"
#import "MJSCCoreDataStack.h"

@interface MJSCNoteViewController ()<MJSCNotesMapViewControllerDelegate>

@property (strong, nonatomic) Book *book;
@property (strong, nonatomic) Note *note;
@property (strong, nonatomic) MJSCCoreDataStack *coreStack;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *address;

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *updatedDate;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;
@property (weak, nonatomic) IBOutlet UILabel *adress;


@end

@implementation MJSCNoteViewController

-(id)initWithBook:(Book*)book{

    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}


-(id)initWithNote:(Note*)note {
    
    if (self = [super init]) {
        _note = note;
    }
    
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreStack = [MJSCCoreDataStack sharedInstance];
    
    [self configureView];
}



#pragma mark - Utils
-(void)configureView {
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'/'MM'/'dd' at 'HH':'mm'"];
    
    UIImage *image = [UIImage imageNamed:@"ic_place"];
    
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.btnMap setImage:image forState:UIControlStateNormal];
    [self.btnMap setTintColor:[UIColor blueColor]];
    
    
    if (self.note) {
        
        self.noteTitle.text = [self.note title];
        self.noteText.text = [self.note text];
        
        self.bookTitle.text = [self.note.note_book title];
        self.adress.text = [self.note address];
        self.updatedDate.text = [dateFormatter stringFromDate:[self.note updatedAt]];
        self.bookAuthor.text = [self.note.note_book author];
        
    } else if (self.book) {
        
        self.bookTitle.text = [self.book title];
        self.updatedDate.text = [dateFormatter stringFromDate:[NSDate date]];
        self.bookAuthor.text = [self.book author];

        
    }
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
}

#pragma mark - MJSCNotesMapViewControllerDelegate
-(void)didSelectLocation:(CLLocation *)location withAddress:(NSString *)address {
    
    self.location = location;
    self.address = address;
    
    self.adress.text = self.address;
}


# pragma mark - Actions

-(IBAction)saveNote:(id)sender {
    
    // Load note data
    if (!self.note) {
        
        self.note = [Note noteWithContext:self.coreStack.managedObjectContext
                                  address:nil
                                 bookPage:nil
                                createdAt:[NSDate date]
                                    image:nil
                                 latitude:@0.0
                                longitude:@0.0
                                     text:nil
                                    title:nil
                                updatedAt:[NSDate date]];
        
        self.note.note_book = self.book;
        
    }

    self.note.title = self.noteTitle.text;
    self.note.text = self.noteText.text;
    self.note.updatedAt = [NSDate date];
    self.note.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.note.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];

    [self.coreStack saveContext];

    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)showNoteInMap:(id)sender {
    
    
    MJSCNotesMapViewController *noteMapVC = [[MJSCNotesMapViewController alloc] initWithNote:self.note];
    noteMapVC.delegate = self;
    [self.navigationController  pushViewController:noteMapVC animated:YES];
    
}



@end
