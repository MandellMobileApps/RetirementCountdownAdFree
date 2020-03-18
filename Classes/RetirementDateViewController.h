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

}

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSDate *retirementDate;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;

//@property (nonatomic, assign) BOOL changeMade;

- (IBAction)dateAction:(id)sender;	


@end
