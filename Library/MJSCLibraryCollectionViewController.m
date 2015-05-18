//
//  MJSCLibraryCollectionViewController.m
//  Library
//
//  Created by María Jesús Senosiain Caamiña on 13/05/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCLibraryCollectionViewController.h"
#import "MJSCLibraryCollectionViewCell.h"
#import "MJSCLibraryHeaderCollectionReusableView.h"
#import "MJSCBookDetailsViewController.h"
#import "MJSCLibrary.h"
#import "MJSCBook.h"

@interface MJSCLibraryCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *libraryCollectionView;
@property (nonatomic, strong) MJSCLibrary *library;

@end

@implementation MJSCLibraryCollectionViewController



-(id)initWithModel:(MJSCLibrary*)library {
    
    if (self = [super init]) {
        _library = library;
    }
    
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.library sectionCount];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.library countBooksAtSection:section];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    MJSCBook *book = [self.library bookAtSection:indexPath.section index:indexPath.row];
    
    // Create the cell
    MJSCLibraryCollectionViewCell *bookCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MJSCLibraryCollectionViewCell cellId] forIndexPath:indexPath];
    
    
    
    bookCell.bookTitle.text = book.title;
    bookCell.bookImage.image = nil;
    
    
    
    if (book.image) {
        bookCell.bookImage.image = book.image;
    } else {
        __weak typeof (self) weakSelf = self;
        [book image:^{
            __strong typeof (self) strongSelf = weakSelf;
             if([strongSelf.libraryCollectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                 [strongSelf.libraryCollectionView reloadItemsAtIndexPaths:@[indexPath]];
             }
        }];
        
    }
    
    return bookCell;

}


-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    MJSCLibraryHeaderCollectionReusableView *sectionHeader;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                           withReuseIdentifier:[MJSCLibraryHeaderCollectionReusableView headerID]
                                                                  forIndexPath:indexPath];
        
        [sectionHeader.sectionTitle setText:[self.library sectionTitle:indexPath.section]];
        
    }
    
    return sectionHeader;
}


#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    MJSCBook *book = [self.library bookAtSection:indexPath.section index:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    }
}



#pragma mark - Utils
-(void) registerNibs{
    
    // Cell nib
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:[MJSCLibraryCollectionViewCell cellId] bundle:nil]
                 forCellWithReuseIdentifier:[MJSCLibraryCollectionViewCell cellId]];
    
 
    
    // Header nib
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:[MJSCLibraryHeaderCollectionReusableView headerID]  bundle:nil]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:[MJSCLibraryHeaderCollectionReusableView headerID]];
    

 
}


// Hacer dinámico el tamaño de las celdas
-(CGSize) collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float boardWidth = self.libraryCollectionView.frame.size.width;
    
    float cellWidth = (boardWidth / 3) - 1;
    float cellHeight = cellWidth + (cellWidth / 2);
    
    return CGSizeMake(cellWidth, cellHeight);
}





@end
