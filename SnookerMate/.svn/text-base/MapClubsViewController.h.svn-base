//
//  MapClubsViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Club.h"

@interface MapClubsViewController : UIViewController <MKMapViewDelegate>

// GUI elements
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

// Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Club *selectedClub;

// Methods
-(IBAction)showDetails:(id)sender;
-(void) update;
@end
