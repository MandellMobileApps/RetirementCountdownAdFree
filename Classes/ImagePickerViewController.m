//
//  ImagePickerViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/11/09.
//  Copyright 2009 MandellMobileApps All rights reserved.
//

#import "ImagePickerViewController.h"


@implementation ImagePickerViewController

- (void)viewDidLoad {
	[super viewDidLoad];


    NSString* fullImageName;
    if (self.appDelegate.settingsNew.customPicture == 0)
    {
        fullImageName = [GlobalMethods fullImageNameFor:DefaultPicture];
    
    }
    else
    {
        fullImageName = [GlobalMethods fullImageNameFor:CustomPicture];
        
    }
     UIImage* tempImage =[UIImage imageWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:fullImageName]];
    
    self.currentImageView.image = tempImage;
    
    [self.customBtn setBackgroundColor:self.backgroundColor];
    [self.defaultBtn setBackgroundColor:self.backgroundColor];
    [self.customBtn setTitleColor:self.textColor forState:UIControlStateHighlighted];
    [self.customBtn setTitleColor:self.textColor forState:UIControlStateNormal];
    [self.defaultBtn setTitleColor:self.textColor forState:UIControlStateHighlighted];
    [self.defaultBtn setTitleColor:self.textColor forState:UIControlStateNormal];

   

}


-(IBAction)customButton:(id)sender {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];

}

-(IBAction)defaultButton:(id)sender {
    NSString* fullImageName = [GlobalMethods fullImageNameFor:DefaultPicture];
    UIImage* tempImage =[UIImage imageWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:fullImageName]];
    
    self.currentImageView.image = tempImage;
    [self.appDelegate updateSettingsInteger:0 forProperty:@"customPicture"];
    [self.appDelegate updateSettingsString:@"Picture" forProperty:@"currentDisplay"];
	self.appDelegate.pictureChanged = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// Set the image for the photo object.
	
	if ([info objectForKey:@"UIImagePickerControllerEditedImage"]) {
		self.selectedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	} else {
		self.selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	}

    self.currentImageView.image = self.selectedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(self.selectedImage,0.5)];
    NSString *path = [GlobalMethods dataFilePathofDocuments:[GlobalMethods fullImageNameFor:CustomPicture]];
    BOOL success = [imageData writeToFile:path atomically:YES];
    if(!success)
     {
         [self.appDelegate addToDebugLog:@"saving custom picture failed" ofType:DebugLogTypeError];
     }
    [self.appDelegate updateSettingsInteger:1 forProperty:@"customPicture"];
    [self.appDelegate updateSettingsString:@"Picture" forProperty:@"currentDisplay"];
    self.appDelegate.pictureChanged = YES;
    [self.navigationController popViewControllerAnimated:YES];

	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
}








@end
