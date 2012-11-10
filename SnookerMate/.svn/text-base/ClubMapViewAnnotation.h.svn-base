//
//  ClubMapViewAnnotation.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Club.h"

@interface ClubMapViewAnnotation : NSObject <MKAnnotation> 

// Elements for the Club Map Pin
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) Club *club;

// Sets the tyitle
- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d andClub:(Club *)c;

@end