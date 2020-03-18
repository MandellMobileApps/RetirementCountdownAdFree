//
//  UtilityMethods.h
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/16/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilityMethods : UIView

+(void) deleteExistingTable;
+(void)addDays;
+(void)buildNewTableWith:(NSMutableArray*)array;
+(void) CreateDatabasesTemp;
+(void)addHolidays;
+(void) addThanksgivings;
+(NSString*)checkNull:(id)thisString;
+(NSString*)checkIntegers:(id)thisString;
+(void)addColors;


@end

NS_ASSUME_NONNULL_END
