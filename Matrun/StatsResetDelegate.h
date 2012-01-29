//
//  StatsResetDelegate.h
//  Matrun
//
//  Created by Sunil Sayala on 4/16/11.
//  Copyright 2011 Sunil Sayala. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol StatsResetDelegate <NSObject>
-(void) doneWithStats:(id)controller;
@end