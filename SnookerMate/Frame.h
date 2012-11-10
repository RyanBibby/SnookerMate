//
//  Frame.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Ball.h"
#import "Player.h"
#import "StateMachine.h"

@interface Frame : NSObject

@property (nonatomic, retain) Stack *pots;
@property (nonatomic, retain) Player *playerOne;
@property (nonatomic, retain) Player *playerTwo;
@property (nonatomic, assign) int playerOneScore;
@property (nonatomic, assign) int playerTwoScore;
@property (nonatomic, assign) int numberOfReds;
@property (nonatomic, retain) Player *currentPlayer;
@property (assign) id <StateMachine, NSObject> state;
@property (assign) BOOL afterFoul;

- (void) addBall:(Ball*)ball;
- (id) initWithPlayerOne:(Player*)p1 andPlayerTwo:(Player*)p2;
- (void) redTransision;
- (void) colourTransision;
- (void) colourOnlyTransision;
- (void) foulTransision;
- (void) changePlayerTransision;
- (void) addRed;
- (void) removeRed;

@end
