//
//  ResultViewController.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 21/01/2012.
//
//  Display the result of the frame, and save it for stats
//
#import <UIKit/UIKit.h>
#import "Player.h"
#import "Club.h"
#import "Result.h"
@interface ResultViewController : UIViewController

//Properties for Core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UIButton *saveResultButton;
@property (nonatomic, retain) NSNumber * playerOneScore;
@property (nonatomic, retain) NSNumber * playerTwoScore;
@property (nonatomic, retain) Player *playerOne;
@property (nonatomic, retain) Player *playerTwo;
@property (nonatomic, retain) Result *result;
@property (nonatomic, retain) Club *club;

//Properties for interface
@property (nonatomic,retain) IBOutlet UILabel *playerOneLabel;
@property (nonatomic,retain) IBOutlet UILabel *playerTwoLabel;
@property (nonatomic,retain) IBOutlet UILabel *playerOneScoreLabel;
@property (nonatomic,retain) IBOutlet UILabel *playerTwoScoreLabel;

-(IBAction) saveResult;
@end
