//
//  AppDelegate.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "AppDelegate.h"
#import "MJSCLibrary.h"
#import "MJSCLibraryTableViewController.h"
#import "MJSCLibraryCollectionViewController.h"
#import "MJSCBookDetailsViewController.h"
#import "MJSCBook.h"
#import "Settings.h"

#import "MJSCLibraryViewController.h"

#import "UIViewController+Combinators.h"

#import <Parse/Parse.h>


@interface AppDelegate ()


@property(nonatomic,strong)UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Init parse
    [self configureParse];
    
    // Model 
    MJSCLibrary *library = [[MJSCLibrary alloc] initWithBooks];
    
    // Screen Type: UItableViewController or UICollectionView for iPhone or UISplitView for iPad
    UIDevice *dev = [UIDevice currentDevice];
    if ([dev userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self configureForiPadWithModel:library];
    } else {
        [self configureForiPhoneWithModel:library];
    }
    
    // App aspect
    [MJSCStyles configureAppearance];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma park -- App Configuration

-(void)configureForiPadWithModel:(MJSCLibrary*)library {
    MJSCBook *book = [self lastBookSelectedInLibrary:library];

    MJSCLibraryViewController *libraryVC = [[MJSCLibraryViewController alloc] initWithModel:library];
    MJSCBookDetailsViewController *bookDetailsVC = [[MJSCBookDetailsViewController alloc] initWithBook:book];
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    
    splitVC.viewControllers = @[[libraryVC wrappedInNavigation], [bookDetailsVC wrappedInNavigation]];
    
    [splitVC setDelegate:bookDetailsVC];
    
    [libraryVC setDelegate:bookDetailsVC];
    
    self.window.rootViewController = splitVC;

}

-(void)configureForiPhoneWithModel:(MJSCLibrary*)library {
    MJSCLibraryViewController *libraryVC = [[MJSCLibraryViewController alloc] initWithModel:library];
    UINavigationController *navVC = [libraryVC wrappedInNavigation];
    self.window.rootViewController = navVC;
}


-(void)configureParse {
    [Parse setApplicationId:@"ZKJq1pKzGnS0FNVo5XceDodJvXlKmqOJbXQt0npf"
                  clientKey:@"IpqLgPBbfBC0YP135Pfkr4k5Hrn79ZjcwdwcyLaj"];
}



# pragma mark - Utils

-(MJSCBook*) lastBookSelectedInLibrary:(MJSCLibrary*) library {
    // Obtain the last book selected
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    // Is the first time that app starts, assign defaul book (the first one)
    if (![def objectForKey:LAST_SELECTED_BOOK_KEY]) {
        [def setObject:@[@0,@0] forKey:LAST_SELECTED_BOOK_KEY];
        [def synchronize];
    }
    
    NSArray *coords = [def objectForKey:LAST_SELECTED_BOOK_KEY];
    NSUInteger section = [[coords objectAtIndex:0] integerValue];
    NSUInteger row = [[coords objectAtIndex:1] integerValue];
    
    MJSCBook *book = [library bookAtSection:section index:row];
    
    return book;
}

@end
