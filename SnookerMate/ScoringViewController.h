//
//  ScoringViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//
//  View controller for the scoring feature of the app
//
#import <UIKit/UIKit.h>
#import "Club.h"
#import "Frame.h"
#import "StateMachine.h"
@interface ScoringViewController : UIViewController

//Property for core data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 

//Properties for UI
@property (nonatomic, retain) IBOutlet UIButton *white;
@property (nonatomic, retain) IBOutlet UIButton *red;
@property (nonatomic, retain) IBOutlet UIButton *yellow;
@property (nonatomic, retain) IBOutlet UIButton *green;
@property (nonatomic, retain) IBOutlet UIButton *brown;
@property (nonatomic, retain) IBOutlet UIButton *blue;
@property (nonatomic, retain) IBOutlet UIButton *pink;
@property (nonatomic, retain) IBOutlet UIButton *black;

@property (nonatomic, retain) IBOutlet UIButton *foulButton;
@property (nonatomic, retain) IBOutlet UIButton *addRedButton;
@property (nonatomic, retain) IBOutlet UIButton *removeRedButton;
@property (nonatomic, retain) IBOutlet UIButton *endFrameButton;

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedPlayerButtons;

@property (nonatomic, retain) IBOutlet UILabel *playerOneScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerTwoScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentPlayerLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfReds;
@property (nonatomic, retain) IBOutlet Club *club;

//Frame model
@property (nonatomic, retain) Frame *frameModel;

-(IBAction)potBall:(id)sender;
-(IBAction)changePlayer;
-(IBAction)toggleFoul;
-(IBAction)addRed;
-(IBAction)removeRed;
-(IBAction)endFrame;
-(void)update;
-(id)initWithPlayerOne:(Player*)playerOne andPlayerTwo:(Player*)playerTwo andClub:(Club*)c;
@end
