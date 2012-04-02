//
//  DifficultyCell.m
//  Matrun
//
//  Created by Jesse Bergslien on 3/29/12.
//  Copyright (c) 2012 Sunil Sayala. All rights reserved.
//

#import "DifficultyCell.h"

@implementation DifficultyCell
@synthesize diffSegment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){        
        diffSegment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(120, -1, 181, 46)];
        [diffSegment insertSegmentWithTitle:@"Easy" atIndex:0 animated:NO];
        [diffSegment insertSegmentWithTitle:@"Hard" atIndex:1 animated:NO];
        
        diffSegment.tag = 1;
        diffSegment.selectedSegmentIndex = 0;
        
        self.textLabel.text = @"Difficulty";
        [self.contentView addSubview: diffSegment];
        [diffSegment release];
        
    }
    
    return self;
}



@end
