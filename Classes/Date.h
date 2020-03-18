//
//  Date.h
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 1/31/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Holiday;
@class SettingsNew;

@interface Date : NSObject{

    


}

// holds info that needs to be preproccesed

@property (nonatomic, assign    ) NSInteger            dayId;
@property (nonatomic, assign    ) NSInteger            year;
@property (nonatomic, assign    ) NSInteger            month;
@property (nonatomic, assign    ) NSInteger            day;
@property (nonatomic, assign    ) NSInteger            weekday;
@property (nonatomic, assign    ) NSInteger            concat;
@property (nonatomic, assign    ) NSInteger            ordinalWeekday;

@property (nonatomic, assign    ) NSInteger            isWeekdayWorkday;

@property (nonatomic, assign    ) NSInteger            holidayId;
@property (nonatomic, retain    ) NSString            *holidayName;
@property (nonatomic, assign    ) NSInteger            isHoliday;

@property (nonatomic, assign    ) NSInteger            isDefaultWorkday;
@property (nonatomic, retain    ) NSString            *defaultImageName;
@property (nonatomic, assign    ) NSInteger            defaultTextColorIndex;

@property (nonatomic, assign    ) NSInteger            isManualWork;
@property (nonatomic, assign    ) NSInteger            isWorkday;

@property (nonatomic, assign    ) NSInteger            isRetirement;

@property (nonatomic, retain    ) NSString            *weekdayName;
@property (nonatomic, retain    ) NSString            *monthName;

@property (nonatomic, retain    ) NSString            *imageName;
@property (nonatomic, assign    ) NSInteger            textColorIndex;

+ (Date*)dateWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary *)toDictionary;
//-(void)workdayCount;
@end

NS_ASSUME_NONNULL_END
