//
//  StateMachine.m
//  SnookerMate
//
//  Created by Ryan Bibby & Mark Dessain on 10/12/2011.
//

#import "StateMachine.h"
#import "ScoringViewController.h"
#import "Ball.h"

@implementation StateMachine

@synthesize balls;

-(id <StateMachine, NSObject>)initWithBalls:(NSMutableDictionary*)b
{
    self = [super init];
    if(self) {
        balls = [b retain];
        NSLog(@"Y:%d", [[b objectForKey:[NSNumber numberWithInt:YELLOW]] intValue]); 
        NSLog(@"R:%d", [[b objectForKey:[NSNumber numberWithInt:RED]] intValue]); 
    }
    return self;
}

-(id <StateMachine, NSObject>) init
{
    NSMutableDictionary *b = [[NSMutableDictionary alloc] init];
    
	[b setObject:[NSNumber numberWithInt:15] forKey:[NSNumber numberWithInt:RED]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:YELLOW]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:GREEN]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:BROWN]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:BLUE]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:PINK]];
	[b setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:BLACK]];
    
    [b autorelease];
    
	return [self initWithBalls:b];
}

// By Default do nothing
-(id <StateMachine, NSObject>)redButton { return self; }
-(id <StateMachine, NSObject>)colourButton { return self; }
-(id <StateMachine, NSObject>)finalNominatedColourButton { return self; }
-(id <StateMachine, NSObject>)foulButton { return self; }
-(id <StateMachine, NSObject>)changePlayerButton { return self; }

-(void) dealloc
{
    [balls release];
    [super dealloc];
}

@end

@implementation RedState


-(id <StateMachine, NSObject>)redButton
{
//    // Testing removing a red at each pot
//    int value  = [[self.balls objectForKey:[NSNumber numberWithInt:RED]] intValue] - 1;
//    [self.balls removeObjectForKey:[NSNumber numberWithInt:RED]];
//    [self.balls setObject:[NSNumber numberWithInt:value] forKey:[NSNumber numberWithInt:RED]];
    
    return [[[ColourState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)colourButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)finalNominatedColourButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
    
}
-(id <StateMachine, NSObject>)foulButton
{
    return [[[FoulState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)changePlayerButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

@end

@implementation ColourState

-(id <StateMachine, NSObject>)redButton
{
    return [[[ColourState alloc] initWithBalls:[self balls]] autorelease];
}
-(id <StateMachine, NSObject>)finalNominatedColourButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
    
}
-(id <StateMachine, NSObject>)colourButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)foulButton
{
    return [[[FoulState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)changePlayerButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}


@end

@implementation FoulState


-(id <StateMachine, NSObject>)redButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}
-(id <StateMachine, NSObject>)finalNominatedColourButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
    
}
-(id <StateMachine, NSObject>)colourButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)foulButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)changePlayerButton
{
    return [[[RedState alloc] initWithBalls:[self balls]] autorelease];
}

@end

@implementation ColourOnlyState 
-(id <StateMachine, NSObject>)redButton
{
    return [[[ColourState alloc] initWithBalls:[self balls]] autorelease];

}
-(id <StateMachine, NSObject>)finalNominatedColourButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
    
}
-(id <StateMachine, NSObject>)colourButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)foulButton
{
    return [[[FoulState alloc] initWithBalls:[self balls]] autorelease];
}

-(id <StateMachine, NSObject>)changePlayerButton
{
    return [[[ColourOnlyState alloc] initWithBalls:[self balls]] autorelease];
}
@end