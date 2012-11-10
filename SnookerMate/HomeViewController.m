//
//  HomeViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain 12/01/2012.
//

#import "HomeViewController.h"
#import "ScoringViewController.h"
#import "ListPlayersViewController.h"
#import "SelectPlayersViewController.h"
#import "TabClubsViewController.h"
@implementation HomeViewController
@synthesize managedObjectContext, scoringButton, playersButton, clubsButton;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Add button to top right
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(aboutButtonPressed)];
    self.navigationItem.rightBarButtonItem  = aboutButton;
    [aboutButton release];
    
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed: @"HomeBackground.png"]];
}

-(IBAction) playersButtonPressed {
    ListPlayersViewController *listPlayersViewController = [[ListPlayersViewController alloc] init];
    listPlayersViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:listPlayersViewController animated:YES];
    [listPlayersViewController release];
}

-(IBAction) scoringButtonPressed {
    SelectPlayersViewController *selectPlayersViewController = [[SelectPlayersViewController alloc] init];
    selectPlayersViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:selectPlayersViewController animated:YES];
    [selectPlayersViewController release];
}

-(IBAction) clubsButtonPressed {
    TabClubsViewController *listPlayersViewController = [[TabClubsViewController alloc] init];
    listPlayersViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:listPlayersViewController animated:YES];
    [listPlayersViewController release];
}

-(IBAction) aboutButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"About SnookerMate"];
    [alert setMessage:@"Mark Dessain and Ryan Bibby \n University of Sheffield \n \n Version 0.5 - 23/01/2012"];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    [alert release];
}

- (void)dealloc {
    [managedObjectContext release];
    [scoringButton release];
    [playersButton release];
    [clubsButton release];
    [super dealloc];
}


@end
