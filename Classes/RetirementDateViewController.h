//
//  RetirementDateViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"


@interface RetirementDateViewController : BaseTableViewController {
@private
	UIDatePicker *pickerView;
	NSDate *retirementDate;
	NSArray *dataArray;
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView; 
@property (nonatomic, retain) NSDate *retirementDate;
@property (nonatomic, retain) NSArray *dataArray; 
@property (nonatomic, retain) NSDateFormatter *dateFormatter; 


- (IBAction)dateAction:(id)sender;	


@end
