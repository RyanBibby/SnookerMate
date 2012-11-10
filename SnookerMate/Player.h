//
//  Player.h
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject 

@property (nonatomic, retain) NSString *name;
-(NSString*)hasValidName; 
@end
