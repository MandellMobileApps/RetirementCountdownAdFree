//
//  DayView.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/4/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "DayView.h"
#import "Calendar.h"
#import "RootViewController.h"
#import "Date.h"
#import "RetirementCountdownAppDelegate.h"
#import "ColorsClass.h"


@implementation DayView

// holds info that needs to just be looked up ie imagenamed. UIColor for name,


+(DayView*)newDayViewWithRect:(CGRect)rect withHandler:(Calendar*)calendar withRoot:(RootViewController*)root atIndex:(NSInteger)thisIndex// this rect is the DayView frame
{

    
    DayView* thisDayView = [[DayView alloc]initWithFrame:rect];
    thisDayView.calendar = calendar;
    thisDayView.rootViewController = root;
    
    thisDayView.currentIndex = thisIndex;
    thisDayView.currentManualState = 0;

    CGRect subRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    thisDayView.lbl  = [[UILabel alloc] initWithFrame:subRect];
    thisDayView.lbl.textAlignment = NSTextAlignmentCenter;
    thisDayView.lbl.font = [UIFont systemFontOfSize:24];
    thisDayView.lbl.backgroundColor = [UIColor clearColor];

    thisDayView.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    thisDayView.btn.frame = subRect;
    thisDayView.btn.tag = thisIndex;
    [thisDayView.btn addTarget:thisDayView action:@selector(dayButtonTapped:) forControlEvents:UIControlEventTouchUpInside];


    
//    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:    self action:@selector(doSingleTap)] autorelease];
//    singleTap.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:singleTap];
//
//     UITapGestureRecognizer *doubleTap = [[[UITapGestureRecognizer alloc] initWithTarget:   self action:@selector(doDoubleTap)] autorelease];
//     doubleTap.numberOfTapsRequired = 2;
//     [self.view addGestureRecognizer:doubleTap];
//
//      [singleTap requireGestureRecognizerToFail:doubleTap];
//
    
    thisDayView.imageView = [[UIImageView alloc] initWithFrame:subRect];
    thisDayView.imageView.backgroundColor = [UIColor clearColor];
    thisDayView.imageView.alpha = 0.65;
    thisDayView.imageView.image = [UIImage imageNamed:@"red-x-outer.png"];
//    thisDayView.imageView.userInteractionEnabled = NO;
//    thisDayView.lbl.userInteractionEnabled = NO;
    
   [thisDayView addSubview:thisDayView.btn];
     [thisDayView addSubview:thisDayView.lbl];
    [thisDayView addSubview:thisDayView.imageView];
     
    
    return thisDayView;

}

-(void)updateViewWithDay:(Date*)date
{

    
    NSString* thisImageName;
    NSInteger textColorIndex;
    if (self.date.concat == self.todayConcat)
     {
         if (self.date.isManualWork)
         {
             thisImageName = self.date.imageName;
             textColorIndex = self.date.textColorIndex;
         }
         else
         {
             thisImageName = self.rootViewController.appDelegate.settingsNew.imageNameToday;
             textColorIndex = self.rootViewController.appDelegate.settingsNew.textColorIndexToday;
         }
     }
     else
     {
         thisImageName = self.date.imageName;
         textColorIndex = self.date.textColorIndex;

     }

     [self.btn setBackgroundImage:[UIImage imageNamed:[GlobalMethods fullImageNameFor:thisImageName]] forState:UIControlStateNormal];
     [self.btn setBackgroundImage:[UIImage imageNamed:[GlobalMethods fullImageNameFor:thisImageName]] forState:UIControlStateHighlighted];

     self.lbl.textColor = [GlobalMethods colorForIndex:textColorIndex];
     
    
}




-(void)updateViewWithDay:(Date*)date  forYear:(NSInteger)year forMonth:(NSInteger)month withTodayConcat:(NSInteger)todayConcat

