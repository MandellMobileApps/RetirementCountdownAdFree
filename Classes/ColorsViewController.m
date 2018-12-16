//
//  ColorsViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "ColorsViewController.h"



@implementation ColorsViewController

@synthesize currentBackground, tableViewButton, tableViewLabel,  dayButton, dayLabel, backgroundColors, textColors;


- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];
	
	NSMutableArray *backgroundColorstemp = [[NSMutableArray alloc] initWithArray:self.appDelegate.backgroundColors];
	self.backgroundColors = backgroundColorstemp;
	[backgroundColorstemp release];
	
	NSMutableArray *textColorstemp = [[NSMutableArray alloc] initWithArray:self.appDelegate.textColors];
	self.textColors = textColorstemp;
	[textColorstemp release];	
	
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	
	self.dayLabel.text = @"25";
	self.dayLabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:self.currentBackground])];
	NSString *buttonPictureName = [self.appDelegate.backgroundColors objectAtIndex:self.currentBackground];
	UIImage *buttonBackground = [self.appDelegate imageFromCache:buttonPictureName];
	[self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
	[self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];

}


- (void)viewWillDisappear:(BOOL)animated {
	self.appDelegate.backgroundColors = self.backgroundColors;
	self.appDelegate.textColors = self.textColors;
	[super viewWillDisappear:animated];
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
	if ([tableView tag] == 100) {
    return [ColorsClass getCountForDayColorNames];
	} else {
	return [ColorsClass getCountForTextColorNames];
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if ([tableView tag] == 100) {
		static NSString *CellIdentifier = @"CustomCellForColors";		
		CustomCellForColors *cell = (CustomCellForColors*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *cellobjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCellForColors" owner:nil options:nil];
			for (id currentObject in cellobjects){
				if([currentObject isKindOfClass:[UITableViewCell class]]){
					cell = (CustomCellForColors *) currentObject;
				}
			}
		}
		NSString *buttonPictureName = [ColorsClass getDayColorNameFor:indexPath.row];
		UIImage *buttonBackground = [self.appDelegate imageFromCache:buttonPictureName];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
		
		cell.accessoryType = UITableViewCellAccessoryNone;
		if ([[self.backgroundColors objectAtIndex:self.currentBackground] isEqualToString:[ColorsClass getDayColorNameFor:indexPath.row]]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}

    return cell;
	
	} else {
		static NSString *CellIdentifier = @"Cell2";
		UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell2 == nil) {
			cell2 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		
		NSString *tempLabelText = [[NSString alloc] initWithString:(NSString*)[ColorsClass getTextColorNameFor:indexPath.row]];
		cell2.textLabel.text = tempLabelText;
		
		if ([tempLabelText isEqualToString:@"white"]) {
			cell2.textLabel.textColor =  [UIColor blackColor];
		} else {
			cell2.textLabel.textColor = [ColorsClass performSelector:NSSelectorFromString(tempLabelText)];
		}
		cell2.accessoryType = UITableViewCellAccessoryNone;
		if ([[self.textColors objectAtIndex:currentBackground] isEqualToString:tempLabelText]) {
			cell2.accessoryType = UITableViewCellAccessoryCheckmark;
		}	
		[tempLabelText release];
		return cell2;
	}	
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if ([tableView tag] == 100) {
		CustomCellForColors *cell = (CustomCellForColors*)[tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone) { 
			[self.backgroundColors replaceObjectAtIndex:self.currentBackground withObject:[ColorsClass getDayColorNameFor:indexPath.row]];
			NSString *buttonPictureName = [self.backgroundColors objectAtIndex:self.currentBackground];
			UIImage *buttonBackground = [self.appDelegate imageFromCache:buttonPictureName];
			[self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
			[self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
			self.appDelegate.colorsChanged = YES;
		}
	} else {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone) { 
			NSString *tempTextColorName = [ColorsClass getTextColorNameFor:indexPath.row];
			[self.textColors replaceObjectAtIndex:self.currentBackground withObject:tempTextColorName];
			self.dayLabel.textColor = [ColorsClass performSelector:NSSelectorFromString(tempTextColorName)];
			self.appDelegate.colorsChanged = YES;
		}
	}
	[tableView reloadData];
}


- (void)dealloc {
	[backgroundColors release];
	[textColors release];
	[tableViewButton release];
	[tableViewLabel release];
	[dayButton release];
	[dayLabel release];
	[super dealloc];
}


@end

