//
//  BaseTableViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/10/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "BaseTableViewController.h"


@implementation BaseTableViewController


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
	self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
    self.backgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];
    self.textColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndex];
    self.view.backgroundColor = self.backgroundColor;
    self.tableView.backgroundColor = self.backgroundColor;

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
    
     if (@available(iOS 11.0, *)) {
          self.view.accessibilityIgnoresInvertColors=NO;
     }
    
   self.view.accessibilityIgnoresInvertColors=YES;
// self.view.accessibilityViewIsModal = YES;

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



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}





@end