{

    self.date = date;
    self.currentYear = year;
    self.currentMonth = month;
    self.todayConcat = todayConcat;
    
    
    if (self.currentMonth == self.date.month)
    {
        NSString* thisImageName;
        NSInteger textColorIndex;

        if (self.date.concat == self.todayConcat)
        {
            if ((self.date.isManualWork) || (self.date.isRetirement))
            {
                thisImageName = self.date.imageName;
                textColorIndex = self.date.textColorIndex;
            }
            else
            {
                thisImageName = self.rootViewController.appDelegate.settingsNew.imageNameToday;
                textColorIndex = self.rootViewController.appDelegate.settingsNew.textColorIndexToday;
            }
        }
        else
        {
            thisImageName = self.date.imageName;
            textColorIndex = self.date.textColorIndex;

        }

        
        [self.btn setBackgroundImage:[UIImage imageNamed:[GlobalMethods fullImageNameFor:thisImageName]] forState:UIControlStateNormal];
        [self.btn setBackgroundImage:[UIImage imageNamed:[GlobalMethods fullImageNameFor:thisImageName]] forState:UIControlStateHighlighted];
        


        self.lbl.textColor = [GlobalMethods colorForIndex:textColorIndex];
        
    }
    else
    {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"NotThisMonthPicture"] forState:UIControlStateNormal];
        [self.btn setBackgroundImage:[UIImage imageNamed:@"NotThisMonthPicture"] forState:UIControlStateHighlighted];

        self.lbl.textColor = [UIColor grayColor];
       
    }
    

    // add date to cell

    NSString *daylabeltext = [[NSString alloc] initWithFormat:@"%li", (long)self.date.day];
    self.lbl.text = daylabeltext;

    // is current day before today?  if so, put checkmark on it.
    if (self.date.concat < self.todayConcat)
    {
        self.imageView.hidden = NO;
    }
    else
    {
        self.imageView.hidden = YES;
    }


}

-(void)enableDayButton:(UIButton*)btn
{
    btn.enabled = YES;
}

- (void)dayButtonTapped:(UIButton*)btn
{
    btn.enabled = NO;
    DayView* thisDayView = [self.calendar.currentDisplayDayViews objectAtIndex:btn.tag];
    if (thisDayView.date.month == thisDayView.currentMonth)
    {
        NSString* imageName;
        NSInteger textColor;
  
        if (thisDayView.date.isManualWork == 0)
        {
              thisDayView.date.isManualWork = 1;
        }
        else
        {
             thisDayView.date.isManualWork = 0;
        }
        
        if ((thisDayView.date.isManualWork == 1) && (thisDayView.date.isDefaultWorkday == 0))
        {
            thisDayView.date.isWorkday = 1;
            imageName = self.calendar.appDelegate.settingsNew.imageNameManualWorkdays;
            textColor = self.calendar.appDelegate.settingsNew.textColorIndexManualWorkdays;
            
        }
        else if ((thisDayView.date.isManualWork == 1) && (thisDayView.date.isDefaultWorkday == 1))
        {
            thisDayView.date.isWorkday = 0;
            imageName = self.calendar.appDelegate.settingsNew.imageNameManualNonWorkdays;
            textColor = self.calendar.appDelegate.settingsNew.textColorIndexManualNonWorkdays;
        }
        else
        {
            thisDayView.date.isWorkday = thisDayView.date.isDefaultWorkday;
            imageName = thisDayView.date.defaultImageName;
            textColor = thisDayView.date.defaultTextColorIndex;
            
        }

        thisDayView.date.imageName = imageName;
        thisDayView.date.textColorIndex = textColor;
        [thisDayView updateViewWithDay:thisDayView.date];
        
         NSMutableString *sql = [NSMutableString string];
         [sql appendFormat:@"UPDATE Days SET "];
         
         [sql appendFormat:@" imageName = \"%@\",",imageName];
         [sql appendFormat:@" textColorIndex = %li,",textColor];
         [sql appendFormat:@" isManualWork = %li,",thisDayView.date.isManualWork];
         [sql appendFormat:@" isWorkday = %li",thisDayView.date.isWorkday];
         [sql appendFormat:@" WHERE "];
         [sql appendFormat:@" concat = %li",thisDayView.date.concat];

         [SQLiteAccess updateWithSQL:sql];
        [self.calendar.rootViewController refreshRootViewController];
        [self performSelector:@selector(enableDayButton:) withObject:btn afterDelay:0.5];
    }
    
}




@end
