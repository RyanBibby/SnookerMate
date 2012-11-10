//
//  ResultViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 21/01/2012.
//

#import "ResultViewController.h"
#import "Result.h"
@implementation ResultViewController
@synthesize managedObjectContext, saveResultButton, playerTwo,playerOne,playerOneScore,playerTwoScore, result,
playerOneLabel,playerTwoLabel,playerOneScoreLabel,playerTwoScoreLabel, club;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playerOneLabel.text = self.playerOne.name;
    self.playerTwoLabel.text = self.playerTwo.name;
    self.playerOneScoreLabel.text = [NSString stringWithFormat:@"%d",[self.playerOneScore intValue]];
    self.playerTwoScoreLabel.text = [NSString stringWithFormat:@"%d",[self.playerTwoScore intValue]];
}

-(IBAction)saveResult {
    NSLog(@"Start Save");
    self.result = (Result *) [NSEntityDescription insertNewObjectForEntityForName:@"Result" inManagedObjectContext:managedObjectContext];
    
    if(self.club != NULL) {
        self.result.club = self.club;
    }

    self.result.timeStamp = [NSDate date];  
    
    if(self.playerOneScore >= self.playerTwoScore) {
        self.result.firstPlayer = self.playerOne;
        self.result.secondPlayer = self.playerTwo;
        self.result.firstPlayerScore = self.playerOneScore;
        self.result.secondPlayerScore = self.playerTwoScore;    
    } else {
        self.result.firstPlayer = self.playerTwo;
        self.result.secondPlayer = self.playerOne;
        self.result.firstPlayerScore = self.playerTwoScore;
        self.result.secondPlayerScore = self.playerOneScore;    
    }
    
   
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error");
        //This error case should never be triggered.
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Fatal Error"];
        [alert setMessage:@"Unknown error, please try again."];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert release];
        [self.managedObjectContext rollback];      
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"Result Saved");
    }
}

-(void) dealloc {
    [managedObjectContext release];
    [saveResultButton release];
    [playerTwo release];
    [playerOne release];
    [playerOneScore release];
    [playerTwoScore release];
    [result release];
    [playerOneLabel release];
    [playerTwoLabel release];
    [playerTwoScoreLabel release];
    [playerOneScoreLabel release];
    [super dealloc];
}
@end
