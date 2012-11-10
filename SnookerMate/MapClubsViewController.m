//
//  MapClubsViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "MapClubsViewController.h"
#import "ClubMapViewAnnotation.h"
#import "DisplayClubViewController.h"
#import "SnookerMateAppDelegate.h"
#import "MapCentre.h"


@implementation MapClubsViewController

@synthesize mapView, managedObjectContext, selectedClub;

// Set club to a new empty object
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedClub = [[Club alloc] init];
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set delegate and update
    [self.mapView setDelegate: self];
    [self update];
}  

- (void) update {
    // Remove all current annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // Make a request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    NSMutableArray *allClubs = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    // Loop though all the club
    for(Club *club in allClubs) {
        
        // Set location to clubs long and lat
        CLLocationCoordinate2D location;
        location.latitude =  [club.latitude doubleValue];
        location.longitude = [club.longitude doubleValue];
        
        // Add the annotation to our map view
        ClubMapViewAnnotation *newAnnotation = [[ClubMapViewAnnotation alloc] initWithTitle:club.name andCoordinate:location andClub:club];
        [self.mapView addAnnotation:newAnnotation];
        [newAnnotation release];
        
    }
    
    [allClubs release];
    [request release];
    [self recenterMap:self.mapView];
}

    

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";

    MKPinAnnotationView* pinView = [[[MKPinAnnotationView alloc]
                                     initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
    pinView.animatesDrop=YES;
    pinView.canShowCallout=YES;
    
    // Add a button to the right side of the pin to go to the club
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    pinView.rightCalloutAccessoryView = rightButton;
    
    return pinView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // Once a annotaiton is selected set that to the seletcted club
    selectedClub = ((ClubMapViewAnnotation *)view.annotation).club;
}

-(IBAction)showDetails:(id)sender {
    UINavigationController *navController =  [(SnookerMateAppDelegate*)[[UIApplication sharedApplication] delegate] navigationController];
    DisplayClubViewController *displayClubViewController = [[DisplayClubViewController alloc] init];
    displayClubViewController.managedObjectContext = managedObjectContext;
    displayClubViewController.club = selectedClub;
    [navController pushViewController:displayClubViewController animated:YES];
    [displayClubViewController release];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) dealloc {
    [mapView release];
    [managedObjectContext release];
    [selectedClub release];
    [super dealloc];
}


@end
