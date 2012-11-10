//
//  AddPlayerViewController.m
//  SnookerMate
//
//  Created by Ryan  Bibby on 11/01/2012.
//  Copyright 2012 Mark Dessain. All rights reserved.
//

#import "AddPlayerViewController.h"
#import "Player.h"


@implementation AddPlayerViewController
@synthesize nameField,managedObjectContext, player;

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(id)init {
    self = [super init];
    if (self) {
        player = nil;
    }
    
    return self;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (player != nil) {
        self.nameField.text = player.name;
    }
    
    // An Save button to enable the club to be added or updated
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(createPlayer)];
    self.navigationItem.rightBarButtonItem  = saveButton;
    [saveButton release];
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed: @"Background.png"]];
}

-(void) createPlayer {
    BOOL createMode = NO;
    if (self.player == nil) {
        createMode = YES;
        self.player = (Player *) [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
        [self.player setName: self.nameField.text];
    }
    else {
        [self.player setName: self.nameField.text];
       
    }
    NSString *errorMessage = [self.player hasValidName];
    if (errorMessage != nil) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Error"];
        [alert setMessage:errorMessage];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert release];
        [self.managedObjectContext rollback];
        
        //Player was not created, reset back to nil
        if (createMode) {
            self.player = nil;
        }
    }
    else {
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            //This error case should never be triggered.
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Fatal Error"];
            [alert setMessage:@"Unknown error, please try again."];
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            [alert release];
            [self.managedObjectContext rollback];      
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)dealloc {
    [nameField release];
    [managedObjectContext release];
    [player release];
    [super dealloc];
}


@end
