//
//  DaysViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "DaysViewController.h"



@implementation DaysViewController

@synthesize backgrounds,  tableViewForReload, backgroundImageNames, textColorNames;

- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	self.backgrounds = [NSArray arrayWithObjects:@"Today", @"Retirement Day", @"Workdays", @"Non-Workdays", @"Holidays", @"Manual Workdays", @"Manual Non-Workdays",  @"Background", nil];


}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.backgroundImageNames =  self.appDelegate.backgroundColors;
	self.textColorNames = self.appDelegate.textColors;
	[self.tableViewForReload reloadData];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return [self.backgrounds count];
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
		NSString *buttonPictureName = [self.backgroundImageNames objectAtIndex:indexPath.row];
		UIImage *buttonBackground = [self.appDelegate imageFromCache:buttonPictureName];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
		cell.dayLabel.text = @"25";
		cell.dayLabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.textColorNames objectAtIndex:indexPath.row])];
		cell.mainLabel.text =[self.backgrounds objectAtIndex:indexPath.row];
		return cell;
		
	}else{
		static NSString *CellIdentifier = @"Cell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			mainLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25.0, 5.0, 250.0, 35.0)] autorelease];
			mainLabel.opaque = YES;
			mainLabel.tag = 1; 
			mainLabel.font = [UIFont boldSystemFontOfSize:18]; 
			mainLabel.textAlignment = UITextAlignmentCenter; 
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell.contentView addSubview:mainLabel]; 
		} else {
			mainLabel = (UILabel *)[cell.contentView viewWithTag:1]; 
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		UIColor *tempBackgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

		mainLabel.backgroundColor = tempBackgroundColor;
		mainLabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.textColorNames objectAtIndex:indexPath.row])];
		mainLabel.text = @"Calendar Background";
		return cell;
	}

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.row < 7) {
		ColorsViewController *colorsViewController = [[ColorsViewController alloc] initWithNibName:@"ColorsView" bundle:nil];
		colorsViewController.title = [self.backgrounds objectAtIndex:indexPath.row];
		colorsViewController.currentBackground = indexPath.row;
		[[self navigationController] pushViewController:colorsViewController animated:YES];
		[colorsViewController release];
	} else {
		CalendarBackgroundViewController *calendarBackgroundViewController = [[CalendarBackgroundViewController alloc] initWithNibName:@"CalendarBackgroundViewController" bundle:nil];
		calendarBackgroundViewController.title = @"Select Colors";
		[[self navigationController] pushViewController:calendarBackgroundViewController animated:YES];
		[calendarBackgroundViewController release];
	}
	

}


- (void)dealloc {
	[backgrounds release];
	[tableViewForReload release];
	[backgroundImageNames release];
	[textColorNames release];
    [super dealloc];
}


@end

