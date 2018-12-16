//
//  IAPurchaseViewController.m
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 2/16/16.
//  Copyright © 2016 MandellMobileApps. All rights reserved.
//

#import "IAPurchaseViewController.h"

@implementation IAPurchaseViewController

#define kRemoveAdsProductIdentifier @"put your product id (the one that we just made in iTunesConnect) in here"

//- (IBAction)tapsRemoveAds{
//    NSLog(@"User requests to remove ads");
//    
//    if([SKPaymentQueue canMakePayments]){
//        NSLog(@"User can make payments");
//        
//        //If you have more than one in-app purchase, and would like
//        //to have the user purchase a different product, simply define
//        //another function and replace kRemoveAdsProductIdentifier with
//        //the identifier for the other product
//        
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//        
//    }
//    else{
//        NSLog(@"User cannot make payments due to parental controls");
//        //this is called the user cannot make payments, most likely due to parental controls
//    }
//}
//
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
//    SKProduct *validProduct = nil;
//    int count = [response.products count];
//    if(count > 0){
//        validProduct = [response.products objectAtIndex:0];
//        NSLog(@"Products Available!");
//        [self purchase:validProduct];
//    }
//    else if(!validProduct){
//        NSLog(@"No products available");
//        //this is called if your product id is not valid, this shouldn't be called unless that happens.
//    }
//}
//
//- (void)purchase:(SKProduct *)product{
//    SKPayment *payment = [SKPayment paymentWithProduct:product];
//    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
//}
//
//- (IBAction) restore{
//    //this is called when the user restores purchases, you should hook this up to a button
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
//}
//
//- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
//{
//    NSLog(@"received restored transactions: %i", queue.transactions.count);
//    for(SKPaymentTransaction *transaction in queue.transactions){
//        if(transaction.transactionState == SKPaymentTransactionStateRestored){
//            //called when the user successfully restores a purchase
//            NSLog(@"Transaction state -> Restored");
//            
//            //if you have more than one in-app purchase product,
//            //you restore the correct product for the identifier.
//            //For example, you could use
//            //if(productID == kRemoveAdsProductIdentifier)
//            //to get the product identifier for the
//            //restored purchases, you can use
//            //
//            //NSString *productID = transaction.payment.productIdentifier;
//            [self doRemoveAds];
//            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            break;
//        }
//    }
//}
//
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
//    for(SKPaymentTransaction *transaction in transactions){
//        switch(transaction.transactionState){
//            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
//                //called when the user is in the process of purchasing, do not add any of your own code here.
//                break;
//            case SKPaymentTransactionStatePurchased:
//                //this is called when the user has successfully purchased the package (Cha-Ching!)
//                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//                NSLog(@"Transaction state -> Purchased");
//                break;
//            case SKPaymentTransactionStateRestored:
//                NSLog(@"Transaction state -> Restored");
//                //add the same code as you did from SKPaymentTransactionStatePurchased here
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//                break;
//            case SKPaymentTransactionStateFailed:
//                //called when the transaction does not finish
//                if(transaction.error.code == SKErrorPaymentCancelled){
//                    NSLog(@"Transaction state -> Cancelled");
//                    //the user cancelled the payment ;(
//                }
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//                break;
//        }
//    }
//}

@end
