//
//  DaysViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "DaysViewController.h"



@implementation DaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.backgroundSettings = [NSArray arrayWithObjects:@"Today", @"Retirement Day", @"Workdays", @"Non-Workdays", @"Custom Holidays", @"Manual Workdays", @"Manual Non-Workdays",  @"Background", nil];


}

-(NSString*)imageNameForIndex:(NSInteger)row
{
    NSString* name;
    switch (row) {
        case 0:
            name = self.appDelegate.settingsNew.imageNameToday;
        break;
        case 1:
            name = self.appDelegate.settingsNew.imageNameRetirement;
            break;
        case 2:
            name = self.appDelegate.settingsNew.imageNameWorkdays;
        break;
        case 3:
            name = self.appDelegate.settingsNew.imageNameNonWorkdays;
        break;
        case 4:
            name = self.appDelegate.settingsNew.imageNameHoliday;
        break;
        case 5:
            name = self.appDelegate.settingsNew.imageNameManualWorkdays;
        break;
        case 6:
            name = self.appDelegate.settingsNew.imageNameManualNonWorkdays;
        break;
            
        default:
            break;
    }
    return name;
    
    
    
}

-(UIColor*)textColorForIndex:(NSInteger)row
{
    UIColor* name;
    switch (row) {
        case 0:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexToday];
        break;
        case 1:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexRetirement];
            break;
        case 2:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexWorkdays];
        break;
        case 3:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexNonWorkdays];
        break;
        case 4:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexHoliday];
        break;
        case 5:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexManualWorkdays];
        break;
        case 6:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexManualNonWorkdays];
        break;
            
        default:
            break;
    }
    return name;
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableViewForReload reloadData];
}




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.backgroundSettings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UILabel *mainLabel;
	if (indexPath.row < 7) {		
		static NSString *CellIdentifier = @"customCell";
		CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			NSArray *cellobjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
			for (id currentObject in cellobjects){
				if([currentObject isKindOfClass:[UITableViewCell class]]){
					cell = (CustomCell *) currentObject;
				}
			}
			
		}
		NSString *buttonPictureName = [self imageNameForIndex:indexPath.row];
        UIImage *buttonBackground = [UIImage imageNamed:[GlobalMethods fullImageNameFor:buttonPictureName]];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
		cell.dayLabel.text = @"25";
        cell.dayLabel.textColor = [self textColorForIndex:indexPath.row];
		cell.mainLabel.text =[self.backgroundSettings objectAtIndex:indexPath.row];
		return cell;
		
	}else{
		static NSString *CellIdentifier = @"Cell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 5.0, 250.0, 35.0)];
			mainLabel.opaque = YES;
			mainLabel.tag = 1; 
			mainLabel.font = [UIFont boldSystemFontOfSize:18]; 
			mainLabel.textAlignment = NSTextAlignmentCenter;
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			[cell.contentView addSubview:mainLabel]; 
		} else {
			mainLabel = (UILabel *)[cell.contentView viewWithTag:1]; 
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
		mainLabel.backgroundColor = self.backgroundColor;
		mainLabel.textColor = self.textColor;
		mainLabel.text = @"Calendar Background";
		return cell;
	}

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor =[UIColor whiteColor];
    cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.row < 7) {
		ColorsViewController *colorsViewController = [[ColorsViewController alloc] initWithNibName:@"ColorsView" bundle:nil];
		colorsViewController.title = [self.backgroundSettings objectAtIndex:indexPath.row];
		colorsViewController.currentDaySelected = indexPath.row;
		[[self navigationController] pushViewController:colorsViewController animated:YES];

	} else {
		CalendarBackgroundViewController *calendarBackgroundViewController = [[CalendarBackgroundViewController alloc] initWithNibName:@"CalendarBackgroundViewController" bundle:nil];
		calendarBackgroundViewController.title = @"Select Colors";
		[[self navigationController] pushViewController:calendarBackgroundViewController animated:YES];

	}
	

}




@end

