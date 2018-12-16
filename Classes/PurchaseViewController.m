//
//  PurchaseViewController.m
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 3/24/16.
//  Copyright © 2016 MandellMobileApps. All rights reserved.
//

#import "PurchaseViewController.h"
#import "HomePurchaseViewController.h"

//@interface PurchaseViewController ()
//@property (nonatomic, strong) HomePurchaseViewController *homePurchaseViewController;
//@end

@implementation PurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buyButton.enabled = NO;
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)preview:(id)sender
{
    self.imageView.hidden = NO;
    self.doneButton.hidden = NO;
    self.doneButton.enabled = YES;
}

-(IBAction)done:(id)sender {
    
    self.imageView.hidden = YES;
    self.doneButton.hidden = YES;
    self.doneButton.enabled = NO;
    
}

- (void)getProductID:(UIViewController *)viewController
{
//    self.homeViewController = viewController;
//    
//    if ([SKPaymentQueue canMakePayments]) {
//        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
//        request.delegate = self;
//        [request start];
//    }
//    
//    else {
//        self.productDescription.text = @"Please Enable in App purchase in your settings";
//}
}

#pragma mark -
#pragma mark SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *) request didReceiveResponse:(SKProductsResponse *) response {
    
    NSArray * products = response.products;
    
    if (products.count !=0) {
        self.product = products[0];
        self.buyButton.enabled = YES;
        self.productTitle.text = self.product.localizedTitle;
        self.productDescription.text = self.product.localizedDescription;
    }
    
    else {
        self.productTitle.text = @"Product Not Fount";
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products) {
      //  NSLog(@"Product not found:%@" self.products);
    }
}

- (IBAction)BuyProduct:(id)sender {
    SKPayment *payment = [SKPayment paymentWithProduct:self.product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction)restore:(id)sender {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    [self unlockPurchase];
}

- (void)paymentQueue:(SKPaymentQueue *) queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:[self unlockPurchase];
                break;
                
            case SKPaymentTransactionStateFailed:NSLog(@"Transaction Failed"); {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                default:
                break;
                
            }
        }
}

- (void)unlockPurchase {
    self.buyButton.enabled = NO;
    [self.buyButton setTitle:@"Purchased" forState:UIControlStateDisabled];
    //[self.homePurchaseViewController Purchased];
}

//}
//
//-(void)getProductInfo: (ShiftWorkViewController *) viewController
//{
////    self.shiftWorkViewController = viewController;
////    
////    if ([SKPaymentQueue canMakePayments])
////    {
////        SKProductsRequest *request = [[SKProductsRequest alloc]
////                                      initWithProductIdentifiers:
////                                      [NSSet setWithObject:self.productID]];
////        request.delegate = self;
////        
////        [request start];
////    }
////    else
////        self.productDescription.hidden = NO;
////        //@"Please enable In App Purchase in Settings";
//}
//
//#pragma mark -
//#pragma mark SKProductsRequestDelegate
//
//-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
//{
//    
//    NSArray *products = response.products;
//    
//    if (products.count != 0)
//    {
//       // self.product = products[0];
//        self.buyButton.enabled = YES;
//      //  self.productTitle.text = self.product.localizedTitle;
//       // self.productDescription.text = self.product.localizedDescription;
//    } else {
//        self.productDescription.text = @"Product not found";
//    }
//    
//    products = response.invalidProductIdentifiers;
//    
//    for (SKProduct *product in products)
//    {
//        NSLog(@"Product not found: %@", product);
//    }
//}
//
//- (IBAction)buy:(id)sender {
////    SKPayment *payment = [SKPayment paymentWithProduct:self.product];
////    [[SKPaymentQueue defaultQueue] addPayment:payment];
//}
//
//#pragma mark -
//#pragma mark SKPaymentTransactionObserver
//
//-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
//{
//    for (SKPaymentTransaction *transaction in transactions)
//    {
//        switch (transaction.transactionState) {
//            case SKPaymentTransactionStatePurchased:
//                [self unlockShiftWork];
//                [[SKPaymentQueue defaultQueue]
//                 finishTransaction:transaction];
//                break;
//                
//            case SKPaymentTransactionStateFailed:
//                NSLog(@"Transaction Failed");
//                [[SKPaymentQueue defaultQueue]
//                 finishTransaction:transaction];
//                break;
//                
//            default:
//                break;
//        }
//    }
//}
//
//-(void)unlockShiftWork
//{
//    self.buyButton.enabled = NO;
//    [self.buyButton setTitle:@"Purchased"
//                forState:UIControlStateDisabled];
//   // [self.shiftWorkViewController enableShiftWork];
//}

@end
