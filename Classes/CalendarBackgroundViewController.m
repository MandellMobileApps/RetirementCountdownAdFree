//
//  CalendarBackgroundViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "CalendarBackgroundViewController.h"


@implementation CalendarBackgroundViewController

@synthesize predefinedBackgroundColorName;
@synthesize predefinedTextColorName;
@synthesize predefinedBackgroundColorIndex;
@synthesize predefinedTextColorIndex;
@synthesize currentObject;
@synthesize upperLine;
@synthesize lowerLine;
@synthesize backgroundColorTable;


- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	self.upperLine.font = [UIFont boldSystemFontOfSize:24];
	self.lowerLine.font = [UIFont boldSystemFontOfSize:24];

}



- (void)viewWillAppear:(BOOL)animated {
	self.predefinedBackgroundColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Background"] intValue];
	self.predefinedTextColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Text"] intValue];
	self.predefinedBackgroundColorName = [self.appDelegate.backgroundColors objectAtIndex:7];
	self.predefinedTextColorName = [self.appDelegate.textColors objectAtIndex:7];
	
	self.upperLine.text = self.predefinedTextColorName;
	self.lowerLine.text =  [NSString stringWithFormat:@"on %@",self.predefinedBackgroundColorName];
	self.upperLine.textColor = [ColorsClass performSelector:NSSelectorFromString(self.predefinedTextColorName)];
	self.lowerLine.textColor =  self.upperLine.textColor; 
	self.upperLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(self.predefinedBackgroundColorName)];
	self.lowerLine.backgroundColor = self.upperLine.backgroundColor; 
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


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == 0) { 
		cell.textLabel.text = @" Text Color";
	} else {
		cell.textLabel.text = @" Background Color";
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if(indexPath.row==0) {
		BackgroundTextColorViewController *backgroundTextColorViewController = [[BackgroundTextColorViewController alloc] initWithNibName:@"BackgroundTextColorViewController" bundle:nil];
		backgroundTextColorViewController.title = @"Select Text Color";
		[[self navigationController] pushViewController:backgroundTextColorViewController animated:YES];
		[backgroundTextColorViewController release];
	}
	if(indexPath.row==1) {
		BackgroundColorViewController *backgroundColorViewController = [[BackgroundColorViewController alloc] initWithNibName:@"BackgroundColorViewController" bundle:nil];
		backgroundColorViewController.title = @"Select Background Color";
		[[self navigationController] pushViewController:backgroundColorViewController animated:YES];
		[backgroundColorViewController release];
	}
}


- (void)dealloc {
	[predefinedBackgroundColorName release];
	[predefinedTextColorName release];
	[currentObject release];
	[upperLine release];
	[lowerLine release];
	[backgroundColorTable release];
	[super dealloc];
}


@end

