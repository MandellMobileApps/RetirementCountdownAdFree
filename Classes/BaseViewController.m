    //
//  BaseViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/10/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.backgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];
    self.textColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndex];
    self.view.backgroundColor = self.backgroundColor;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)])
    {
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.accessibilityIgnoresInvertColors=YES;
  //  self.view.accessibilityViewIsModal = YES;

    

}

-(void)popThisViewController
{
   // [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];
    self.textColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndex];
    self.view.backgroundColor = self.backgroundColor;
}

- (UIImage *)touchImage
{
    if ( ! _touchImage)
    {
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50.0, 50.0)];
        
        UIGraphicsBeginImageContextWithOptions(clipPath.bounds.size, NO, 0);

        UIBezierPath *drawPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(25.0, 25.0)
                                                                radius:22.0
                                                            startAngle:0
                                                              endAngle:2 * M_PI
                                                             clockwise:YES];

        drawPath.lineWidth = 2.0;
        
        [self.strokeColor setStroke];
        [self.fillColor setFill];

        [drawPath stroke];
        [drawPath fill];
        
        [clipPath addClip];
        
        _touchImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
        
    return _touchImage;
}

// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}




@end
