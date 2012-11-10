//
//  ListClubsViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "ListClubsViewController.h"
#import "Club.h"
#import "SnookerMateAppDelegate.h"
#import "DisplayClubViewController.h"

@implementation ListClubsViewController

@synthesize managedObjectContext, tableData;


// Updates the data in the list
-(void) update {
    // Makes a request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    // Gets all the clubs
    NSMutableArray *allClubs = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    // Adds them to the tabledata
    self.tableData = [self partitionObjects:allClubs collationStringSelector:@selector(name)];
    
    // Releases and reloads table
    [allClubs release];
    [request release];
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source








// Code from http://benedictcohen.co.uk/blog/archives/230

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


// - End code 








// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Sets the cell text to that of the list item
    Club *club = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = club.name;
    
    return cell;
}


#pragma mark - Table view delegate


//Cell pressed method sends to the display view controller
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NavigationController
    UINavigationController *navController =  [(SnookerMateAppDelegate*)[[UIApplication sharedApplication] delegate] navigationController];
    
    // Gives the new viewcontroller the managed object context and club object
    DisplayClubViewController *displayClubViewController = [[DisplayClubViewController alloc] init];
    displayClubViewController.managedObjectContext = managedObjectContext;
    displayClubViewController.club = [[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [navController pushViewController:displayClubViewController animated:YES];
    [displayClubViewController release];
}

-(void) dealloc {
    [tableData release];
    [managedObjectContext release];
    [super dealloc];
}

@end
