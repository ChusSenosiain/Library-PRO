//
//  MJSCNoteViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/08/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNoteViewController.h"
#import "Book.h"
#import "Note.h"
#import "MJSCCoreDataStack.h"

@interface MJSCNoteViewController ()

@property (strong, nonatomic) Book *book;
@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) Note *note;
@property (strong, nonatomic) MJSCCoreDataStack *coreStack;

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookPage;
@property (weak, nonatomic) IBOutlet UILabel *updatedDate;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *noteAddress;

@end

@implementation MJSCNoteViewController

-(id)initWithBook:(Book*)book
             page:(NSUInteger)page{

    if (self = [super init]) {
        _book = book;
        _page = page;
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

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Utils
-(void)configureView {
    
    // Disable default behavior for IOS7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'/'MM'/'dd' at 'HH':'mm'"];

    
    if (self.note) {
        
        self.noteTitle.text = [self.note title];
        self.noteText.text = [self.note text];
        
        self.bookTitle.text = [self.note.note_book title];
        self.noteAddress.text = [self.note address];
        self.bookPage.text = [NSString stringWithFormat:@"%li", self.page];
        
        
        self.updatedDate.text = [dateFormatter stringFromDate:[self.note updatedAt]];
        self.bookAuthor.text = [self.note.note_book author];
        
    } else if (self.book) {
        
        self.bookTitle.text = [self.book title];
        self.bookPage.text = [NSString stringWithFormat:@"%li", self.page];
       
        self.updatedDate.text = [dateFormatter stringFromDate:[NSDate date]];
        self.bookAuthor.text = [self.book author];

        
    }
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
}


-(IBAction)saveNote:(id)sender {
    
    // Load note data
    if (!self.note) {
        
        self.note = [Note noteWithContext:self.coreStack.managedObjectContext
                                  address:nil
                                 bookPage:[NSNumber numberWithLong:self.page]
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
    self.note.bookPage = [NSNumber numberWithLong:(self.page)];

    [self.coreStack saveContext];

    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.note = nil;
}


@end
