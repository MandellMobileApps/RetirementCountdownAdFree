//
//  FeaturesViewController.h
//  RetirementCountdownAdFree
//
//  Created by Jon Mandell on 9/4/13.
//  Copyright (c) 2013 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ColorsClass.h"

@interface FeaturesViewController : BaseViewController <UIScrollViewDelegate> {


}

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, retain) IBOutlet UILabel *scrollLabel;

@end
