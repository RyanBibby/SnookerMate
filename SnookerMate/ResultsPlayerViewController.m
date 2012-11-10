//
//  ResultsPlayerViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 21/01/2012.
//  Copyright 2012 Mark Dessain. All rights reserved.
//

#import "ResultsPlayerViewController.h"
#import "Result.h"
#import "Club.h"

@implementation ResultsPlayerViewController

@synthesize managedObjectContext, player, tableData;

-(void) dealloc {
    [managedObjectContext release];
    [player release];
    [tableData release];
    [super dealloc];
}
-(void) update {

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Result" inManagedObjectContext:managedObjectContext];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(firstPlayer == %@) OR (secondPlayer == %@)", self.player,self.player];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];  
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    [request setSortDescriptors:sortDescriptors];  
     
    
    
    [request setEntity:entity];
    [request setPredicate:pred];
    NSError *error;
    NSMutableArray *allResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
   
    self.tableData = allResults;
    
    [sortDescriptor release];  
    [request release];
    [allResults release];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self update];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self update];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Result *result = [self.tableData objectAtIndex:indexPath.row];
    
    
    static NSDateFormatter *dateFormatter = nil; 
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy h:mm a"];
    }
    
    NSString *firstPlayer;
    NSString *date = [dateFormatter stringFromDate: [result timeStamp]];
    NSString *firstPlayerScore = [NSString stringWithFormat:@"%@", result.firstPlayerScore];
    NSString *secondPlayer;
    NSString *secondPlayerScore = [NSString stringWithFormat:@"%@", result.secondPlayerScore];
    NSString *club;
    
    BOOL won;
    
    @try {
        firstPlayer = [NSString stringWithFormat:@"%@", result.firstPlayer.name];
        if(result.firstPlayer == self.player) {
            won = YES;
        }
    }
    @catch (NSException * e) {
        firstPlayer = [NSString stringWithFormat:@"Player Deleted"];
    }
    @finally {
    }
    
    
    @try {
        secondPlayer = [NSString stringWithFormat:@"%@", result.secondPlayer.name];
        if(result.secondPlayer == self.player) {
            won = NO;
        }
    }
    @catch (NSException * e) {
        secondPlayer = [NSString stringWithFormat:@"Player Deleted"];
    }
    @finally {
    }
    
    
    @try {
        if(result.club.name != nil) {
            club = [NSString stringWithFormat:@"Club %@ |", result.club.name];
        } else {
            club = [NSString stringWithFormat:@""];
        }
    }
    @catch (NSException * e) {
        club = [NSString stringWithFormat:@""];
    }
    @finally {
    }
    
    
    
    if(won) {
        cell.textLabel.text = secondPlayer;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ | %@ %@", firstPlayerScore, secondPlayerScore, club, date];
    } else {
        cell.textLabel.text = firstPlayer;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ | %@ %@", secondPlayerScore, firstPlayerScore, club, date];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //No functionality in this version
}

@end
