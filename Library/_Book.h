// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.h instead.

#import <CoreData/CoreData.h>

extern const struct BookAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *bookID;
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *path;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *summary;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *updatedAt;
	__unsafe_unretained NSString *url;
} BookAttributes;

extern const struct BookRelationships {
	__unsafe_unretained NSString *book_notes;
} BookRelationships;

@class Note;

@interface BookID : NSManagedObjectID {}
@end

@interface _Book : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BookID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* bookID;

//- (BOOL)validateBookID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageURL;

//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* path;

//- (BOOL)validatePath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* subtitle;

//- (BOOL)validateSubtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* summary;

//- (BOOL)validateSummary:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* updatedAt;

//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *book_notes;

- (NSMutableSet*)book_notesSet;

@end

@interface _Book (Book_notesCoreDataGeneratedAccessors)
- (void)addBook_notes:(NSSet*)value_;
- (void)removeBook_notes:(NSSet*)value_;
- (void)addBook_notesObject:(Note*)value_;
- (void)removeBook_notesObject:(Note*)value_;

@end

@interface _Book (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveBookID;
- (void)setPrimitiveBookID:(NSString*)value;

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;

- (NSString*)primitivePath;
- (void)setPrimitivePath:(NSString*)value;

- (NSString*)primitiveSubtitle;
- (void)setPrimitiveSubtitle:(NSString*)value;

- (NSString*)primitiveSummary;
- (void)setPrimitiveSummary:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (NSMutableSet*)primitiveBook_notes;
- (void)setPrimitiveBook_notes:(NSMutableSet*)value;

@end
