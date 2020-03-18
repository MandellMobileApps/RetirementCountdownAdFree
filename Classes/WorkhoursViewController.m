//
//  RetirementDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "WorkhoursViewController.h"



@implementation WorkhoursViewController



- (void)viewDidLoad{
	[super viewDidLoad];

    
    self.hourArray = [self loadhourarray];
    self.minuteArray = [self loadMinuteArray];
    self.ampmArray = [self loadAmPmArray];
 
    self.dataArray = [NSArray arrayWithObjects:@"Begin", @"End",nil];
	self.detaildataArray = [NSArray arrayWithObjects:[self formattedTimeStringforBeginWorkhours],[self formattedTimeStringforEndWorkhours],nil];
    self.currentSelection = -1;
    
	self.pickerViewContainer.frame = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    self.pickerViewContainer.hidden = YES;
    
    self.pickerViewContainer.accessibilityIgnoresInvertColors=YES;
    self.pickerView.accessibilityIgnoresInvertColors=YES;
    
}

-(void)refreshData
{
        self.detaildataArray = [NSArray arrayWithObjects:[self formattedTimeStringforBeginWorkhours],[self formattedTimeStringforEndWorkhours],nil];
    [self.thisTableView reloadData];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self capturescreen];

//
//    // start the slide down animation
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
//
//    //self.pickerView.frame = endFrame;
//    [UIView commitAnimations];
//
//    // deselect the current table row
//    NSIndexPath *indexPath = [self.thisTableView indexPathForSelectedRow];
//    [self.thisTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSData*)capturescreen {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screencapture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageinpng = UIImagePNGRepresentation(screencapture);
    NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"WorkhoursScreenCapture"];
    [imageinpng writeToFile:pathName atomically:YES];
    NSData *returnData = [[NSData alloc] initWithData:imageinpng];
    return returnData;
}

-(IBAction)datePickerDoneButtonTapped:(id)sender {
    
    [self showDatePickerForIndex:-1];
    [self refreshData];
    [self.thisTableView reloadData];
    
}

