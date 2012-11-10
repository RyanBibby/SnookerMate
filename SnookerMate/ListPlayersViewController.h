//
//  ListPlayersViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 12/01/2012.
//

#import <UIKit/UIKit.h>


@interface ListPlayersViewController : UITableViewController 
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) NSArray *tableData;

-(void)update;
-(void)addButtonPressed;
-(NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;

@end
