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

@interface MJSCNoteViewController ()

@property (strong, nonatomic) Book *book;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) Note *note;
@end

@implementation MJSCNoteViewController

-(id)initWithBook:(Book*)book
             page:(NSInteger)page{

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



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
