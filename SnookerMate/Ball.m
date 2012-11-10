//
//  Ball.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//

#import "Ball.h"
@implementation Ball

@synthesize value;

- (id)initWithColour:(BallColour)ballColour
{
    self = [super init];
    if (self) {
        value = ballColour;
    }
    
    return self;    
}

- (id)init
{
    BallColour ballColour = RED;
	return [self initWithColour: ballColour];
}


@end
