//
//  SettingsNew.h
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/4/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsNew : NSObject
{
    
}



@property (nonatomic, assign    ) NSInteger retirementYear;
@property (nonatomic, assign    ) NSInteger retirementMonth;
@property (nonatomic, assign    ) NSInteger retirementDay;
@property (nonatomic, assign    ) NSInteger thisYearDaysOff;
@property (nonatomic, assign    ) NSInteger otherYearsDaysOff;
@property (nonatomic, assign    ) NSInteger retirementYearDaysOff;

@property (nonatomic, assign    ) NSInteger beginWorkhours;
@property (nonatomic, assign    ) NSInteger beginWorkMinutes;
@property (nonatomic, assign    ) NSInteger beginWorkAmPm;
@property (nonatomic, assign    ) NSInteger endWorkhours;
@property (nonatomic, assign    ) NSInteger endWorkMinutes;
@property (nonatomic, assign    ) NSInteger endWorkAmPm;
@property (nonatomic, assign    ) NSInteger endWorkNextDay;

@property (nonatomic, assign    ) NSInteger backgroundColorIndex;
@property (nonatomic, assign    ) NSInteger textColorIndex;
// Colors
@property (nonatomic, retain    ) NSString *imageNameToday;
@property (nonatomic, retain    ) NSString *imageNameRetirement;
@property (nonatomic, retain    ) NSString *imageNameWorkdays;
@property (nonatomic, retain    ) NSString *imageNameNonWorkdays;
@property (nonatomic, retain    ) NSString *imageNameHoliday;
@property (nonatomic, retain    ) NSString *imageNameManualWorkdays;
@property (nonatomic, retain    ) NSString *imageNameManualNonWorkdays;

@property (nonatomic, assign    ) NSInteger textColorIndexToday;
@property (nonatomic, assign    ) NSInteger textColorIndexRetirement;
@property (nonatomic, assign    ) NSInteger textColorIndexWorkdays;
@property (nonatomic, assign    ) NSInteger textColorIndexNonWorkdays;
@property (nonatomic, assign    ) NSInteger textColorIndexHoliday;
@property (nonatomic, assign    ) NSInteger textColorIndexManualWorkdays;
@property (nonatomic, assign    ) NSInteger textColorIndexManualNonWorkdays;

@property (nonatomic, retain    ) NSString *currentDisplay;  // what picture to show
@property (nonatomic, assign    ) NSInteger customPicture;

@property (nonatomic, retain    ) NSString *displayOption;   // work or calendar days to show

+(SettingsNew*)settingsFromDictionary:(NSDictionary*)dictionary;
- (NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
