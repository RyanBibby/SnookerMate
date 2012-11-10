//
//  SelectPlayersViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 12/01/2012.
//

#import "SelectPlayersViewController.h"
#import "Player.h"
#import "AddPlayerViewController.h"
#import "DisplayPlayerViewController.h"
#import "BreakSelectorViewController.h"
@implementation SelectPlayersViewController
@synthesize managedObjectContext, tableData, playerOne, playerTwo, nextButton;


- (void)dealloc {
    [managedObjectContext release];
    [tableData release];
    [playerOne release];
    [playerTwo release];
    [nextButton release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonPressed)];
    self.nextButton = next;
    [next release];
    self.navigationItem.rightBarButtonItem  = self.nextButton;
}

- (void)nextButtonPressed {
    BreakSelectorViewController *breakSelectorViewController = [[BreakSelectorViewController alloc] init];
    breakSelectorViewController.managedObjectContext = managedObjectContext;
    breakSelectorViewController.playerOne = playerOne;
    breakSelectorViewController.playerTwo = playerTwo;
    [self.navigationController pushViewController:breakSelectorViewController animated:YES];
    [breakSelectorViewController release];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    playerOne = nil;
    playerTwo = nil;
    
    [self update];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    NSMutableArray *allPlayers = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    self.tableData = [self partitionObjects:allPlayers collationStringSelector:@selector(name)];
    
    [request release];
    [allPlayers release];
    [self.tableView reloadData];
}

-(void)update {
    if ((playerOne == nil) || (playerTwo == nil)){
        [nextButton setEnabled:NO];
    }
    else {
        [nextButton setEnabled:YES];
    }
}

// Copied from http://benedictcohen.co.uk/blog/archives/230

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

-(NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector

{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSInteger sectionCount = [[collation sectionTitles] count]; //section count is take from sectionTitles and not sectionIndexTitles
    NSMutableArray *unsortedSections = [NSMutableArray arrayWithCapacity:sectionCount];
    
    //create an array to hold the data for each section
    for(int i = 0; i < sectionCount; i++)
    {
        [unsortedSections addObject:[NSMutableArray array]];
    }
    
    //put each object into a section
    for (id object in array)
    {
        NSInteger index = [collation sectionForObject:object collationStringSelector:selector];
        [[unsortedSections objectAtIndex:index] addObject:object];
    }
    
    NSMutableArray *sectionsA = [NSMutableArray arrayWithCapacity:sectionCount];
    
    //sort each section
    for (NSMutableArray *section in unsortedSections)
    {
        [sectionsA addObject:[collation sortedArrayFromArray:section collationStringSelector:selector]];
    }
    
    return sectionsA;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //we use sectionTitles and not sections
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.tableData objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BOOL showSection = [[self.tableData objectAtIndex:section] count] != 0;
    //only show the section title if there are rows in the section
    return (showSection) ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
}


// - End copy

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    Player *player = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if(player == playerOne || player == playerTwo) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    
    cell.textLabel.text = player.name;
    
    return cell;
}


//Cell pressed method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Player *player = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(player == playerOne) {
        playerOne = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if(player == playerTwo) {
        playerTwo = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (playerOne == nil) {
        playerOne = player;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if(playerTwo == nil) {
        playerTwo = player;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self update];
    
}



@end

