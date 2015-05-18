//
//  MJSCBook.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCBook.h"
#import <AFNetworking.h>

@implementation MJSCBook

-(id)initWithTitle:(NSString *) title
          subtitle:(NSString *) subtitle
            author:(NSString *) author
           summary:(NSString *) summary
          category:(NSString *) category
          imageURL:(NSURL *) imageURL
               URL:(NSURL *) URL; {
    
    if (self = [super init]) {
        _title = title;
        _subtitle = subtitle;
        _author = author;
        _summary = summary;
        _category = category;
        _imageURL = imageURL;
        _URL = URL;
    }
    
    return self;
}



-(void)image:(void (^)())completionBlock{
   
    NSLog(@"Book image from %@:", self.title);
    
    if (self.image) {
        NSLog(@"The book has an image");
        completionBlock();
    }else{
        // Get the image from cache
        self.image = [UIImage imageWithContentsOfFile:[self cachePath:[self.imageURL lastPathComponent]]];
        
        //NSString *path = [self cachePath:[self.imageURL lastPathComponent]];
        //NSData *imgData = [[NSData alloc] initWithContentsOfFile:path];
        //self.image = [[UIImage alloc] initWithData:imgData];
        
        if (self.image) {
            NSLog(@"Getting the image from cache");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
            
        } else {
            NSLog(@"Downloading image from URL");
            __weak typeof(self) weakSelf = self;
            
            dispatch_async(dispatch_queue_create("cola", NULL), ^{
                __strong typeof(self) strongSelf = weakSelf;
               UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
                if (image) {
                    // Save in cache
                    [strongSelf saveImageCache:image file:[strongSelf cachePath:[self.imageURL lastPathComponent]]];
                    
                    // Assign image to self
                    strongSelf.image = image;
                }
                
                // Return the result
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(image);
                });
            });
        }
    }
}



-(NSString *)cachePath:(NSString *) fileName {
    
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [[cacheDir stringByAppendingString:@"/" ] stringByAppendingString:fileName];
}


-(void)saveImageCache:(UIImage *) image
                 file:(NSString *) file {
    
    NSString *fileExtension = [file pathExtension];
    
    if ([fileExtension isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:file atomically:YES];
    } else {
        [UIImageJPEGRepresentation(image, 1) writeToFile:file atomically:YES];;
    }
    
    
}




@end
