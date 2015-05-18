//
//  MJSCBookPDFViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 15/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBookPDFViewController.h"
#import "MJSCLibraryViewController.h"
#import "MJSCBook.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Settings.h"

@interface MJSCBookPDFViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (nonatomic, strong) MJSCBook *book;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@end

@implementation MJSCBookPDFViewController

-(id)initWithBook:(MJSCBook *)book {
    
    if (self = [super init]) {
        _book = book;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Eliminamos comportamiento por defcto de iOS 7
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.browser.delegate = self;
    self.browser.scalesPageToFit = YES;
    
    [self syncViewWithModel];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Book change notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION
             object:nil];
    
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Cancel current PDF request
    if (self.requestOperation) {
        [self.requestOperation cancel];
        self.requestOperation = nil;
    }
    
    // Remove notification oberver
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(BOOL) webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    
    if ((navigationType == UIWebViewNavigationTypeLinkClicked) ||
        (navigationType == UIWebViewNavigationTypeFormSubmitted)){
        return NO;
    }else{
        return YES;
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}


#pragma mark - notification
// BOOK_DID_CHANGE_NOTIFICATION
-(void) notifyThatBookDidChange:(NSNotification *)n{
    
    NSDictionary *userInfo = n.userInfo;
    
    self.book = [userInfo objectForKey:BOOK_KEY];
    
    // Sync view with the new book
    [self syncViewWithModel];
    
    
}


#pragma mark - Utils
-(void)syncViewWithModel{
    
    // Cancel the request if it exists
    if (self.requestOperation) {
        [self.requestOperation cancel];
        self.requestOperation = nil;
    }
    
    // Verify if the PDF exists in cache
    // If exists load the PDF and exit
    if ([self fileExists:[self cacheFile:self.book.URL]]) {
        NSURL *url = [NSURL URLWithString:[self cacheFile:self.book.URL]];
        [self.browser loadRequest:[NSURLRequest requestWithURL:url]];
        return;
    }
    
    // Create the request
    NSURLRequest *request = [NSURLRequest requestWithURL:self.book.URL];
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Configure the download progress control
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading...";
    hud.detailsLabelText = @"0 %%";
    hud.color = UIColorFromRGB(0x536DFE);
    
    
     __weak typeof(self) weakSelf = self;
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // Hide the download progress control
        hud.hidden = YES;
    
        if ([responseObject isKindOfClass:[NSData class]]) {
           
            __strong typeof (self) strongSelf = weakSelf;
            if (strongSelf) {
                // Show the downloaded PDF
                [strongSelf.browser loadData:responseObject MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
                
                // Save it in cache
                [responseObject writeToFile:[strongSelf cacheFile:strongSelf.book.URL] atomically:YES];
            }
            
        } else {
            NSLog(@"Download error, the result isn't a NSData class");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hud.hidden = YES;
        NSLog(@"Download error: %@", error);
    }];
    
    
    [self.requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // Show the donwload progress
        float progress = (totalBytesRead / (float) totalBytesExpectedToRead);
        hud.progress = progress;
        hud.detailsLabelText = [NSString stringWithFormat:@"%.f %%", progress * 100];
        
    }];
    
    // Start PDF request opperation
    [self.requestOperation start];
    
    
}


#pragma mark - Utils

-(NSString*)cacheFile:(NSURL *)bookURL {
    
    NSString *fileName = [bookURL lastPathComponent];
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [[cacheDir stringByAppendingString:@"/" ] stringByAppendingString:fileName];
    
}

-(BOOL)fileExists:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:filePath];
}


@end
