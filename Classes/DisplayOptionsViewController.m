//
//  DisplayOptionsViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/31/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "DisplayOptionsViewController.h"


@implementation DisplayOptionsViewController

@synthesize displayoptions,option,badgedisplayoptions;


- (void)viewDidLoad {
    [super viewDidLoad];
	self.displayoptions = [NSArray arrayWithObjects:@"Show Working Days Remaining", @"Show Calendar Days Remaining",@"Do Not Show Badge",nil];
	self.option = [self.appDelegate.settings objectForKey:@"DisplayOption"];
	
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

}



- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.appDelegate.settings setObject:self.option forKey:@"DisplayOption"];
	
	
	
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
    return [displayoptions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.textLabel.text = [displayoptions objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) { 
        if ([self.option isEqualToString:@"Work"]) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    }
    if (indexPath.row == 1) { 
        if ([self.option isEqualToString:@"Calendar"]) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}	
    }
    if (indexPath.row == 2) {
        if ([self.option isEqualToString:@"None"]) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if (indexPath.row == 0) {
			self.option = @"Work";
    }
	else if (indexPath.row == 1) {
			self.option = @"Calendar";
	}
	else if (indexPath.row == 2) {
			self.option = @"None";
	}
    [tableView reloadData];
	self.appDelegate.colorsChanged = YES;	
}



- (void)dealloc {
	[displayoptions release];
	[option release];
	[super dealloc];
}


@end

