//
//  DisplayClubViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Club.h"

@interface DisplayClubViewController : UIViewController <MKMapViewDelegate>

// Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) Club *club;

// GUI Elements
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UILabel *clubNameLabel;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

// Methods
-(IBAction)deleteButtonPressed;
-(void) editButtonPressed;

@end
