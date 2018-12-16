//
//  RetirementDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "WorkhoursViewController.h"


@implementation WorkhoursViewController

@synthesize pickerView, dataArray, detaildataArray, dateFormatter, beginWorkhours, endWorkhours, pickerViewContainer,thisTableView, currentSelection;

- (void)viewDidLoad{
	[super viewDidLoad];
	self.dataArray = [NSArray arrayWithObjects:@"Begin", @"End",nil];
	self.currentSelection = -1;
	self.dateFormatter = [[NSDateFormatter alloc] init];
	[self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	self.beginWorkhours = [self.appDelegate.settings objectForKey:@"BeginWorkhours"];
	self.endWorkhours = [self.appDelegate.settings objectForKey:@"EndWorkhours"];
	self.detaildataArray = [NSArray arrayWithObjects:self.beginWorkhours,self.endWorkhours,nil];
	
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	self.pickerViewContainer.frame = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    self.pickerViewContainer.hidden = YES;

    
}

- (void)viewDidUnload{
	[super viewDidUnload];
	self.dataArray = nil;
	self.dateFormatter = nil;
}

//-(IBAction)datePickerValueChanged:(UIDatePicker*)sender {
//	[self.thisTableView reloadData];
//}


-(IBAction)datePickerDoneButtonTapped:(id)sender {
    
    self.pickerViewContainer.hidden = YES;
    [self showDatePickerForIndex:-1];
    [self.thisTableView reloadData];
    
}

-(void) showDatePickerForIndex:(int)selection {

	if (selection == -1)
    {
		[self hideDatePicker];
    }
    else if (selection == 0)
    {
    	if (self.currentSelection == 1)
        {
        	[self hideDatePicker];
            [self performSelector:@selector(showDatePicker) withObject:nil afterDelay:0.25];
        
        }
        else if (self.currentSelection < 0)
        {
        	[self showDatePicker];
        }

    }
    else if (selection == 1)
    {
    	if (self.currentSelection == 0)
        {
        	[self hideDatePicker];
            [self performSelector:@selector(showDatePicker) withObject:nil afterDelay:0.25];
        
        }
        else if (self.currentSelection < 0)
        {
        	[self showDatePicker];
        }        
    }
	self.currentSelection = selection;
}

-(void) showDatePicker
{
    self.pickerViewContainer.hidden = NO;
    
    CGRect  showRect = CGRectMake(0,self.view.bounds.size.height-250, 320, 250);
    [UIView animateWithDuration:0.2
        animations:^{
           // [self.view addSubview:self.pickerViewContainer];
            self.pickerViewContainer.frame = showRect;
        }
        completion:^(BOOL finished){

        }];
}

-(void) hideDatePicker
{
	
    self.pickerViewContainer.hidden = YES;
    CGRect	hideRect = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    [UIView animateWithDuration:0.2
        animations:^{
            self.pickerViewContainer.frame = hideRect;
        }
        completion:^(BOOL finished){
//            [self.pickerViewContainer removeFromSuperview];
        }];


}

-(IBAction)resetHours:(id)sender{
    
    NSIndexPath *indexPath = [self.thisTableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.thisTableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = @"";
}


#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	return [self.dataArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	 static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:[self.detaildataArray objectAtIndex:indexPath.row]];
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
	self.pickerView.date = [self.detaildataArray objectAtIndex:indexPath.row]; 	
	[self showDatePickerForIndex:indexPath.row];
    
}

//- (void)slideDownDidStop{
////	// the date picker has finished sliding downwards, so remove it
////	[self.pickerView removeFromSuperview];
//}

- (IBAction)dateAction:(id)sender{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentSelection inSection:0];
	UITableViewCell *cell = [self.thisTableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.pickerView.date];
    NSLog(@"textLabel %@",cell.textLabel.text);
    NSLog(@"cell.detailTextLabel.text %@",cell.detailTextLabel.text);
    
	if (self.currentSelection == 0) {self.beginWorkhours = self.pickerView.date;}
	if (self.currentSelection == 1) {self.endWorkhours = self.pickerView.date;}
    NSLog(@"beginWorkhours %@",self.beginWorkhours);
    NSLog(@"endWorkhours %@",self.endWorkhours);
	self.appDelegate.colorsChanged = YES;
    
    self.detaildataArray = [NSArray arrayWithObjects:self.beginWorkhours,self.endWorkhours,nil];
//    [self.thisTableView reloadData];

}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[self.appDelegate.settings setObject:self.beginWorkhours forKey:@"BeginWorkhours"];	
	[self.appDelegate.settings setObject:self.endWorkhours forKey:@"EndWorkhours"];		
//
//	// start the slide down animation
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.3];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
//
//	//self.pickerView.frame = endFrame;
//	[UIView commitAnimations];
//
//	// deselect the current table row
//	NSIndexPath *indexPath = [self.thisTableView indexPathForSelectedRow];
//	[self.thisTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc{	
	[pickerView release];
	[beginWorkhours release];
	[endWorkhours release];
	[dataArray release];
	[detaildataArray release];
	[dateFormatter release];
	[super dealloc];
}

@end

