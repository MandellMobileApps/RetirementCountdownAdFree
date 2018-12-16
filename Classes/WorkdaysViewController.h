//
//  Workdays.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface WorkdaysViewController : BaseViewController {

	NSMutableArray *selectedworkdays;
	NSArray *allworkdays;

	
}

@property (nonatomic, retain) NSMutableArray *selectedworkdays;
@property (nonatomic, retain) NSArray *allworkdays;



@end
