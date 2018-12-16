//
//  ShiftWorkDetailViewController.h
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 9/11/14.
//  Copyright (c) 2014 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ShiftWorkDetailViewController : BaseViewController

@property (nonatomic, retain) NSMutableArray *selectedworkdays;
@property (nonatomic, retain) NSArray *allworkdays;
@property (nonatomic, retain) NSArray *settings;

@property (nonatomic) int shiftType;

@end
