//
//  PurchaseViewController.h
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 3/24/16.
//  Copyright © 2016 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "ShiftWorkViewController.h"
//#import "HomePurchaseViewController.h"  test

@interface PurchaseViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (nonatomic, strong) IBOutlet UITextView *productDescription;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

- (IBAction)buy:(id)sender;
- (IBAction)preview:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)restore:(id)sender;


@property (nonatomic, strong) IBOutlet UIButton *previewButton;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) IBOutlet UIButton *goBack;

//@property (nonatomic, strong) HomePurchaseViewController *homePurchaseViewController;

//- (void)getProductID:(HomePurchaseViewController *)viewController;
- (void)unlockPurchase;
//- (void)getProductInfo:(UIViewController *)viewController;
//
//@property (nonatomic, weak) ShiftWorkViewController *shiftWorkViewController;

@end
