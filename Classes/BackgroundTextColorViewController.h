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

	NSString *backgroundColorName;
	NSString *backgroundTextColorName;
	NSUInteger backgroundColorIndex;
	NSUInteger backgroundTextColorIndex;
	NSString *currentObject;
	IBOutlet UILabel *upperLine;
	IBOutlet UILabel *lowerLine;
	IBOutlet UITableView *backgroundTextColorTable;
	int currentRow;
	int currentIndexPathRow;
	NSTimer *timer;
}
@property (nonatomic, retain) NSString *backgroundColorName;
@property (nonatomic, retain) NSString *backgroundTextColorName;
@property (nonatomic, assign) NSUInteger backgroundColorIndex;
@property (nonatomic, assign) NSUInteger backgroundTextColorIndex;
@property (nonatomic, retain) NSString *currentObject;
@property (nonatomic, retain) IBOutlet UILabel *upperLine;
@property (nonatomic, retain) IBOutlet UILabel *lowerLine;
@property (nonatomic, retain) IBOutlet UITableView *backgroundTextColorTable;
@property (nonatomic, assign) int currentRow;
@property (nonatomic, assign) int currentIndexPathRow;
@property (nonatomic, retain) NSTimer *timer;


-(IBAction) startFastScrollUp;
-(IBAction) stopFastScrollUp;
-(void) scrollUp;
-(IBAction) startFastScrollDown;
-(IBAction) stopFastScrollDown;
-(void) scrollDown;

@end
