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


-(id)initWithBooks {
    
    if (self = [super init]) {
        // Init with all books
        _library = [self loadBooks];
    }
    
    return self;
}

-(NSUInteger)sectionCount {
    return [self.library count];
}


-(NSUInteger)countBooksAtSection:(NSUInteger) section {
    return [[self.library objectForKey:[self sectionKeyForSection:section]] count];
}


-(MJSCBook *)bookAtSection:(NSInteger) section
                      index:(NSUInteger) index {
    MJSCBook *book = [[self.library objectForKey:[self sectionKeyForSection:section]] objectAtIndex:index];
    return book;
}


-(NSString *)sectionTitle:(NSUInteger)section {
    return [self sectionKeyForSection:section];
}

-(NSString *)sectionKeyForSection:(NSUInteger)section {
    return [[self.library allKeys] objectAtIndex:section];
}


-(NSDictionary*)loadBooks {
    
    NSMutableDictionary *library = [[NSMutableDictionary alloc] init];
    
    // Create the library grouy by categories
    for (MJSCBook *book in [self createBooks]) {
        
        // Search the category in the dictionary
        NSMutableArray *array = [library objectForKey:[book category]];
        
        // The category doesn't existe, create it
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
        
        // Add the book to the category
        [array addObject:book];
        
        // Add the category with it's books to the library
        [library setObject:array forKeyedSubscript:[book category]];
        
    }
    
    
    return [library copy];
}


#pragma mark - Utils

