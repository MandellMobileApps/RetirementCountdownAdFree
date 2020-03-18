//
//  ColorsViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellForColors.h"
#import "ColorsClass.h"
#import "BaseViewController.h"


@interface ColorsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
}

@property (nonatomic, retain) NSArray *backgroundImages;
@property (nonatomic, retain) NSArray *textColors;
@property (nonatomic, retain) IBOutlet UITableView *tableViewButton;
@property (nonatomic, retain) IBOutlet UITableView *tableViewLabel;
@property (nonatomic, retain) IBOutlet UIButton *dayButton;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;
@property (nonatomic, assign) NSInteger currentDaySelected;
@property (nonatomic, assign) NSInteger currentColorIndexSelected;
@property (nonatomic, assign) NSString* currentImageNameSelected;


@end
