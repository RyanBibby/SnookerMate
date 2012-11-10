//
//  SelectPlayersViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 12/01/2012.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface SelectPlayersViewController : UITableViewController 
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property(readwrite, copy, nonatomic) NSArray *tableData;

@property (nonatomic, retain) Player *playerOne;
@property (nonatomic, retain) Player *playerTwo;
@property (nonatomic, retain) UIBarButtonItem *nextButton;
-(void)nextButtonPressed;
-(NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;
-(void)update;

@end
