//
//  TimeRemaining.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/7/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TimeRemaining : NSObject {

	

}

-(NSArray*)getTimeRemainingFor:(NSDate*)retirementDatePlus1;
-(NSDateComponents*)getAbsoluteTimeRemaining:(NSDate*)retirementDate;

@end
