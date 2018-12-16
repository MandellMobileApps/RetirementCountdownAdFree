//
//  HomePurchaseViewController.m
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 12/26/16.
//  Copyright © 2016 MandellMobileApps. All rights reserved.
//

#import "HomePurchaseViewController.h"
#import "PurchaseViewController.h"  // test

@interface HomePurchaseViewController ()

@property (strong, nonatomic) PurchaseViewController *purchaseViewController;

@end


@implementation HomePurchaseViewController


- (IBAction)purchaseItem:(id)sender {
    self.purchaseViewController = [[PurchaseViewController alloc] initWithNibName:nil bundle:nil];
    
    self.purchaseViewController.productID = @"com.mandellmobileapps.RetirementShiftWork";
    
    [self presentViewController:self.purchaseViewController animated:YES completion:NULL];
    
    [self.purchaseViewController getProductID:self];
}

- (void)Purchased {
    
}

@end
