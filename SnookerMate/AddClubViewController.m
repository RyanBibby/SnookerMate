//
//  AddClubViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "AddClubViewController.h"
#import "ClubMapViewAnnotation.h"
#import "MapCentre.h"

@implementation AddClubViewController

@synthesize managedObjectContext, nameField, club, updateButton, randomButton, mapView, locationManager, mapPointer;

// Init the view with no club, this sets it into add more. Set an empty mapPointer
-(id)init {
    self = [super init];
    if (self) {
        club = nil;
        mapPointer = [[CLLocation alloc] init];
    }
    
    return self;    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


// Once the save button (In the Navigation) is pressed -
// - Check if we are in add or update mode. This depends on if the club is set or not
// - Update the namne
// - If the mapPointer is set, then update the lat and long values
// - Confirm that the Club is valid before trying to save
// - If valid then save the club and pop back to the previous view
//
-(void)saveButtonPressed {
    BOOL createMode = NO;
    if (self.club == nil) {
        createMode = YES;
        // Create a new club object for CoreData
        self.club = (Club *) [NSEntityDescription insertNewObjectForEntityForName:@"Club" inManagedObjectContext:managedObjectContext];

    }
    // Set the name
    [self.club setName: self.nameField.text];
    
    // Set the lat and long
    if (self.mapPointer != nil) {
        [self.club setLatitude: [NSNumber numberWithFloat:mapPointer.coordinate.latitude]];
        [self.club setLongitude: [NSNumber numberWithFloat:mapPointer.coordinate.longitude]];
    }

    // Check the club is valud    
    NSString *errorMessage = [self.club hasValidName];
    if (errorMessage != nil) {
        // Display a error message saying what went wrong
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Error"];
        [alert setMessage:errorMessage];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert release];
        [self.managedObjectContext rollback];
        
        //Club was not created, reset back to nil
        if (createMode) {
            self.club = nil;
        }
    } else {
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            //This error case should never be triggered.
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Fatal Error"];
            [alert setMessage:@"Unknown error, please try again."];
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            [alert release];
            [self.managedObjectContext rollback];      
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}

// Once the update location button is pressed -
// - Attempt to gain access to the devices location
// - Display a message asking the user to enable if disabled
// - Deleagte to self, and ask for the best Accuracy
-(void) updateButtonPressed {
    
    if ([CLLocationManager locationServicesEnabled]==YES) {

        // Setup location manager
        if (locationManager==nil) {
            locationManager = [[CLLocationManager alloc]init];  
        }  
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];
        
    } else {
        
        // Ask user nicely to enable
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Disabled" message:@"Please enable Location in Settings." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];    
        
        [alert show];
        [alert release];
        
    }
}

// Due to the fact that the Simulator does not allow location to be turned on
// A button has been added to generate a random location on the map.
// Acts like the updateButtonPressed, but gives a random lat and long
-(void) randomButtonPressed {
    
    // Remove any current annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // Pick 2 random numbers
    srandom(time(NULL));
    float bigNumber = 58.0f;
    float smallNumber = 45.0f;
    
    float diff = bigNumber - smallNumber;
    float lat = (((float) random() / RAND_MAX) * diff) + smallNumber;
    
    bigNumber = 5.0f;
    smallNumber = -9.0f;
    
    diff = bigNumber - smallNumber;
    float lon = (((float) random() / RAND_MAX) * diff) + smallNumber;
    
    // Add new pin
    [self addPinWithLat:lat andLong:lon];
    
}

// On update addPin and disable the location, we only need 1 value, since the location won't be moving.
// Press the update button again to get a new value
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation*)newLocation 
		  fromLocation:(CLLocation*)oldLocation {
    
    // Remove any current annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // Add new pin
    [self addPinWithLat:newLocation.coordinate.latitude andLong:newLocation.coordinate.longitude];
    
    // Stop the location asking for more location information. Saves battery!!!
    [locationManager stopUpdatingLocation];
}

// Add a new pin into the map at the lat and long
- (void)addPinWithLat:(float)lat andLong:(float)lon {
    
    // Set the current mapPointer
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    self.mapPointer = pinLocation;
    [pinLocation release];
    
    // Get the 2D Coordinates
    CLLocationCoordinate2D location;
    location.latitude =  self.mapPointer.coordinate.latitude;
    location.longitude = self.mapPointer.coordinate.longitude;
    
    // Add the the map
    ClubMapViewAnnotation *newAnnotation = [[ClubMapViewAnnotation alloc] initWithTitle:club.name andCoordinate:location andClub:self.club];
    [self.mapView addAnnotation:newAnnotation];
    
    // Move the map back to the center
    [self recenterMap:self.mapView];
    
    // Clean up
    [newAnnotation release];
}

// Not used
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading*)newHeading {
    return;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // An Save button to enable the club to be added or updated
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
    self.navigationItem.rightBarButtonItem  = saveButton;
    [saveButton release];
    
    // If in update mode, set the name and map to that of the club to be updated
    if (club != nil) {        
        [self addPinWithLat:[club.latitude floatValue] andLong:[club.longitude floatValue]];
        self.nameField.text = club.name;
    } 
    
    self.mapView.layer.cornerRadius = 10.0;
    
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed: @"Background.png"]];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc {
    [nameField release];
    [managedObjectContext release];
    [club release];
    [updateButton release];
    [randomButton release];
    [mapView release];
    [locationManager release];
    [mapPointer release];
    [super dealloc];
}


@end
