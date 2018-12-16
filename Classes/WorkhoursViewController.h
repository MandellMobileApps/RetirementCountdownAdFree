//
//  RetirementDateViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface WorkhoursViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
@private
	UIDatePicker *pickerView;
    IBOutlet UIView *pickerViewContainer;
	NSDate *beginWorkhours;
	NSDate *endWorkhours;
	NSArray *dataArray;
	NSArray *detaildataArray;
	NSDateFormatter *dateFormatter;
    IBOutlet UITableView* thisTableView;
    int currentSelection;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, retain) IBOutlet UIView *pickerViewContainer;
@property (nonatomic, retain) IBOutlet UITableView* thisTableView;
@property (nonatomic, retain) NSDate *beginWorkhours;
@property (nonatomic, retain) NSDate *endWorkhours;
@property (nonatomic, retain) NSArray *dataArray; 
@property (nonatomic, retain) NSArray *detaildataArray;
@property (nonatomic, retain) NSDateFormatter *dateFormatter; 
@property (nonatomic) int currentSelection;

- (IBAction)dateAction:(id)sender;
-(IBAction)datePickerDoneButtonTapped:(id)sender;
-(void) showDatePickerForIndex:(int)selection;
-(IBAction)resetHours:(id)sender;
@end
