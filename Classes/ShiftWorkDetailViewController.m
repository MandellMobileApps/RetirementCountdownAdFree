//
//  ShiftWorkDetailViewController.m
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 9/11/14.
//  Copyright (c) 2014 MandellMobileApps. All rights reserved.
//

#import "ShiftWorkDetailViewController.h"

@interface ShiftWorkDetailViewController ()

@end

@implementation ShiftWorkDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    }



//
//self.settings = [NSArray arrayWithObjects:@"Sunday", @"Work Hours", @"Monday", @"Work Hours", @"Tuesday", @"Work Hours", @"Wednesday", @"Work Hours", @"Thursday", @"Work Hours", @"Friday", @"Work Hours", @"Saturday", @"Work Hours", nil];



//
//self.allworkdays = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
//	self.selectedworkdays = self.appDelegate.workdays;
//	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
//    
//    self.dataArray = [NSArray arrayWithObjects:@"Begin", @"End",nil];
//	self.currentSelection = -1;
//	self.dateFormatter = [[NSDateFormatter alloc] init];
//	[self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
//	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//	self.beginWorkhours = [self.appDelegate.settingsNew.BeginWorkhours"];
//	self.endWorkhours = [self.appDelegate.settingsNew.EndWorkhours"];
//	self.detaildataArray = [NSArray arrayWithObjects:self.beginWorkhours,self.endWorkhours,nil];
//	
//	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
//	self.pickerViewContainer.frame = CGRectMake(0,self.view.bounds.size.height, 320, 250);
//
//}

//


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return 14;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [self.allworkdays objectAtIndex:indexPath.row];
	if ([[self.selectedworkdays objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[self.selectedworkdays objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
		[self.selectedworkdays replaceObjectAtIndex:indexPath.row withObject:@"NO"];
	} else {
		[self.selectedworkdays replaceObjectAtIndex:indexPath.row withObject:@"YES"];
	}
}


//cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
//cell.imageView.image = nil;
//if (indexPath.row == 0)	{
//    NSArray *workdays = self.appDelegate.workdays;
//    NSString *workdaystring = @"     ";
//    NSInteger i = 0;
//    for (id workday in workdays) {
//        if ([workday isEqualToString:@"YES"]) {
//            if (i == 0) {workdaystring = [workdaystring stringByAppendingString:@"Su, "];}
//            if (i == 1) {workdaystring = [workdaystring stringByAppendingString:@"Mo, "];}
//            if (i == 2) {workdaystring = [workdaystring stringByAppendingString:@"Tu, "];}
//            if (i == 3) {workdaystring = [workdaystring stringByAppendingString:@"We, "];}
//            if (i == 4) {workdaystring = [workdaystring stringByAppendingString:@"Th, "];}
//            if (i == 5) {workdaystring = [workdaystring stringByAppendingString:@"Fr, "];}
//            if (i == 6) {workdaystring = [workdaystring stringByAppendingString:@"Sa, "];}
//        }
//        i++;
//    }
//    NSInteger workdaystringlength = [workdaystring length];
//    if (workdaystringlength > 0){
//        workdaystring = [workdaystring substringToIndex:workdaystringlength-2];
//        cell.detailTextLabel.text = workdaystring;
//    }
//
//else if (indexPath.row == 1)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexPath.row == 2) {
//    
//}	else if (indexPath.row == 3)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexPath.row == 4) {
//    
//}	else if (indexPath.row == 5)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexPath.row == 6) {
//    
//}	else if (indexPath.row == 7)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexpath.row == 8) {
//    
//}	else if (indexPath.row == 9)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexPath.row == 10) {
//
//}	else if (indexPath.row == 11)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//} else if (indexPath.row == 12) {
//
//}	else if (indexPath.row == 13)	{
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
//    
//}
//}

@end

