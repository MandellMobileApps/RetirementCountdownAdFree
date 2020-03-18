//
//  CalendarBackgroundViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "CalendarBackgroundViewController.h"


@implementation CalendarBackgroundViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    

	self.upperLine.font = [UIFont boldSystemFontOfSize:24];
	self.lowerLine.font = [UIFont boldSystemFontOfSize:24];
    


    
}

-(void)refreshColors
{
    
    NSString* sqlText = [NSString stringWithFormat:@"SELECT * FROM Colors WHERE id=%li",self.appDelegate.settingsNew.textColorIndex];
    NSDictionary* textColorDict = [SQLiteAccess selectOneRowWithSQL:sqlText];
    NSString* textColorName = [textColorDict objectForKey:@"name"];
    

    NSString* sqlbackground = [NSString stringWithFormat:@"SELECT * FROM Colors WHERE id=%li",self.appDelegate.settingsNew.backgroundColorIndex];
    NSDictionary* backgroundColorDict = [SQLiteAccess selectOneRowWithSQL:sqlbackground];
    NSString* backgroundColorName = [backgroundColorDict objectForKey:@"name"];
    
    
    self.upperLine.text = textColorName;
    self.lowerLine.text =  [NSString stringWithFormat:@"on %@",backgroundColorName];
    
    UIColor* textColor = [GlobalMethods colorForIndex:[[textColorDict objectForKey:@"id"]integerValue]];
    self.upperLine.textColor = textColor;
    self.lowerLine.textColor = textColor;
                                
    UIColor* backgroundColor = [GlobalMethods colorForIndex:[[backgroundColorDict objectForKey:@"id"]integerValue]];
    self.upperLine.backgroundColor = backgroundColor;
    self.lowerLine.backgroundColor = backgroundColor;
    
    self.backgroundColorTable.backgroundColor = backgroundColor;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
        [self refreshColors];
    

}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [self refreshColors];
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if(indexPath.row==0) {
		BackgroundTextColorViewController *backgroundTextColorViewController = [[BackgroundTextColorViewController alloc] initWithNibName:@"BackgroundTextColorViewController" bundle:nil];
		backgroundTextColorViewController.title = @"Select Text Color";
		[[self navigationController] pushViewController:backgroundTextColorViewController animated:YES];

	}
	if(indexPath.row==1) {
		BackgroundColorViewController *backgroundColorViewController = [[BackgroundColorViewController alloc] initWithNibName:@"BackgroundColorViewController" bundle:nil];
		backgroundColorViewController.title = @"Select Background Color";
		[[self navigationController] pushViewController:backgroundColorViewController animated:YES];

	}
}





@end

