//
//  BreakSelectorViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 17/01/2012.
//
//  View controller for the screen where you select who breaks off
//  the frame
//
#import <UIKit/UIKit.h>
#import "Player.h"
#import "Club.h"

@interface BreakSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> 

//Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  

//UI elements
@property (nonatomic, retain) IBOutlet UIButton *playerOneButton;
@property (nonatomic, retain) IBOutlet UIButton *playerTwoButton;
@property (nonatomic, retain) IBOutlet UILabel *clubLabel;
@property (nonatomic, retain) IBOutlet UITextField *clubField;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIToolbar *accessoryView;

//Players involved
@property (nonatomic, retain) Player *playerOne;
@property (nonatomic, retain) Player *playerTwo;

@property (nonatomic, retain) Club *selectedClub;

//Used to poulate the picker
@property (nonatomic, retain) NSArray *clubs;

-(IBAction)playerOneButtonPressed;
-(IBAction)playerTwoButtonPressed;

-(IBAction)doneEditing:(id)sender;

@end
