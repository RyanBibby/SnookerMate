//
//  ClubMapViewAnnotation.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "ClubMapViewAnnotation.h"
@implementation ClubMapViewAnnotation

@synthesize title, coordinate, club;

// Sets title, club and location
- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d andClub:(Club *)c {
	self = [super init];
	title = [ttl retain];
	coordinate = c2d;
    club = [c retain];
    
	return self;
}

- (void)dealloc {
	[title release];
	[club release];
	[super dealloc];
}

@end