-(NSArray*)createBooks {
    
    NSString *summary = @"Git is the version control system developed by Linus Torvalds for Linux kernel development. It took the open source world by storm since its inception in 2005, and is used by small development shops and giants like Google, Red Hat, and IBM, and of course many open source projects.\nA book by Git experts to turn you into a Git expert.\nIntroduces the world of distributed version control.\nShows how to build a Git development workflow.\n What you’ll learn\nUse Git as a programmer or a project leader\n Become a fluent Git user\n Use distributed features of Git to the full\n Acquire the ability to insert Git in the development workflow\n Migrate programming projects from other SCMs to Git\n Learn how to extend Git\n\n\nWho this book is for\n\nThis book is for all open source developers: you are bound to encounter Git somewhere in the course of your working life. Proprietary software developers will appreciate Git’s enormous scalability, since it is used for the Linux project, which comprises thousands of developers and testers.\n\n\nTable of Contents:\n Getting Started\n Git Basics\n Git Branching\n Git on the Server\n Distributed Git\n Git Tools\n Customizing Git\n Git and Other Systems\n Git Internals";
  
    
    MJSCBook *book1 = [[MJSCBook alloc] initWithTitle:@"Pro GIT"
                                             subtitle:@"Professional version control"
                                               author:@"Scott Chacon"
                                              summary:summary
                                             category:@"Version control"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/ec/87/ec87afb1068d1993b543e2a4eb4ebd6f.jpg"]                                              URL:[NSURL URLWithString:@"https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf"]];
    
    
    summary = @"This book uses practical examples to explain version control with both centralized and decentralized systems. Topics covered include:\nBasic version control commands and concepts\nIntroduction to Distributed Version Control Systems (DVCS)\nAdvanced branching workflows\nStrengths and weaknesses of DVCS vs. centralized tools\nBest practices\nHow distributed version control works under the hood\n\nFeaturing these open source version control tools:\nApache Subversion\nMercurial\nGit\nVeracity";
    
    MJSCBook *book2 = [[MJSCBook alloc] initWithTitle:@"Version Control by Example"
                                             subtitle:@"Practical examples to explain version control with both centralized and decentralized systems"
                                               author:@"Eric Sink"
                                              summary:summary
                                             category:@"Version control"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/09/85/0985f617a7e7912300ddcf25fbd60b89.jpg"]                                               URL:[NSURL URLWithString:@"http://ericsink.com/vcbe/vcbe_usletter_lo.pdf"]];
    
    
    summary = @"Multiagent systems consist of multiple autonomous entities having different information and/or diverging interests. This comprehensive introduction to the field offers a computer science perspective, but also draws on ideas from game theory, economics, operations research, logic, philosophy and linguistics. It will serve as a reference for researchers in each of these fields, and be used as a text for advanced undergraduate and graduate courses.\n\nEmphasizing foundations, the authors offer a broad and rigorous treatment of their subject, with thorough presentations of distributed problem solving, non-cooperative game theory, multiagent communication and learning, social choice, mechanism design, auctions, coalitional game theory, and logical theories of knowledge, belief, and other aspects of rational agency. For each topic, basic concepts are introduced, examples are given, proofs of key results are offered, and algorithmic considerations are examined. An appendix covers background material in probability theory, classical logic, Markov decision processes, and mathematical programming.";
    
    MJSCBook *book3 = [[MJSCBook alloc] initWithTitle:@"Multiagent Systems"
                                             subtitle:@"Algorithmic, Game-Theoretic, and Logical Foundations"
                                               author:@"Yoav Shoham, Kevin Leyton-Brown"
                                              summary:summary
                                             category:@"Algorithms"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/7b/a8/7ba8fc00e7e700d26ea0aaf3f3e48cbb.jpg"]                                               URL:[NSURL URLWithString:@"http://www.masfoundations.org/mas.pdf"]];
    
    
    summary = @"In the last few years game theory has had a substantial impact on computer science, especially on Internet- and e-commerce-related issues. More than 40 of the top researchers in this field have written chapters that go from the foundations to the state of the art. Basic chapters on algorithmic methods for equilibria, mechanism design and combinatorial auctions are followed by chapters on incentives and pricing, cost sharing, information markets and cryptography and security. Students, researchers and practitioners alike need to learn more about these fascinating theoretical developments and their widespread practical application.";
    
    MJSCBook *book4 = [[MJSCBook alloc] initWithTitle:@"Algorithmic Game Theory"
                                             subtitle:nil
                                               author:@"Noam Nisan, Tim Roughgarden, Eva Tardos, Vijay V. Vazirani"
                                              summary:summary
                                             category:@"Algorithms"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/29/eb/29ebffb20b4afc94ffe2c0abf9080f86.jpg"]                                               URL:[NSURL URLWithString:@"http://www.cambridge.org/journals/nisan/downloads/Nisan_Non-printable.pdf"]];
    
    
    summary = @"A couple weeks ago I released mongly.com. The feedback has been great, but I've noticed that a lot of people still have some fundamental questions about MongoD\n\nI hope you like it and that it proves useful. You can download the PDF version here. It comes it at a respectable 32 pages. I tried to cover a number of topics with a focus on the fundamentals you'll need to get comfortably up and running.\n\nI wrote it in markdown, the source is available on github. PanDoc was used to convert the book. The process was painless after a couple attempts. I'm also quite happy with the output (especially in comparison to how much work went into perfectly formatting Foundations of Programming using Word)\n\nFor the curious, the idea to write this hit me while I was going to sleep last Saturday. A little over half the book was written on Sunday, in around 4-5 hours. The MapReduce chapter was taken from a blog post I had already written (with necessary tweaks). Perry Neal provided some really quick turn arouns for initial edits/feedback. Of course, given the speed at which this was done, corrections and feedback are welcomed in any format (email, comment, pull requests).";
    
    MJSCBook *book5 = [[MJSCBook alloc] initWithTitle:@"The Little MongoDB Book"
                                             subtitle:@"Kick-off MongoDB in only 32 pages"
                                               author:@"Karl Seguin"
                                              summary:summary
                                             category:@"Databases"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/02/28/0228bd481dc84f0b9b689716cb5ed026.jpg"]                                               URL:[NSURL URLWithString:@"http://openmymind.net/mongodb.pdf"]];

    
    summary = @"Introduction to Redis versatile key-value store.";
    
    MJSCBook *book6 = [[MJSCBook alloc] initWithTitle:@"The Little Redis Book"
                                             subtitle:nil
                                               author:@"Karl Seguin"
                                              summary:summary
                                             category:@"Databases"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/d8/cf/d8cfbb4a5cedf6da4777ad855df682e4.jpg"]                                               URL:[NSURL URLWithString:@"http://openmymind.net/redis.pdf"]];
    
    
    
    summary = @"This free, Creative Commons-licensed e-book explains important data concepts in simple language. Think of it as an in-depth data FAQ for graphic designers, content producers, and less-technical folks who want some extra help knowing where to begin, and what to watch out for when visualizing information.";
    
    MJSCBook *book7 = [[MJSCBook alloc] initWithTitle:@"Data + Design"
                                             subtitle:@"A Simple Introduction to Preparing and Visualizing Information"
                                               author:@"Trinna Chiasson, Dyanna Gregory, Contributors"
                                              summary:summary
                                             category:@"Design"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/d5/c1/d5c1bb30894ecee940da27d00c0498ed.jpg"]                                               URL:[NSURL URLWithString:@"http://orm-atlas2-prod.s3.amazonaws.com/pdf/13a07b19e01a397d8855c0463d52f454.pdf"]];
    

    
    
    summary = @"The Shape of Design is a book about design as a method to plan and create change. It documents the hidden steps, methods, and thoughts of the creative process to produce a field guide for the emerging skillset: improvising, creating frameworks, storytelling, and delighting audiences.\n\nIt’s a handbook that explores the qualities that make for great design so we may dream big, apply the lessons to our processes, then go get our hands dirty to shape this world.";
    
    MJSCBook *book8 = [[MJSCBook alloc] initWithTitle:@"The Shape of Design"
                                             subtitle:nil
                                               author:@"Frank Chimero"
                                              summary:summary
                                             category:@"Design"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/90/d4/90d42308f9587b08d434ae8da431bb7d.jpg"]                                               URL:[NSURL URLWithString:@"http://jd2-6e123c3050aad9e7c1cd563383a2f9e5-us.s3.amazonaws.com/sod/PDF-The-Shape-of-Design-v1.01.pdf"]];


    summary = @"A non-commercial, community-driven overview on mobile technologies for developers and decision-makers. Gets updated continuously, 9 editions came out in less than 3 years. Check www.mobiledevelopersguide.com for latest issue.";
    
    MJSCBook *book9 = [[MJSCBook alloc] initWithTitle:@"Mobile Developer's Guide To The Galaxy"
                                             subtitle:nil
                                               author:@"Robert Virkus, Marco Tabor, Thibaut Rouffineau, Alexander Repty, Roland Gülle, Gary Johnson and many more"
                                              summary:summary
                                             category:@"Mobile apps"
                                             imageURL:[NSURL URLWithString:@"http://enough.de/fileadmin/_processed_/csm_App_Developer_Guide_15thEdition_05db326d3e.jpg"]                                               URL:[NSURL URLWithString:@"http://enough.de/fileadmin/user_upload/Developer_Guide/Mobile_Developers_Guide_15th.pdf"]];
    
    
    summary = @"An introduction to programming in Go and general programming for beginners using Go. The book is free to read online and will be available on Amazon.";
    
    MJSCBook *book10 = [[MJSCBook alloc] initWithTitle:@"An Introduction to Programming in Go"
                                             subtitle:nil
                                               author:@"Caleb Doxsey"
                                              summary:summary
                                             category:@"Go"
                                             imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/09/ad/09ad5199bbacbc8180465378365e8b4e.jpg"]                                               URL:[NSURL URLWithString:@"http://www.golang-book.com/assets/pdf/gobook.pdf"]];
    
    
    
    summary = @"The Little Go Book is a free introduction to Google's Go programming language. It's aimed at developers who might not be quite comfortable with the idea of pointers and static typing. It's longer than the other Little books, but hopefully still captures that little feeling.";
    
    MJSCBook *book11 = [[MJSCBook alloc] initWithTitle:@"The Little Go Book"
                                              subtitle:nil
                                                author:@"Karl Seguin"
                                               summary:summary
                                              category:@"Go"
                                              imageURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/fd/6a/fd6a2f610226dffb29fca630b25c1858.jpg"]                                               URL:[NSURL URLWithString:@"http://openmymind.net/assets/go/go.pdf"]];
    
    
    NSArray *books = @[book1, book2, book3, book4, book5, book6, book7, book8, book9, book10, book11];
    
    return books;
    
}


@end
