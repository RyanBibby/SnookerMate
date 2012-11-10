//
//  BreakSelectorViewController.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 17/01/2012.
//

#import "BreakSelectorViewController.h"
#import "ScoringViewController.h"

@implementation BreakSelectorViewController
@synthesize playerOneButton, playerTwoButton, managedObjectContext, playerOne, playerTwo, picker,clubs,clubLabel, clubField, selectedClub, accessoryView;


- (void)viewDidLoad {
    
    // Set club to nil and change background
    self.selectedClub = nil;
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed: @"Background.png"]];
    
    // Set the request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Club" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error;
    NSMutableArray *result = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];

    self.clubs = result;
    [self.playerOneButton setTitle:[self.playerOne name] forState:UIControlStateNormal];
    [self.playerTwoButton setTitle:[self.playerTwo name] forState:UIControlStateNormal];
    
    
    // Set the default club text
    self.clubField.text = @"No Club Selected";
    
    // Alert the user if no clubs exist
    if([self.clubs count] > 0) {
        self.clubField.inputView = self.picker;
        self.clubField.inputAccessoryView = self.accessoryView;
    } else {
        self.clubField.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"No Clubs Exist"];
        [alert setMessage:@"Currently there are no Clubs stored in the system. Frames can still be scored, but club information will not be avalible."];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert release];
    }
    
    [request release];
    [result release];
    [super viewDidLoad];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.selectedClub = [self.clubs objectAtIndex:0];
    self.clubField.text = [[self.clubs objectAtIndex:0] name];
}

- (IBAction)doneEditing:(id)sender {
    [self.clubField resignFirstResponder];
    [self becomeFirstResponder];
}

-(IBAction)playerOneButtonPressed {
    ScoringViewController *scoringViewController = [[ScoringViewController alloc] initWithPlayerOne:self.playerOne andPlayerTwo:self.playerTwo andClub:self.selectedClub];
    scoringViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:scoringViewController animated:YES];
    [scoringViewController release];
}

-(IBAction)playerTwoButtonPressed {
    ScoringViewController *scoringViewController = [[ScoringViewController alloc] initWithPlayerOne:self.playerTwo andPlayerTwo:self.playerOne andClub:self.selectedClub];
    scoringViewController.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:scoringViewController animated:YES];
    [scoringViewController release];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

// Means the viewcontroller can recongise the shake
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// Detects the shake event, and randomly selects a player to break
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    // 
    if (event.subtype == UIEventSubtypeMotionShake) {
        if (arc4random() % 2 == 0){
            [self playerOneButtonPressed];
        }
        else {
            [self playerTwoButtonPressed];
        }
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.clubs count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.clubs objectAtIndex:row] name];
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.selectedClub = [self.clubs objectAtIndex:row];
    self.clubField.text = [[self.clubs objectAtIndex:row] name];
}


- (void)dealloc {
    [playerOneButton release];
    [playerTwoButton release];
    [managedObjectContext release];
    [playerOne release];
    [playerTwo release];
    [picker release];
    [clubs release];
    [clubLabel release];
    [clubField release];
    [selectedClub release];
    [accessoryView release];
    [super dealloc];
}





@end
