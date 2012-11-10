//
//  ScoringViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//

#import "ScoringViewController.h"
#import "Ball.h"
#import "Player.h"
#import "StateMachine.h"
#import "Pot.h"
#import "ResultViewController.h"

@implementation ScoringViewController

@synthesize white,red,yellow,green,brown,blue,pink,black,frameModel,addRedButton,removeRedButton,managedObjectContext,playerOneScoreLabel,playerTwoScoreLabel,currentPlayerLabel,foulButton,segmentedPlayerButtons,numberOfReds,
 endFrameButton, club;


- (id)initWithPlayerOne:(Player *)playerOne andPlayerTwo:(Player *)playerTwo andClub:(Club *)c {
    self = [super init];
    if (self) {
        frameModel = [[Frame alloc] initWithPlayerOne:playerOne andPlayerTwo:playerTwo];
        club = c;
    }
    return self;
    
}

-(IBAction)endFrame {
    ResultViewController *resultViewController = [[ResultViewController alloc] init];
    resultViewController.managedObjectContext = managedObjectContext;
    
    resultViewController.club = self.club;
    resultViewController.playerOne = self.frameModel.playerOne;
    resultViewController.playerTwo = self.frameModel.playerTwo;
    resultViewController.playerOneScore = [NSNumber numberWithInt:self.frameModel.playerOneScore];
    resultViewController.playerTwoScore = [NSNumber numberWithInt:self.frameModel.playerTwoScore];
    [self.navigationController pushViewController:resultViewController animated:YES];
    [resultViewController release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Setup the segment controllers
    [self.segmentedPlayerButtons setTitle:[frameModel.playerOne name] forSegmentAtIndex:0];
    [self.segmentedPlayerButtons setTitle:[frameModel.playerTwo name] forSegmentAtIndex:1];
    
    // Update the view
    [self update];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)changePlayer
{ 
    // Set which players go it is
    if([self.segmentedPlayerButtons selectedSegmentIndex] == 0) {
        [frameModel setCurrentPlayer:frameModel.playerOne];
    } else {
        [frameModel setCurrentPlayer:frameModel.playerTwo];
    }
    // Retain the new State and release the old one    
	[frameModel changePlayerTransision];
    
    // Update view
    [self update];
}

-(IBAction)potBall:(id)sender
{
    // Decide on which colour to use.
    BallColour colour;
    if (sender == red) {
        colour = RED;
    } else if(sender == yellow) {
        colour = YELLOW;
    } else if (sender == green) {
        colour = GREEN;     
    } else if (sender == brown) {
        colour = BROWN;      
    } else if (sender == blue) {
        colour = BLUE;    
    } else if (sender == pink) {
        colour = PINK;   
    } else if (sender == black) {
        colour = BLACK;    
    } else {
        colour = WHITE;
    }
    // Create a ball and give it to the ScoreModel, then release it.
    Ball *ball = [[Ball alloc] initWithColour:colour];
    [frameModel addBall:ball];
    [ball release];
    
    // Update view
    [self update];
}

- (IBAction)toggleFoul
{
    [frameModel foulTransision];    
    // Update view
    [self update];
}

- (void)update
{
    
    // Updates which balls are avalible
    playerOneScoreLabel.text = [NSString stringWithFormat:@"%d", frameModel.playerOneScore];
    playerTwoScoreLabel.text = [NSString stringWithFormat:@"%d", frameModel.playerTwoScore];
    currentPlayerLabel.text = [self.segmentedPlayerButtons titleForSegmentAtIndex: [self.segmentedPlayerButtons selectedSegmentIndex]];
    numberOfReds.text= [NSString stringWithFormat : @"%d", frameModel.numberOfReds];
    if([frameModel.state isKindOfClass:[RedState class]]) {
        [white setEnabled:NO];
        [red setEnabled:YES];
        [yellow setEnabled:NO];
        [green setEnabled:NO];
        [brown setEnabled:NO];
        [blue setEnabled:NO];
        [pink setEnabled:NO];
        [black setEnabled:NO];
        [foulButton setSelected: NO];
  
    } else if([frameModel.state isKindOfClass:[ColourState class]]) {
        [white setEnabled:NO];
        [red setEnabled:YES];
        [yellow setEnabled:YES];
        [green setEnabled:YES];
        [brown setEnabled:YES];
        [blue setEnabled:YES];
        [pink setEnabled:YES];
        [black setEnabled:YES];
        [foulButton setSelected: NO];
    
    } else if([frameModel.state isKindOfClass:[ColourOnlyState class]]) {
        [white setEnabled:NO];
        [red setEnabled:NO];
        [yellow setEnabled:YES];
        [green setEnabled:YES];
        [brown setEnabled:YES];
        [blue setEnabled:YES];
        [pink setEnabled:YES];
        [black setEnabled:YES];
        [foulButton setSelected: NO];
  
    } else if([frameModel.state isKindOfClass:[FoulState class]]) {
        [white setEnabled:YES];
        [red setEnabled:YES];
        [yellow setEnabled:YES];
        [green setEnabled:YES];
        [brown setEnabled:YES];
        [blue setEnabled:YES];
        [pink setEnabled:YES];
        [black setEnabled:YES];
        [foulButton setSelected: YES];
    } 
}

-(IBAction)addRed
{
    [frameModel addRed];
    [self update];
}

-(IBAction)removeRed 
{
    [frameModel removeRed];
    [self update];
}

- (void)dealloc
{   
    [white release];
    [red release];
    [yellow release];
    [green release];
    [brown release];
    [blue release];
    [pink release];
    [black release];
    [frameModel release];
    [addRedButton release];
    [removeRedButton release];
    [segmentedPlayerButtons release];
    [numberOfReds release];
    [endFrameButton release];
	[super dealloc];
}


@end
