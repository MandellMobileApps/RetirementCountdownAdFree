//
//  RetirementDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "RetirementDateViewController.h"


@implementation RetirementDateViewController

@synthesize pickerView, dataArray, dateFormatter, retirementDate; //, didchange;

- (void)viewDidLoad {
	[super viewDidLoad];

	self.dataArray = [NSArray arrayWithObjects:@"Retirement Date",nil];
    
    self.title = @"Retirement Date";
	
	self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	self.retirementDate = [self.appDelegate.settings objectForKey:@"RetirementDate"];
	self.pickerView.date = self.retirementDate; 
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

}

- (void)viewDidUnload  {
	[super viewDidUnload];
	self.dataArray = nil;
	self.dateFormatter = nil;
}




#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	return [self.dataArray count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	
	
	// check if our date picker is already on screen
	if (self.pickerView.superview == nil)
	{
		self.pickerView.date = self.retirementDate; 
		[self.view.window addSubview: self.pickerView];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		//
		// compute the start frame
		CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
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
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCustomCellID] autorelease];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.retirementDate];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)slideDownDidStop
{
	// the date picker has finished sliding downwards, so remove it
	[self.pickerView removeFromSuperview];
}

- (IBAction)dateAction:(id)sender
{
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.pickerView.date];
	self.appDelegate.colorsChanged = YES;

}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit) fromDate:self.pickerView.date];
	NSDate *retirementDateatMidnight= [gregorian dateFromComponents:comps];
	[gregorian release];	

	self.retirementDate = retirementDateatMidnight;
	[self.appDelegate.settings setObject:self.retirementDate forKey:@"RetirementDate"];		

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


- (void)dealloc
{	
	[pickerView release];
	[retirementDate release];
	[dataArray release];
	[dateFormatter release];
	[super dealloc];
}

@end

