// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.m instead.

#import "_Book.h"

const struct BookAttributes BookAttributes = {
	.author = @"author",
	.bookID = @"bookID",
	.category = @"category",
	.createdAt = @"createdAt",
	.imageURL = @"imageURL",
	.path = @"path",
	.subtitle = @"subtitle",
	.summary = @"summary",
	.title = @"title",
	.updatedAt = @"updatedAt",
	.url = @"url",
};

const struct BookRelationships BookRelationships = {
	.book_notes = @"book_notes",
};

@implementation BookID
@end

@implementation _Book

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (BookID*)objectID {
	return (BookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic author;

@dynamic bookID;

@dynamic category;

@dynamic createdAt;

@dynamic imageURL;

@dynamic path;

@dynamic subtitle;

@dynamic summary;

@dynamic title;

@dynamic updatedAt;

@dynamic url;

@dynamic book_notes;

- (NSMutableSet*)book_notesSet {
	[self willAccessValueForKey:@"book_notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"book_notes"];

	[self didAccessValueForKey:@"book_notes"];
	return result;
}

@end

