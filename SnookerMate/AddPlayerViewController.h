//
//  AddPlayerViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 11/01/2012.
//
#import <UIKit/UIKit.h>
#import "Player.h"

@interface AddPlayerViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) IBOutlet UITextField *nameField; 

-(void) createPlayer;
@end
