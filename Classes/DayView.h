//
//  DayView.h
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/4/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Calendar;
@class RootViewController;
@class Date;
@class RetirementCountdownAppDelegate;

@interface DayView : UIView

// holds info that needs to just be looked up ie imagenamed. UIColor for name,

@property (nonatomic, retain    ) UILabel    *lbl;
@property (nonatomic, retain    ) UIButton    *btn;

@property (nonatomic, retain    ) UIImageView  *imageView;
@property (nonatomic, retain    ) Calendar  *calendar;
@property (nonatomic, retain    ) RootViewController  *rootViewController;
@property (nonatomic, retain    ) Date  *date;
@property (nonatomic, assign)   NSInteger currentYear;
@property (nonatomic, assign)   NSInteger currentMonth;

@property (nonatomic, assign)   NSInteger todayConcat;

@property (nonatomic, assign)   NSInteger currentIndex;

@property (nonatomic, assign)   NSInteger currentManualState;

+(DayView*)newDayViewWithRect:(CGRect)rect withHandler:(Calendar*)calendar withRoot:(RootViewController*)root atIndex:(NSInteger)thisIndex;
-(void)updateViewWithDay:(Date*)date  forYear:(NSInteger)year forMonth:(NSInteger)month withTodayConcat:(NSInteger)todayConcat;
-(void)updateViewWithDay:(Date*)date;

- (void)dayButtonTapped:(UIButton*)btn;
@end

NS_ASSUME_NONNULL_END
