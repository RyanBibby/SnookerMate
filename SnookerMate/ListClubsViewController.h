//
//  ListClubsViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <UIKit/UIKit.h>

@interface ListClubsViewController : UITableViewController

// Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *tableData;

-(NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;
-(void) update;

@end
