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
#import "MJSCBookManager.h"
#import "MJSCCoreDataManager.h"
#import "Book.h"

@interface MJSCLibraryCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *libraryCollectionView;

@end

@implementation MJSCLibraryCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJSCCoreDataManager *coreManager = [[MJSCCoreDataManager alloc] init];
    self.fetchedResultsController = [coreManager fetchedResultsControllerBooks];
    self.libraryCollectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self registerNibs];
}


#pragma mark - CollectionView DataSource


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Create the cell and load the book data
    MJSCLibraryCollectionViewCell *bookCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MJSCLibraryCollectionViewCell cellId] forIndexPath:indexPath];
    [bookCell configureWithBook:book];
    
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
        
        [sectionHeader.sectionTitle setText:[[[self.fetchedResultsController sections] objectAtIndex:indexPath.section] name]];
        
    }
    
    return sectionHeader;
}




#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the book
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:indexPath:)]) {
        [self.delegate libraryViewController:self didSelectBook:book indexPath:indexPath];
    }
}


#pragma mark - Utils

-(void)registerNibs {
    
    // Cell nib
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:[MJSCLibraryCollectionViewCell cellId] bundle:nil]
                 forCellWithReuseIdentifier:[MJSCLibraryCollectionViewCell cellId]];
    
    // Header nib
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:[MJSCLibraryHeaderCollectionReusableView headerID]  bundle:nil]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:[MJSCLibraryHeaderCollectionReusableView headerID]];
    
}

// Dinamic size of cells
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UICollectionViewFlowLayout *flowLayout =  (id) self.libraryCollectionView.collectionViewLayout;
    
    float boardWidth = self.libraryCollectionView.frame.size.width;
    float cellWidth = (boardWidth / 2) - 1;
    float cellHeight = cellWidth + (cellWidth / 2);
    
    flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight);
    
    [flowLayout invalidateLayout];
}


@end
