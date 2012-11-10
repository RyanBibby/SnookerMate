//
//  DisplayPlayerViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 12/01/2012.
//

#import "DisplayPlayerViewController.h"
#import "AddPlayerViewController.h"
#import "Result.h"
#import "ResultsPlayerViewController.h"

@implementation DisplayPlayerViewController
@synthesize managedObjectContext, deleteButton, player, playerNameLabel, resultsScroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed)];
    self.navigationItem.rightBarButtonItem  = editButton;
    self.navigationItem.title = @"Player Stats";
    [editButton release];
       
    ResultsPlayerViewController *resultsPlayersViewController = [[ResultsPlayerViewController alloc] init];
    resultsPlayersViewController.managedObjectContext = self.managedObjectContext;
    resultsPlayersViewController.player = self.player;
    [resultsScroll addSubview: resultsPlayersViewController.view];
    [resultsPlayersViewController release];
}

-(void)editButtonPressed {
    AddPlayerViewController *addPlayerViewController = [[AddPlayerViewController alloc] init];
    addPlayerViewController.managedObjectContext = managedObjectContext;
    addPlayerViewController.player = self.player;
    [self.navigationController pushViewController:addPlayerViewController animated:YES];
    [addPlayerViewController release];
    
    
}
-(IBAction) deleteButtonPressed {
    [managedObjectContext deleteObject:player]; 
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to delete from data store: %@", [error localizedDescription]);
        [self.managedObjectContext rollback];      
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.playerNameLabel.text = self.player.name;    
}

- (void)dealloc {
    [managedObjectContext release];
    [deleteButton release];
    [player release];
    [playerNameLabel release];
    [resultsScroll release];
    [super dealloc];
}


@end
