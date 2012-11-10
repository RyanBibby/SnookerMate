//
//  MapCentre.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "TabClubsViewController.h"
#import "AddClubViewController.h"

@implementation TabClubsViewController

@synthesize tabBar, listPlayers, mapClubs, managedObjectContext;


// Show the Add 
-(void)addButtonPressed {    
    AddClubViewController *addClubViewController = [[AddClubViewController alloc] init];
    addClubViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:addClubViewController animated:YES];
    [addClubViewController release];
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add buttont to top right
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem  = addButton;
    [addButton release];
    
    // Set the size of the subview
    // Give subviews the managed object context
    tabBar.view.frame = CGRectMake(0,0,320,460);
    listPlayers.managedObjectContext = managedObjectContext;
    mapClubs.managedObjectContext = managedObjectContext;
    [listPlayers viewWillAppear:NO];
    [self.view addSubview:tabBar.view];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // When this appears, make sure the data on the subviews is updated as well
    [self.listPlayers update];
    [self.mapClubs update];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc {
    [tabBar release];
    [managedObjectContext release];
    [listPlayers release];
    [mapClubs release];
    [super dealloc];
}

@end
