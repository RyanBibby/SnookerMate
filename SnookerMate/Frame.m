//
//  Frame.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "Frame.h"
#import "Ball.h"
#import "Pot.h"
@implementation Frame

@synthesize pots,playerOne,playerTwo,playerOneScore,playerTwoScore,currentPlayer,numberOfReds,state,afterFoul;

- (id)initWithPlayerOne:(Player*)p1 andPlayerTwo:(Player*)p2
{
    self = [super init];
    if (self) {
        pots = [[Stack alloc] init];    
        playerOne = [p1 retain];
        playerTwo = [p2 retain];
        currentPlayer = [playerOne retain];
        playerOneScore = 0;
        playerTwoScore = 0;
        numberOfReds = 15;
        afterFoul = NO;
        state = [[RedState alloc] init];
    }
    return self;
}

- (void) addBall:(Ball*)ball
{
	Pot *pot = [[Pot alloc] initWithBall:ball andPlayer:@"Player 1"];
	
	if(![state isKindOfClass:[FoulState class]]) {
		if(currentPlayer == playerOne) {
			playerOneScore += ball.value;
		} else {
			playerTwoScore += ball.value;
		}
	} 
    else {
		int foulPoints = 4;
		if (ball.value > 4) {
			foulPoints = ball.value;
		}
		if(currentPlayer == playerOne) {
			playerTwoScore += foulPoints;
		} else {
			playerOneScore += foulPoints;
		}		
	}
	
	  
	if ([state isKindOfClass:[FoulState class]]) {
		pot.foul = YES;
	}

	[pots push:pot];
	[pot release];
	if (ball.value == RED) {
		if (![state isKindOfClass:[FoulState class]]) {
            
            [self redTransision];
            [self removeRed];
        }
    }
    else {
        if (self.numberOfReds == 0) {
            [self colourOnlyTransision];
        }
        else {
            [self colourTransision];
        }
	}
}

- (void) redTransision {
	// Decide on which state to go to
    id <StateMachine, NSObject> newState;
	newState = [state redButton];
    // Retain the new State and release the old one    
    [state release];
    state = [newState retain];	
}
- (void) colourTransision {
	// Decide on which state to go to
    id <StateMachine, NSObject> newState;
	newState = [state colourButton];
    // Retain the new State and release the old one    
    [state release];
    state = [newState retain];	
}
- (void) colourOnlyTransision {
	// Decide on which state to go to
    id <StateMachine, NSObject> newState;
	newState = [state finalNominatedColourButton];
    // Retain the new State and release the old one    
    [state release];
    state = [newState retain];	
}
-(void) foulTransision {
    	// Decide on which state to go to
    id <StateMachine, NSObject> newState;
	newState = [state foulButton];
    // Retain the new State and release the old one    
    [state release];
    state = [newState retain];	
}
-(void) changePlayerTransision {
	// Decide on which state to go to
    id <StateMachine, NSObject> newState;
	newState = [state changePlayerButton];
    // Retain the new State and release the old one    
    [state release];
    state = [newState retain];	
}


//It is possible for a player to get a 'free ball' before a red
// is potted effectively making the table contain 16 reds
-(void) addRed 
{
    if (self.numberOfReds < 16) {
        self.numberOfReds += 1;
        [self redTransision];
    }

}
-(void) removeRed 
{
    if (self.numberOfReds > 0) {
        self.numberOfReds -= 1;
      
    }
    
}
-(void) dealloc
{
    [pots release];
    [playerOne release];
    [playerTwo release];
    [currentPlayer release];
    [super dealloc];
}

@end
