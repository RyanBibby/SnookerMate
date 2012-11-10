//
//  ListPlayersViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 12/01/2012.
//

#import "ListPlayersViewController.h"
#import "Player.h"
#import "AddPlayerViewController.h"
#import "DisplayPlayerViewController.h"
#import "SnookerMateAppDelegate.h"

@implementation ListPlayersViewController
@synthesize managedObjectContext, tableData;


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem  = addButton;
    [addButton release];
}

- (void)addButtonPressed {
    AddPlayerViewController *addPlayerViewController = [[AddPlayerViewController alloc] init];
    addPlayerViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:addPlayerViewController animated:YES];
    [addPlayerViewController release];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self update];
}

-(void) update {
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
    cell.textLabel.text = player.name;
    
    return cell;
}


//Cell pressed method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINavigationController *navController =  [(SnookerMateAppDelegate*)[[UIApplication sharedApplication] delegate] navigationController];
    DisplayPlayerViewController *displayPlayerViewController = [[DisplayPlayerViewController alloc] init];
    displayPlayerViewController.managedObjectContext = managedObjectContext;
    displayPlayerViewController.player = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [navController pushViewController:displayPlayerViewController animated:YES];
    [displayPlayerViewController release];
}

- (void)dealloc {
    [managedObjectContext release];
    [tableData release];
    [super dealloc];
}


@end

