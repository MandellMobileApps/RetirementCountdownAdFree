//
//  HomePurchaseViewController.h
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 12/26/16.
//  Copyright © 2016 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "ShiftWorkViewController.h"
//#import "PurchaseViewController.h"

@interface HomePurchaseViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *buyButton;
@property (nonatomic, strong) IBOutlet UILabel *label;


//@property (strong, nonatomic) PurchaseViewController *purchaseViewController;

- (void)Purchased;
- (IBAction)purchaseItem:(id)sender;

@end
