//
//  DisplayPlayerViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessaon on 12/01/2012.
//
//  View controller for displaying a list of players

#import <UIKit/UIKit.h>
#import "Player.h"

@interface DisplayPlayerViewController : UIViewController 
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) IBOutlet UIScrollView *resultsScroll;
-(IBAction)deleteButtonPressed;
-(void) editButtonPressed;

@end
