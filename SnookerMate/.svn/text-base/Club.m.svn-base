// 
//  Club.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "Club.h"


@implementation Club 

@dynamic name;
@dynamic longitude;
@dynamic latitude;
-(NSString*) hasValidName {
    if ([self.name length] < 1) {
        return @"Name is too short, it should be between 1 and 10 characters.";
    }
    else if ([self.name length] >10) {
        return  @"Name is too long, it should be between 1 and 10 characters.";
    }
    else {
        return nil;
    }    
}
@end
