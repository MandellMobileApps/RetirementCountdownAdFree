//
//  ImagePickerViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/11/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsClass.h"
#import "BaseViewController.h"

@interface ImagePickerViewController : BaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate> {


}

@property (nonatomic, retain) UIImagePickerController *picker;
@property (nonatomic, retain) IBOutlet UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) IBOutlet UIButton *customBtn;
@property (nonatomic, retain) IBOutlet UIButton *defaultBtn;

-(IBAction)customButton:(id)sender;
-(IBAction)defaultButton:(id)sender;



@end
