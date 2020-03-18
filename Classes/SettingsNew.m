//
//  SettingsNew.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/4/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "SettingsNew.h"
#import "GlobalMethods.h"
#import <objc/message.h>

@implementation SettingsNew


+(SettingsNew*)settingsFromDictionary:(NSDictionary*)dictionary
{
    SettingsNew* theseSettings= [[SettingsNew alloc] init];


        
        theseSettings.retirementYear = [[dictionary objectForKey:@"retirementYear"] integerValue];
        theseSettings.retirementMonth = [[dictionary objectForKey:@"retirementMonth"] integerValue];
        theseSettings.retirementDay =   [[dictionary objectForKey:@"retirementDay"] integerValue];
        theseSettings.thisYearDaysOff=   [[dictionary objectForKey:@"thisYearDaysOff"] integerValue];
        theseSettings.otherYearsDaysOff=  [[dictionary objectForKey:@"otherYearsDaysOff"] integerValue];
        theseSettings.retirementYearDaysOff= [[dictionary objectForKey:@"retirementYearDaysOff"] integerValue];

        theseSettings.beginWorkhours=       [[dictionary objectForKey:@"beginWorkhours"] integerValue];
         theseSettings.beginWorkMinutes=     [[dictionary objectForKey:@"beginWorkMinutes"] integerValue];
         theseSettings.beginWorkAmPm=     [[dictionary objectForKey:@"beginWorkAmPm"] integerValue];
        theseSettings.endWorkhours=          [[dictionary objectForKey:@"endWorkhours"] integerValue];
        theseSettings.endWorkMinutes=        [[dictionary objectForKey:@"endWorkMinutes"] integerValue];
         theseSettings.endWorkAmPm=          [[dictionary objectForKey:@"endWorkAmPm"] integerValue];
        theseSettings.endWorkNextDay=        [[dictionary objectForKey:@"endWorkNextDay"] integerValue];

        theseSettings.backgroundColorIndex=         [[dictionary objectForKey:@"backgroundColorIndex"] integerValue];
        theseSettings.textColorIndex=         [[dictionary objectForKey:@"textColorIndex"] integerValue];
        // Colors
        theseSettings.imageNameToday=     [dictionary objectForKey:@"imageNameToday"];
        theseSettings.imageNameRetirement=     [dictionary objectForKey:@"imageNameRetirement"];
        theseSettings.imageNameWorkdays=     [dictionary objectForKey:@"imageNameWorkdays"];
        theseSettings.imageNameNonWorkdays=     [dictionary objectForKey:@"imageNameNonWorkdays"];
        theseSettings.imageNameHoliday=     [dictionary objectForKey:@"imageNameHoliday"];
        theseSettings.imageNameManualWorkdays=     [dictionary objectForKey:@"imageNameManualWorkdays"];
        theseSettings.imageNameManualNonWorkdays=     [dictionary objectForKey:@"imageNameManualNonWorkdays"];

        theseSettings.textColorIndexToday=     [[dictionary objectForKey:@"textColorIndexToday"] integerValue];
        theseSettings.textColorIndexRetirement=     [[dictionary objectForKey:@"textColorIndexRetirement"] integerValue];
        theseSettings.textColorIndexWorkdays=     [[dictionary objectForKey:@"textColorIndexWorkdays"] integerValue];
        theseSettings.textColorIndexNonWorkdays=     [[dictionary objectForKey:@"textColorIndexNonWorkdays"] integerValue];
        theseSettings.textColorIndexHoliday=     [[dictionary objectForKey:@"textColorIndexHoliday"] integerValue];
        theseSettings.textColorIndexManualWorkdays=     [[dictionary objectForKey:@"textColorIndexManualWorkdays"] integerValue];
        theseSettings.textColorIndexManualNonWorkdays=     [[dictionary objectForKey:@"textColorIndexManualNonWorkdays"] integerValue];

        theseSettings.currentDisplay=          [dictionary objectForKey:@"currentDisplay"];  // what picture to show
        theseSettings.customPicture=          [[dictionary objectForKey:@"customPicture"]integerValue];

        theseSettings.displayOption=          [dictionary objectForKey:@"displayOption"];

    return theseSettings;
}

- (NSDictionary *)toDictionary {
unsigned int count = 0;
NSMutableDictionary *dictionary = [NSMutableDictionary new];
objc_property_t *properties = class_copyPropertyList([self class], &count);
for (int i = 0; i < count; i++) {
NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
id value = [self valueForKey:key];
if (value == nil) {

        }
else if ([value isKindOfClass:[NSNumber class]]
            || [value isKindOfClass:[NSString class]]
            || [value isKindOfClass:[NSDictionary class]]) {

            [dictionary setObject:value forKey:key];
        }
else if ([value isKindOfClass:[NSObject class]]) {
            [dictionary setObject:[value toDictionary] forKey:key];
        }
else {
NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        }
    }
free(properties);
return dictionary;
}
@end
