//
//  Pot.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 10/12/2011.
//

#import "Pot.h"

@implementation Pot

@synthesize player, ball, foul;

-(void) dealloc {
    [player release];
    [ball release];
    [super dealloc];   
}

- (id)initWithBall:(Ball*)b andPlayer:(NSString*)p
{
    return [self initWithBall:b player:p andFoul:NO];
}


- (id)initWithBall:(Ball*)b player:(NSString*)p andFoul:(BOOL)f
{
    self = [super init];
    if (self) {
        ball = [b retain];
        player = [p retain];
        foul = f;
    }
    
    return self;    
}


@end
