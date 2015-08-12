// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Note.m instead.

#import "_Note.h"

const struct NoteAttributes NoteAttributes = {
	.address = @"address",
	.bookPage = @"bookPage",
	.createdAt = @"createdAt",
	.image = @"image",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.text = @"text",
	.updatedAt = @"updatedAt",
};

const struct NoteRelationships NoteRelationships = {
	.note_book = @"note_book",
};

@implementation NoteID
@end

@implementation _Note

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (NoteID*)objectID {
	return (NoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"bookPageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"bookPage"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic address;

@dynamic bookPage;

- (int64_t)bookPageValue {
	NSNumber *result = [self bookPage];
	return [result longLongValue];
}

- (void)setBookPageValue:(int64_t)value_ {
	[self setBookPage:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveBookPageValue {
	NSNumber *result = [self primitiveBookPage];
	return [result longLongValue];
}

- (void)setPrimitiveBookPageValue:(int64_t)value_ {
	[self setPrimitiveBookPage:[NSNumber numberWithLongLong:value_]];
}

@dynamic createdAt;

@dynamic image;

@dynamic latitude;

- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}

@dynamic longitude;

- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}

@dynamic text;

@dynamic updatedAt;

@dynamic note_book;

@end

