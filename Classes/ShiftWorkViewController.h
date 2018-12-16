//
//  ShiftWorkViewController.h
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 9/11/14.
//  Copyright (c) 2014 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "WorkdaysViewController.h"
#import "WorkhoursViewController.h"
#import "PurchaseViewController.h"
#import "HomePurchaseViewController.h"

enum shiftType {
    oneweek = 0,
    twoweek = 1,
    threeweek = 2,
    fourweek = 3,
    custom = 4,
};

enum CornerType {
    CornerTypeRounded = 0,
    CornerTypeSquare = 1,
};

@interface ShiftWorkViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, retain) NSMutableArray *selectedshiftdays;
@property (nonatomic, retain) NSMutableArray *allshiftdays;
@property (nonatomic, retain) NSMutableArray *allworkoffon;

@property (nonatomic, strong) NSMutableArray *shiftdays0;
@property (nonatomic, strong) NSMutableArray *shiftdays1;
@property (nonatomic, strong) NSMutableArray *shiftdays2;
@property (nonatomic, strong) NSMutableArray *shiftdays3;


@property (nonatomic, retain) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerViewOffOn;
@property (nonatomic, strong) IBOutlet UIView *offOnPickerViewContainer;
@property (nonatomic, strong) NSArray *offOnTimeArray;

@property (nonatomic, retain) IBOutlet UIView *pickerViewContainer;
@property (nonatomic, retain) IBOutlet UITableView* thisTableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* beginhoursbutton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* endhoursbutton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* donebutton;

@property (nonatomic, retain) NSDate *currentBeginshiftworkhours;
@property (nonatomic, retain) NSDate *currentEndshiftworkhours;

@property (nonatomic, retain) NSDate *startDateTime;
@property (nonatomic, retain) NSString *hoursOn;
@property (nonatomic, retain) NSString *hoursOff;

@property (nonatomic, strong) NSString *currentShiftLabel;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *detaildataArray;
@property (nonatomic, strong) NSArray *shiftDaysArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSArray *offOnHoursTimeArray;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic) int currentSelection;

//-(void) showDatePickerForIndex:(int)selection;
- (IBAction)dateAction:(id)sender;
-(IBAction)datePickerDoneButtonTapped:(id)sender;
//-(void) showDatePickerForIndex:(int)selection;
-(void) hideDatePicker;
-(void) showDatePickerForDayTimes:(NSMutableDictionary*)temp;
-(IBAction)beginworkhours:(id)sender;
-(IBAction)endworkhours:(id)sender;

@property (nonatomic) BOOL workHoursBeginOn;
//
//-(void)createShiftDays0;
//-(void)createShiftDays1;
//-(void)createShiftDays2;
//-(void)createShiftDays3;

@property (nonatomic) BOOL shiftWorkButtonOn;
-(IBAction)setWeek:(id)sender;
@property (nonatomic) BOOL setWeekButtonOn1;
@property (nonatomic) BOOL setWeekButtonOn2;
@property (nonatomic) BOOL setWeekButtonOn3;
@property (nonatomic) BOOL setWeekButtonOn4;
@property (nonatomic, strong) IBOutlet UIButton *setWeekButton;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) IBOutlet UISegmentedControl *shiftWorkType;

//@property (strong, nonatomic) PurchaseViewController *purchaseViewController;

@property(nonatomic,strong) UIView* keyboardView;
@property(nonatomic,strong) NSMutableString* keyboardEntry;
@property(nonatomic,strong) UILabel* keyboardTitleLabel;
@property(nonatomic,strong) UILabel* keyboardUnitsLabel;
@property(nonatomic,strong) UILabel* keyboardEntryLabel;
@property (nonatomic)  NSInteger  keyboardTag;

@property (nonatomic) BOOL stepsKeypadShowing;
- (void)keyboardButtonClicked:(UIButton*)button;
- (void)keyboardEntryUpdated:(NSString*)entry tag:(NSInteger)tag;
-(void)addNumberPadForString:(NSString*)currentValue withTitle:(NSString*)title andUnits:(NSString*)units tag:(NSInteger)tag;

-(void)addBorderAround:(id)object cornerType:(NSInteger)corner withColor:(UIColor*)color;
-(void)removeBorderFrom:(id)object;
-(void)didReceiveMemoryWarning;


@end
