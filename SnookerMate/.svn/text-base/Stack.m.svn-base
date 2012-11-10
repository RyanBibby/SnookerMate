//
//  Stack.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//

#import "Stack.h"

@implementation Stack

@synthesize array;

- (id)init
{
    self = [super init];
    if (self) {
        array = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) push:(id)object
{
    [array addObject: object];
}

- (id) pop
{
    if ([array count] > 0){
        id object = self.top;
        [array removeLastObject];
        return object;
    } else {
        return nil;
    }
}

- (id) top
{
    if ([array count] > 0){
        return [array objectAtIndex:[array count] - 1];  
    } else {
        return nil;
    }
}

- (int) count
{
    return [array count];
}

@end
