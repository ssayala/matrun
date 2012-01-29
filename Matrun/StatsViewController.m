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

- (void)viewDidLoad {
    [super viewDidLoad];
    resetStatsPressed = NO;
   
    NSString *statsSectionTitle = [NSString stringWithFormat:@"%@ %@",self.sectionTitle, @"Stats"];
    NSArray *sections = [[NSArray alloc] initWithObjects:statsSectionTitle, @"About", nil];
    NSArray *infoArray = [[NSArray alloc] initWithObjects:@"Total Questions", @"Wrong Attempts", nil];
    NSArray *aboutArray = [[NSArray alloc] initWithObjects:@"Version", nil];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    [dict setObject:infoArray forKey:statsSectionTitle];
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
                             style: UIBarButtonItemStyleDone
                             target:self 
                             action:@selector(dismissAction)];
   
    UIBarButtonItem *reset = [[UIBarButtonItem alloc] 
                              initWithTitle:@" Reset " 
                              style: UIBarButtonItemStyleDone
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
    [sectionTitle release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleValue1
				 reuseIdentifier:SectionsTableIdentifier] autorelease];
    }
	
    cell.textLabel.text = [nameSection objectAtIndex:row];
    if (section == 0) {
        if (row == 0) {
                                         
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",total];
            cell.detailTextLabel.textAlignment = UITextAlignmentRight;
        } 
        else if (row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",wrongAttempts];
        }
    }
    if (section == 1) {
        if (row == 0) {
            cell.detailTextLabel.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;
}

@end
