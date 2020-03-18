//
//  BackgroundTextColorViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsClass.h"
#import "BaseViewController.h"


@interface BackgroundTextColorViewController : BaseViewController <UITableViewDelegate> {

}

@property (nonatomic, retain) IBOutlet UILabel *upperLine;
@property (nonatomic, retain) IBOutlet UILabel *lowerLine;
@property (nonatomic, retain) IBOutlet UITableView *backgroundTextColorTable;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign) NSInteger currentIndexPathRow;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSArray *colors;


-(IBAction) startFastScrollUp;
-(IBAction) stopFastScrollUp;
-(void) scrollUp;
-(IBAction) startFastScrollDown;
-(IBAction) stopFastScrollDown;
-(void) scrollDown;

@end
