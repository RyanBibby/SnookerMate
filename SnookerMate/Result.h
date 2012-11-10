//
//  Result.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;
@class Club;

@interface Result : NSManagedObject

@property (nonatomic, retain) NSNumber * firstPlayerScore;
@property (nonatomic, retain) NSNumber * secondPlayerScore;
@property (nonatomic, retain) Player *firstPlayer;
@property (nonatomic, retain) Player *secondPlayer;
@property (nonatomic, retain) Club *club;
@property (nonatomic, retain) NSDate *timeStamp;

@end