-(void) showDatePickerForIndex:(NSInteger)selection {

	if (selection == -1)
    {
		[self hideDatePicker];
    }
    else if (selection == 0)
    {
    	self.headerText = @"Begin Hours";
        if (self.currentSelection == 1)
        {
        	[self hideDatePicker];
            [self performSelector:@selector(showDatePicker) withObject:nil afterDelay:0.6];
        
        }
        else if (self.currentSelection < 0)
        {
        	[self showDatePicker];
        }

    }
    else if (selection == 1)
    {
        self.headerText = @"End Hours";
        if (self.currentSelection == 0)
        {
        	[self hideDatePicker];
            [self performSelector:@selector(showDatePicker) withObject:nil afterDelay:0.6];
        
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
    CGRect    hideRect = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    self.pickerViewContainer.frame = hideRect;
    self.pickerViewContainer.hidden = NO;
    self.header.text = self.headerText;
    
    CGRect  showRect = CGRectMake(0,self.view.bounds.size.height-250, 320, 250);
    [UIView animateWithDuration:0.5
        animations:^{
            self.pickerViewContainer.frame = showRect;
        }
        completion:^(BOOL finished){
             if (self.currentSelection == 0)
             {
                 [self.pickerView selectRow:self.appDelegate.settingsNew.beginWorkhours-1 inComponent:0 animated:YES];
                 [self.pickerView selectRow:self.appDelegate.settingsNew.beginWorkMinutes-1 inComponent:1 animated:YES];
                 [self.pickerView selectRow:self.appDelegate.settingsNew.beginWorkAmPm inComponent:2 animated:YES];
                 
             }
            else
            {
                [self.pickerView selectRow:self.appDelegate.settingsNew.endWorkhours-1 inComponent:0 animated:YES];
                [self.pickerView selectRow:self.appDelegate.settingsNew.endWorkMinutes-1 inComponent:1 animated:YES];
                [self.pickerView selectRow:self.appDelegate.settingsNew.endWorkAmPm inComponent:2 animated:YES];
            }
        }];
}

-(void) hideDatePicker
{
	
    
    CGRect	hideRect = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    [UIView animateWithDuration:0.5
        animations:^{
            self.pickerViewContainer.frame = hideRect;
        }
        completion:^(BOOL finished){
        self.pickerViewContainer.hidden = YES;
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
	tableView.backgroundColor = self.backgroundColor;
	return [self.dataArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	 static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.opaque = NO;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.opaque = NO;
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
	cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [self.detaildataArray objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
	[self showDatePickerForIndex:indexPath.row];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger thisRow = 0;
    if (component == 0)
    {
        thisRow = 12;
    }
    else  if (component == 1)
    {
        thisRow = 60;
    }
    else  if (component == 2)
    {
        thisRow = 2;
    }
    return thisRow;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title;
    if (component == 0)
    {
        title = [self.hourArray objectAtIndex:row];
    }
    else  if (component == 1)
    {
         title = [self.minuteArray objectAtIndex:row];
    }
        else  if (component == 2)
    {
         title = [self.ampmArray objectAtIndex:row];
    }
    return title;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        if (self.currentSelection == 0)
        {
             [self.appDelegate updateSettingsInteger:[[self.hourArray objectAtIndex:row] integerValue] forProperty:@"beginWorkhours"];
            
        }
        else if (self.currentSelection == 1)
        {
            [self.appDelegate updateSettingsInteger:[[self.hourArray objectAtIndex:row] integerValue] forProperty:@"endWorkhours"];
        }
        
    }
    else  if (component == 1)
    {
        if (self.currentSelection == 0)
        {
             [self.appDelegate updateSettingsInteger:[[self.minuteArray objectAtIndex:row] integerValue] forProperty:@"beginWorkMinutes"];

        }
        else if (self.currentSelection == 1)
        {
            [self.appDelegate updateSettingsInteger:[[self.minuteArray objectAtIndex:row] integerValue] forProperty:@"endWorkMinutes"];
            
        }

    }
        else  if (component == 2)
    {
        if (self.currentSelection == 0)
        {
            [self.appDelegate updateSettingsInteger:row forProperty:@"beginWorkAmPm"];
        }
        else if (self.currentSelection == 1)
        {
            [self.appDelegate updateSettingsInteger:row forProperty:@"endWorkAmPm"];

        }
 
    }
    [self refreshData];
    
    
    
}

-(NSString*)formattedTimeStringforBeginWorkhours
{
    NSString* tod = [NSString string];
    if (self.appDelegate.settingsNew.beginWorkAmPm == 0)
    {
        tod = @"AM";
        
    }
    else if (self.appDelegate.settingsNew.beginWorkAmPm == 1)
    {
        tod = @"PM";
        
    }
    NSString* dateString = [NSString stringWithFormat:@"%li:%02ld %@",self.appDelegate.settingsNew.beginWorkhours,self.appDelegate.settingsNew.beginWorkMinutes,tod];
    
    return dateString;
}

-(NSString*)formattedTimeStringforEndWorkhours
{
     NSString* tod = [NSString string];
     if (self.appDelegate.settingsNew.endWorkAmPm == 0)
     {
         tod = @"AM";
         
     }
     else if (self.appDelegate.settingsNew.endWorkAmPm == 1)
     {
         tod = @"PM";
         
     }
     NSString* dateString = [NSString stringWithFormat:@"%li:%02ld %@",self.appDelegate.settingsNew.endWorkhours,self.appDelegate.settingsNew.endWorkMinutes,tod];
    
    return dateString;
}


-(NSArray*)loadhourarray
{
    NSArray* array = [NSArray arrayWithObjects:
                      @"1",
                      @"2",
                      @"3",
                      @"4",
                      @"5",
                      @"6",
                      @"7",
                      @"8",
                      @"9",
                      @"10",
                      @"11",
                      @"12",
                      nil];
    return array;
}

-(NSArray*)loadMinuteArray
{
    NSMutableArray* temp = [NSMutableArray array];
    for (NSInteger i = 0;i<60;i++)
    {
        [temp addObject:[NSString stringWithFormat:@"%02ld",i]];
    }

    NSArray* array = [NSArray arrayWithArray:temp];
    return array;

}

-(NSArray*)loadAmPmArray
{
    NSArray* array = [NSArray arrayWithObjects:
                      @"AM",
                      @"PM",
                      nil];
    return array;

}
@end

