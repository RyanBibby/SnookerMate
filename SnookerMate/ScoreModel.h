//
//  ScoreModel.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Ball.h"
#import "Player.h"

@interface ScoreModel : NSObject

@property (nonatomic, retain) Stack *pots;
@property (nonatomic, retain) Player *playerOne;
@property (nonatomic, retain) Player *playerTwo;
@property (nonatomic, assign) int playerOneScore;
@property (nonatomic, assign) int playerTwoScore;
@property (nonatomic, retain) Player *currentPlayer;
@property (nonatomic, assign) BOOL foulMode;

- (void) addBall:(Ball*)ball;
- (id) initWithPlayerOne:(Player*)p1 andPlayerTwo:(Player*)p2;



@end
