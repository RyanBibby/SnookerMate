//
//  ResultsPlayerViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 21/01/2012.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface ResultsPlayerViewController : UITableViewController


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) Player *player;

-(void) update;
@end
