//
//  StatsController.m
//  Matrun
//
//  Created by Sunil Sayala on 4/10/11.
//  Copyright 2011 Sunil Sayala. All rights reserved.
//

#import "StatsViewController.h"

@implementation StatsViewController
@synthesize delegate;
@synthesize resetStatsPressed;
@synthesize diffSegmentIndex;
@synthesize information;
@synthesize keys;
@synthesize table;
@synthesize sectionTitle;

- (IBAction)resetScores {
    total = 0;
    wrongAttempts = 0;
    resetStatsPressed = YES;
    [table reloadData];
}

- (IBAction)dismissAction {
    if([[self delegate] respondsToSelector:@selector(doneWithStats:)]) {
        [[self delegate] doneWithStats:self];
    }
}

- (void)setCorrectAttemptCount:(NSInteger)count {
    correctAttempts = count;
}

- (void)setWrongAttemptCount:(NSInteger)count {
    wrongAttempts = count;
}

- (void)setTotalCount:(NSInteger)count {
    total = count;
}

- (void)setDifficulty:(NSInteger)setting {
    if(setting == EASY){
        diffSegmentIndex = 0;
    } else {
        diffSegmentIndex = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    resetStatsPressed = NO;
   
    NSString *statsSectionTitle = [NSString stringWithFormat:@"%@ %@",self.sectionTitle, @"Stats"];
    NSArray *sections = [[NSArray alloc] initWithObjects:statsSectionTitle, @"Settings", @"About", nil];
    NSArray *infoArray = [[NSArray alloc] initWithObjects:@"Total Questions", @"Wrong Attempts", nil];
    NSArray *settingArray = [[NSArray alloc] initWithObjects:@"Difficulty", nil];
    NSArray *aboutArray = [[NSArray alloc] initWithObjects:@"Version", nil];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dict setObject:infoArray forKey:statsSectionTitle];
    [dict setObject:settingArray forKey:@"Settings"];
    [dict setObject:aboutArray forKey:@"About"];
    self.information = dict;
    self.keys = sections;
    [sections release];
    [infoArray release];
    [aboutArray release];
    [dict release];

    self.title = @"Matrun";    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *done = [[UIBarButtonItem alloc] 
                             initWithTitle:@" Done "
                             style: UIBarButtonItemStylePlain
                             target:self 
                             action:@selector(dismissAction)];
   
    UIBarButtonItem *reset = [[UIBarButtonItem alloc] 
                              initWithTitle:@" Reset " 
                              style: UIBarButtonItemStylePlain
                              target:self 
                              action:@selector(resetScores)];
    
    self.navigationItem.leftBarButtonItem = reset;
    self.navigationItem.rightBarButtonItem = done;
    [reset release];
    [done release];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.information = nil;
    self.keys = nil;
    self.table = nil;
    self.sectionTitle = nil;
    self.delegate = nil;
}
-(void)dealloc {
    [super dealloc];
    [keys release];
    [information release];
    [table release];
    [delegate release];
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [information objectForKey:key];    
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
	
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [information objectForKey:key];
	
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    static NSString *DifficultyCellIdentifier = @"DifficultyCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    
    DifficultyCell *diffCell = [tableView dequeueReusableCellWithIdentifier:DifficultyCellIdentifier];  
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleValue1
				 reuseIdentifier:SectionsTableIdentifier] autorelease];
    }
    
    if(diffCell == nil){
        diffCell = [[[DifficultyCell alloc]
				 initWithStyle:UITableViewCellStyleValue1
				 reuseIdentifier:DifficultyCellIdentifier] autorelease];
        [diffCell.diffSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
	
    cell.textLabel.text = [nameSection objectAtIndex:row];
    switch (section){
        case 0:
            if (row == 0) {
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",total];
                cell.detailTextLabel.textAlignment = UITextAlignmentRight;
            } 
            else if (row == 1) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",wrongAttempts];
            }
            break;
        case 1:
            if(row == 0){
                [[diffCell diffSegment] setSelectedSegmentIndex:diffSegmentIndex];
                return diffCell;
            }
            
            break;
        case 2:
            if (row == 0) {
                cell.detailTextLabel.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];;
            }
            break;
    }
    
    return cell;
}

// handle event for difficulty change
- (IBAction)segmentAction:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    diffSegmentIndex = segmentedControl.selectedSegmentIndex;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;
}

@end
