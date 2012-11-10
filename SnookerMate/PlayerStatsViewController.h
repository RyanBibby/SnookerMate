//
//  PlayerStatsViewController.h
//  SnookerMate
//
//  Created by Guest User on 21/01/2012.
//  Copyright (c) 2012 Mark Dessain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStatsViewController : UIViewController
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  

@property (nonatomic, retain) IBOutlet UILabel *winLabel;
@property (nonatomic, retain) IBOutlet UILabel *loseLabel;
@end
