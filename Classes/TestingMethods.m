//
//  TestingMethods.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/16/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "TestingMethods.h"
#import "GlobalMethods.h"


@implementation TestingMethods


+(void) CreateDatabases {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    NSArray *databases = [[NSArray alloc] initWithObjects:
                          @"Settings.plist",
                          @"ManualWorkdays.plist",
                          @"Workdays.plist",
                          @"HolidayList.plist",
                          @"BackgroundColors.plist",
                          @"TextColors.plist",
                          @"ColorSettings.plist",
                          @"Shiftdays.plist",
  
                          nil];
    for (NSString *db in databases) {
        NSString *pathDoc = [GlobalMethods dataFilePathofDocuments:db];
       
        success = [fileManager fileExistsAtPath:pathDoc];
        if(!success)
        {
 
                NSString *pathApp = [GlobalMethods dataFilePathofBundle:db];
                [fileManager copyItemAtPath:pathApp toPath:pathDoc error:nil];
        }

    }
    
//    NSString *pathDoc2 = [GlobalMethods dataFilePathofDocuments:@"customPicture.png"];
//    NSString *pathApp2 = [GlobalMethods dataFilePathofBundle:@"checkbox-filled.png"];
//     DLog(@"pathApp2 %@",pathApp2);
//     DLog(@"pathDoc2 %@",pathDoc2);
//     [fileManager copyItemAtPath:pathApp2 toPath:pathDoc2 error:nil];
//     BOOL success2 = [fileManager fileExistsAtPath:pathDoc2];
//    DLog(@"success2 %@",success2 ? @"Yes":@"No");

}

@end
