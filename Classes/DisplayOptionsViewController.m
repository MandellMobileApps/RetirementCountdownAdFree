//
//  DisplayOptionsViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/31/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "DisplayOptionsViewController.h"


@implementation DisplayOptionsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.displayoptions = [NSArray arrayWithObjects:@"Show Working Days Remaining", @"Show Calendar Days Remaining",@"Do Not Show Badge",nil];
	self.option = self.appDelegate.settingsNew.displayOption;

}



- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
}




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.backgroundColor = self.backgroundColor;
    return [self.displayoptions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [self.displayoptions objectAtIndex:indexPath.row];
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
    cell.backgroundColor = self.backgroundColor;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if (indexPath.row == 0) {
			self.option = @"Work";
        [self.appDelegate updateSettingsString:@"Work" forProperty:@"displayOption"];
    }
	else if (indexPath.row == 1) {
			self.option = @"Calendar";
        [self.appDelegate updateSettingsString:@"Calendar" forProperty:@"displayOption"];
	}
	else if (indexPath.row == 2) {
			self.option = @"None";
        [self.appDelegate updateSettingsString:@"None" forProperty:@"displayOption"];
	}
    [tableView reloadData];
	
}





@end

