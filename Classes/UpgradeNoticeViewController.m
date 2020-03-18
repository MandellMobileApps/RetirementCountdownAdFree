//
//  UpgradeNoticeViewController.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/17/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "UpgradeNoticeViewController.h"


@interface UpgradeNoticeViewController ()

@end

@implementation UpgradeNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIBarButtonItem *stopBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Don't Remind Me" style:UIBarButtonItemStylePlain target:self action:@selector(stopNotice)];
    self.navigationItem.rightBarButtonItem = stopBarItem;
    
    NSString* htmlString = @"<font size=\"38\"><ul><p><p><li>Colors were reset back to default.  Your colors will have to be reselected.</li><p><p><li>Your manual days were transfered to the new data structure.  Manual changes are now made by tapping a day, and it will toggle between the default state (workday or non-workday) and the opposite state. </li></ul></font>";
    [self.thisWebView loadHTMLString:htmlString baseURL: nil];
    
}




-(void) stopNotice
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showUpgradeNotice"];

    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
