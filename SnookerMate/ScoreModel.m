//
//  ScoreModel.m
//  SnookerMate
//
//  Created by Mark Dessain on 01/12/2011.
//

#import "ScoreModel.h"
#import "Ball.h"
#import "Pot.h"

@implementation ScoreModel

@synthesize pots,playerOne,playerTwo,playerOneScore,playerTwoScore,currentPlayer,foulMode;

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
        foulMode = NO;
    }
    return self;
}

- (void) addBall:(Ball*)ball
{
    Pot *pot = [[Pot alloc] initWithBall:ball andPlayer:@"Player 1"];
    
    if((currentPlayer == playerOne && !foulMode) || (currentPlayer == playerTwo && foulMode)) {
        playerOneScore += ball.value;
    }else if((currentPlayer == playerTwo && !foulMode) || (currentPlayer == playerOne && foulMode)) {
        playerTwoScore += ball.value;
    }
  
    if (foulMode) {
        pot.foul = YES;
    }

    [pots push:pot];
    [pot release];
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
