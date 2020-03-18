//
//  RetirementDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "RetirementDateViewController.h"



@implementation RetirementDateViewController


- (void)viewDidLoad {
	[super viewDidLoad];

	self.dataArray = [NSArray arrayWithObjects:@"Retirement Date",nil];
    self.year = self.appDelegate.settingsNew.retirementYear;
    self.month = self.appDelegate.settingsNew.retirementMonth;
    self.day = self.appDelegate.settingsNew.retirementDay;
    
    self.retirementDate = [GlobalMethods nsDateFromYear:self.year month:self.month day:self.day];
    
    self.title = @"Retirement Date";
    
    self.pickerView.backgroundColor = [ColorsClass white];
    NSDate* maxDate = [GlobalMethods nsDateFromYear:2042 month:6 day:24];
    self.pickerView.maximumDate = maxDate;

}





#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.dataArray count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	self.appDelegate.settingsChanged = YES;
	// check if our date picker is already on screen
	if (self.pickerView.superview == nil)
	{
		self.pickerView.date = self.retirementDate; 
		[self.view.window addSubview: self.pickerView];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		//
		// compute the start frame
		CGRect screenRect = self.view.bounds;
		CGSize pickerSize = [self.pickerView sizeThatFits:CGSizeZero];
		CGRect startRect = CGRectMake(0.0,
									  screenRect.origin.y + screenRect.size.height,
									  pickerSize.width, pickerSize.height);
		self.pickerView.frame = startRect;
		
		// compute the end frame
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width,
									   pickerSize.height);
		// start the slide up animation
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		
		// we need to perform some post operations after the animation is complete
		[UIView setAnimationDelegate:self];
		
		self.pickerView.frame = pickerRect;
		[UIView commitAnimations];
        
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"CustomCellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCustomCellID];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %li, %li",[GlobalMethods nameOfMonthForInt:self.month],self.day,self.year];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 

}

- (void)slideDownDidStop
{
	// the date picker has finished sliding downwards, so remove it
	[self.pickerView removeFromSuperview];
}

- (IBAction)dateAction:(UIDatePicker*)sender
{
//	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSDateComponents* comps = [GlobalMethods YMDFromNSDate:sender.date];
    
    self.retirementDate = sender.date;
    [self.tableView reloadData];
    
    self.year = comps.year;
    self.month = comps.month;
    self.day = comps.day;
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %li, %li",[GlobalMethods nameOfMonthForInt:self.month],self.day,self.year];
   
    [self.appDelegate updateSettingsInteger:self.year forProperty:@"retirementYear"];
    [self.appDelegate updateSettingsInteger:self.month forProperty:@"retirementMonth"];
    [self.appDelegate updateSettingsInteger:self.day forProperty:@"retirementDay"];


}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	 
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.pickerView.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;

	// start the slide down animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];

	// we need to perform some post operations after the animation is complete
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];

	self.pickerView.frame = endFrame;
	[UIView commitAnimations];

	// deselect the current table row
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *lblDate = [[UILabel alloc] init];
    [lblDate setFont:[UIFont fontWithName:@"Arial" size:10.0]];
 
    return lblDate;
}



@end

