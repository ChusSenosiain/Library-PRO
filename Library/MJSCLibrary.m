//
//  MJSCLibrary.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 14/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibrary.h"
#import "MJSCBook.h"

@implementation MJSCLibrary


-(id) initWithBooks {
    
    if (self = [super init]) {
        // Init with all books
        _library = [self loadBooks];
    }
    
    return self;
}

-(NSUInteger) sectionCount {
    return [self.library count];
}




-(NSUInteger) countBooksAtSection:(NSString *) section {
    return [[self.library objectForKey:section] count];
}


-(MJSCBook *) bookAtSection:(NSString *) section
                      index:(NSUInteger) index {
    MJSCBook *book = [[self.library objectForKey:section] objectAtIndex:index];
    return book;
}


-(NSDictionary*) loadBooks {
    
    NSMutableDictionary *library = [[NSMutableDictionary alloc] init];
    
    // Crear la libreria ordenada por las categorias de los libros
    for (MJSCBook *book in [self createBooks]) {
        
        // buscar en el diccionario si existe la categoria
        NSMutableArray *array = [library objectForKey:[book category]];
        
        // Si no existe la categoria la creo
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        
        // Añado el libro a la categoria
        [array addObject:book];
        
        // Añado la categoria con sus libros a la librería
        [library setObject:array forKeyedSubscript:[book category]];
        
    }
    
    
    return library;
}


-(NSArray*) createBooks {
    
    MJSCBook *book1 = [[MJSCBook alloc] initWithTitle:@"Pro GIT" author:@"Scott Chacon" category:@"Version Control"];
    MJSCBook *book2 = [[MJSCBook alloc] initWithTitle:@"Twiter Data Analytics" author:@"Shamanth Kumar, Fred Morstatter, and Huan Liu" category:@"Data mining"];
    MJSCBook *book3 = [[MJSCBook alloc] initWithTitle:@"Pro GIT" author:@"Scott Chacon" category:@"Version Control"];
    MJSCBook *book4 = [[MJSCBook alloc] initWithTitle:@"Twiter Data Analytics" author:@"Shamanth Kumar, Fred Morstatter, and Huan Liu" category:@"Data mining"];
    
    
    NSArray *books = @[book1, book2, book3, book4];
    
    return books;
    
}


@end
