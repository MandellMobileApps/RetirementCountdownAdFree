//
//  BaseViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/10/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetirementCountdownAppDelegate.h"


@interface BaseViewController : UIViewController  {


}

@property (nonatomic,retain) UIColor *backgroundColor;
@property (nonatomic,retain) UIColor *textColor;

@property (nonatomic,retain) RetirementCountdownAppDelegate *appDelegate;

/** A custom image to use to show touches on screen. If unset, defaults to a partially-transparent stroked circle. */
@property (nonatomic, strong) UIImage *touchImage;

/** The alpha transparency value to use for the touch image. Defaults to 0.5. */
@property (nonatomic, assign) CGFloat touchAlpha;

/** The time over which to fade out touch images. Defaults to 0.3. */
@property (nonatomic, assign) NSTimeInterval fadeDuration;

/** If using the default touchImage, the color with which to stroke the shape. Defaults to black. */
@property (nonatomic, strong) UIColor *strokeColor;

/** If using the default touchImage, the color with which to fill the shape. Defaults to white. */
@property (nonatomic, strong) UIColor *fillColor;

/** Sets whether touches should always show regardless of whether the display is mirroring. Defaults to NO. */
@property (nonatomic, assign) BOOL alwaysShowTouches;

@end
