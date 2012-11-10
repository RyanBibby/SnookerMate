//
//  Stack.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 01/12/2011.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property (retain) NSMutableArray *array;

- (void) push:(id)object;
- (id) pop;
- (id) top;
- (int) count;

@end
