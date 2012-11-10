//
//  DisplayClubViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//


#import "DisplayClubViewController.h"
#import "AddClubViewController.h"
#import "ClubMapViewAnnotation.h"
#import "MapCentre.h"

@implementation DisplayClubViewController

@synthesize clubNameLabel, managedObjectContext, deleteButton, club, mapView;

// Press edit button
-(void)editButtonPressed {
    // Add Club and ManagedObjectContext onto the add view for the edit mode
    AddClubViewController *addClubViewController = [[AddClubViewController alloc] init];
    addClubViewController.managedObjectContext = managedObjectContext;
    addClubViewController.club = self.club;
    [self.navigationController pushViewController:addClubViewController animated:YES];
    [addClubViewController release];
}

// Make sure the delete works before popping
-(IBAction) deleteButtonPressed {
    [managedObjectContext deleteObject:club]; 
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to delete from data store: %@", [error localizedDescription]);
        [self.managedObjectContext rollback];      
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// Adds an annotation to the map
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    
    MKPinAnnotationView* pinView = [[[MKPinAnnotationView alloc]
                                     initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
    
    
    
    // Get the club from the annotation
    Club *annotationClub = ((ClubMapViewAnnotation *) annotation).club;
    
    // Check if the club is the current club and set the pin colour
    if(self.club == annotationClub) {
        pinView.animatesDrop=YES;
        pinView.pinColor = MKPinAnnotationColorRed;
    } else {
        pinView.pinColor = MKPinAnnotationColorPurple;
    }
    
    // Add a button to the right of the popup box to allow the user to go to the club
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    pinView.rightCalloutAccessoryView = rightButton;
    
    return pinView;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the delegate for the map to self
    [self.mapView setDelegate: self];
    
    // Add edit button to top right
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.navigationItem.rightBarButtonItem  = editButton;
    self.navigationItem.title = @"Club Details";
    [editButton release];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Remove all current annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // Set the club name to self
    self.clubNameLabel.text = self.club.name;  
    
    // Make a request to get all clubs
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    
    NSMutableArray *allClubs = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    // Check if the current Lat and Long are set
    if([club.latitude floatValue] != 0 && [club.longitude floatValue] != 0) {
        
        // Loop though all the clubs
        for(Club *clubItem in allClubs) {
            
            // Check each club has a long and lat
            if([clubItem.latitude floatValue] != 0 && [clubItem.longitude floatValue] != 0) {
                
                // Add a annotaiton at the location set by the club
                CLLocationCoordinate2D location;
                location.latitude =  [clubItem.latitude doubleValue];
                location.longitude = [clubItem.longitude doubleValue];
                
                // Add the annotation to our map view
                ClubMapViewAnnotation *newAnnotation = [[ClubMapViewAnnotation alloc] initWithTitle:clubItem.name andCoordinate:location andClub:clubItem];
                
                
                [self.mapView addAnnotation:newAnnotation];
                [newAnnotation release];   
                
                [self recenterMap:self.mapView];
                
                
            }
            
        }
    } else {
        MKCoordinateRegion region = {{0.0f, 0.0f}, {180.0f, 180.0f}};
        [self.mapView setRegion:region animated:YES];  
    }
    
    [request release];
    [allClubs release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) dealloc {
    [clubNameLabel release];
    [managedObjectContext release];
    [deleteButton release];
    [club release];
    [mapView release];
    [super dealloc];
}




@end
