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

}

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UIView *pickerViewContainer;
@property (nonatomic, retain) IBOutlet UITableView* thisTableView;
@property (nonatomic, retain) IBOutlet UILabel* header;
@property (nonatomic, retain)  NSString* headerText;

@property (nonatomic, retain) NSArray *dataArray; 
@property (nonatomic, retain) NSArray *detaildataArray;

@property (nonatomic, retain) NSArray *hourArray;
@property (nonatomic, retain) NSArray *minuteArray;
@property (nonatomic, retain) NSArray *ampmArray;

@property (nonatomic) NSInteger currentSelection;


//
//- (IBAction)dateAction:(id)sender;
-(IBAction)datePickerDoneButtonTapped:(id)sender;
-(void) showDatePickerForIndex:(NSInteger)selection;
-(IBAction)resetHours:(id)sender;
@end
