//
//  ImagePickerViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/11/09.
//  Copyright 2009 MandellMobileApps All rights reserved.
//

#import "ImagePickerViewController.h"


@implementation ImagePickerViewController

@synthesize picker,currentImageView, selectedImage;

- (void)viewDidLoad {
	[super viewDidLoad];
	//NSLog(@"self.appDelegate.settings %@",self.appDelegate.settings);

	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	currentImageView.image = [self.appDelegate imageFromCache:[self.appDelegate.settings objectForKey:@"PictureName"]];

}


-(IBAction)customButton:(id)sender {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}

-(IBAction)defaultButton:(id)sender {
	currentImageView.image = [self.appDelegate imageFromCache:@"beach"];
	[self.appDelegate.settings setObject:@"beach" forKey:@"PictureName"];
	self.appDelegate.pictureChanged = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// Set the image for the photo object.
	
	if ([info objectForKey:@"UIImagePickerControllerEditedImage"]) {
		self.selectedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	} else {
		self.selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	}

		self.currentImageView.image = self.selectedImage;
		[self dismissModalViewControllerAnimated:YES];
		NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(self.selectedImage,0.5)];
		NSString *path = [GlobalMethods dataFilePathofDocuments:@"customPicture.png"];
		[imageData writeToFile:path atomically:YES];
		[imageData release];
		[self.appDelegate.settings setObject:@"customPicture" forKey:@"PictureName"];
		self.appDelegate.pictureChanged = YES;
		UIImage *tempImage = [self.appDelegate imageFromCache:@"customPicture"];  // this loads into appDelegate image cache
		if (tempImage) { } // because I hate warnings!!
//	}	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//	currentImageView.image = nil;
	// Release any cached data, images, etc that aren't in use.

}

- (void)viewDidUnload {

}

- (void)dealloc {
	[picker release];
	[currentImageView release];
	[selectedImage release];
    [super dealloc];
}


@end
