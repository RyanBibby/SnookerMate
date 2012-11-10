//
//  AddClubViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "Club.h"

@interface AddClubViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate>

// Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Club *club;

// GUI elements
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UIButton *updateButton;
@property (nonatomic, retain) IBOutlet UIButton *randomButton;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

// Location properties
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *mapPointer;

// Button methods
-(void)saveButtonPressed;
-(IBAction)updateButtonPressed;
-(IBAction)randomButtonPressed;
- (void)addPinWithLat:(float)lat andLong:(float)lon;
@end
