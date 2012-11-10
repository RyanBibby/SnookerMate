//
//  StateMachine.h
//  SnookerMate
//
//  Created by Ryan Bibby & Mark Dessain on 10/12/2011.
//
//  A state machine to deal with the changing state of the game
//  and what actions can be ferformed at what time
//

#import <Foundation/Foundation.h>


@protocol StateMachine

-(id <StateMachine, NSObject>)redButton;
-(id <StateMachine, NSObject>)colourButton;
-(id <StateMachine, NSObject>)finalNominatedColourButton;
-(id <StateMachine, NSObject>)foulButton;
-(id <StateMachine, NSObject>)changePlayerButton;

@end

@interface StateMachine : NSObject <StateMachine>

@property (nonatomic, retain) NSMutableDictionary *balls;

-(id <StateMachine, NSObject>)initWithBalls:(NSMutableDictionary*)b;

@end

@interface RedState : StateMachine
@end

@interface ColourState : StateMachine
@end

@interface FoulState : StateMachine
@end

@interface ColourOnlyState : StateMachine
@end