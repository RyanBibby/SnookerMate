//
//  Pot.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 10/12/2011.
//
//  A object that encapulates a player potting a balls
//  this is used for the undo stack, which is not yet 
//  implemented
//

#import <Foundation/Foundation.h>
#import "Ball.h"

@interface Pot : NSObject

@property (nonatomic, retain) NSString* player;
@property (nonatomic, retain) Ball* ball;
@property (assign) BOOL foul;

- (id)initWithBall:(Ball*)b andPlayer:(NSString*)p;
- (id)initWithBall:(Ball*)b player:(NSString*)p andFoul:(BOOL)f;

@end
