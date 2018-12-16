//
//  RCSettings.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "RCSettingsViewController.h"
#import "AboutViewController.h"
#import "WorkScheduleViewController.h"
#import "FeaturesViewController.h"
#import "ShiftWorkViewController.h"


@implementation RCSettingsViewController

@synthesize settings, settings0, settingsDetails, retirementDate, endworkhours, beginworkhours, dateFormatter, dateFormatter2, returntosettings, tableview; 




- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef LITE_VERSION

	self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Days Off (Personal/Vacation)", @"Select Picture", @"Select Colors",nil];
    
//    self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Shift Work", @"Holidays", @"Days Off (Personal/Vacation)", @"Select Picture", @"Select Colors",nil];

#else

//	self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Days Off (Personal/Vacation)",@"Icon Badge Options", @"Select Picture", @"Select Colors",nil];
    
    self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Shift Work", @"Holidays", @"Days Off (Personal/Vacation)",@"Icon Badge Options", @"Select Picture", @"Select Colors",nil];

#endif

 	self.settings0 = [NSArray arrayWithObjects:@"Welcome",@"FAQs / Features",@"Contact Me", @"Rate this App",nil];
 	self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	self.dateFormatter2 = [[[NSDateFormatter alloc] init] autorelease];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[self.dateFormatter2 setDateStyle:NSDateFormatterNoStyle];
	[self.dateFormatter2 setTimeStyle:NSDateFormatterShortStyle];			
	
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
								
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];					
							
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.retirementDate = [self.appDelegate.settings objectForKey:@"RetirementDate"];
	self.beginworkhours = [self.appDelegate.settings objectForKey:@"BeginWorkhours"];
	self.endworkhours = [self.appDelegate.settings objectForKey:@"EndWorkhours"];
	[tableview reloadData];
	
	[self.appDelegate saveAllData];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	
	if (section == 0) {
		return [self.settings0 count];
	} 
	 return [self.settings count];
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.opaque = NO;
		cell.textLabel.textColor = [UIColor blackColor];
		cell.textLabel.highlightedTextColor = [UIColor whiteColor];
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
		
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.opaque = NO;
		cell.detailTextLabel.textColor = [UIColor blueColor];
		cell.detailTextLabel.textAlignment = UITextAlignmentRight;
		cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

//	self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Annual Days Off",@"Display Option", @"Select Picture", @"Select Colors",nil];
// 	self.settings0 = [NSArray arrayWithObjects:@"About",@"FAQs / Features",@"Contact Me", @"Rate this App",nil];


    
	if (indexPath.section == 0) {
		cell.textLabel.text = [self.settings0 objectAtIndex:indexPath.row];
		if (indexPath.row == 2) {
			cell.detailTextLabel.text = @"Let me know if you have any questions";
		} else if (indexPath.row == 3) {
			cell.detailTextLabel.text = @"I hope you enjoy it!";
		} else {
			cell.detailTextLabel.text = nil;
		}
    } else {
    
#ifdef LITE_VERSION
    
		cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
        cell.imageView.image = nil;
        //}
		if (indexPath.row == 0)	{
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@",[self.dateFormatter stringFromDate:self.retirementDate]];
            
		} else if (indexPath.row == 1)	{
			NSArray *workdays = self.appDelegate.workdays;
			NSString *workdaystring = @"     ";
			int i = 0;
			for (id workday in workdays) {
				if ([workday isEqualToString:@"YES"]) { 
					if (i == 0) {workdaystring = [workdaystring stringByAppendingString:@"Su, "];}
					if (i == 1) {workdaystring = [workdaystring stringByAppendingString:@"Mo, "];}
					if (i == 2) {workdaystring = [workdaystring stringByAppendingString:@"Tu, "];}
					if (i == 3) {workdaystring = [workdaystring stringByAppendingString:@"We, "];}
					if (i == 4) {workdaystring = [workdaystring stringByAppendingString:@"Th, "];}
					if (i == 5) {workdaystring = [workdaystring stringByAppendingString:@"Fr, "];}
					if (i == 6) {workdaystring = [workdaystring stringByAppendingString:@"Sa, "];}
				}
				i++;
			}	
			int workdaystringlength = [workdaystring length];
			if (workdaystringlength > 0){
				workdaystring = [workdaystring substringToIndex:workdaystringlength-2];
				cell.detailTextLabel.text = workdaystring;
            }
        
    
		}	else if (indexPath.row == 2)	{
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];
            
//        } else if (indexPath.row == 3) {
//            NSArray *shiftweeks = self.appDelegate.shiftweeks;
//            NSString *shiftweekstring = @"     ";
//            int i = 0;
//            for (id shiftweek in shiftweeks) {
//                if ([shiftweek isEqualToString:@"YES"]) {
//                    if (i == 0) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 1, "];}
//                    if (i == 1) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 2, "];}
//                    if (i == 2) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 3, "];}
//                    if (i == 3) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 4, "];}
//				}
//				i++;
//        
//        
//			int shiftweekstringlength = [shiftweekstring length];
//			if (shiftweekstringlength > 0){
//				shiftweekstring = [shiftweekstring substringToIndex:shiftweekstringlength-2];
//				cell.detailTextLabel.text = shiftweekstring;
//            }
        //}
		} else if (indexPath.row == 3)	{
			NSArray *holidayList = self.appDelegate.holidaylist;
			int numberOfHolidaysSelected = 0;
			for (id holiday in holidayList) {
				if ([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]) {
					numberOfHolidaysSelected++;
				}
			}
        
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %i holidays selected",numberOfHolidaysSelected];
        
		} else if (indexPath.row == 4)	{
			NSString *thisYear = @"0";
			NSString *allYears = @"0";
			NSString *retireYear = @"0";
			
			if ([appDelegate.settings objectForKey:@"ThisYearDaysOff"]) {thisYear = [appDelegate.settings objectForKey:@"ThisYearDaysOff"];}
			if ([appDelegate.settings objectForKey:@"AllYearsDaysOff"]) {allYears = [appDelegate.settings objectForKey:@"AllYearsDaysOff"];}	
			if ([appDelegate.settings objectForKey:@"RetirementYearDaysOff"]) {retireYear = [appDelegate.settings objectForKey:@"RetirementYearDaysOff"];}
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Current - %@,  Between - %@,  Retire - %@",thisYear,allYears,retireYear];
		
		}	else if (indexPath.row == 5)	{

			cell.detailTextLabel.text = nil;
        }	else if (indexPath.row == 6)	{
			cell.detailTextLabel.text = nil;
		} else {
			cell.detailTextLabel.text = nil;
		}
    

#else


		cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
        cell.imageView.image = nil;
		if (indexPath.row == 0)	{
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@",[self.dateFormatter stringFromDate:self.retirementDate]];
		} else if (indexPath.row == 1)	{
			NSArray *workdays = self.appDelegate.workdays;
			NSString *workdaystring = @"     ";
			int i = 0;
			for (id workday in workdays) {
				if ([workday isEqualToString:@"YES"]) { 
					if (i == 0) {workdaystring = [workdaystring stringByAppendingString:@"Su, "];}
					if (i == 1) {workdaystring = [workdaystring stringByAppendingString:@"Mo, "];}
					if (i == 2) {workdaystring = [workdaystring stringByAppendingString:@"Tu, "];}
					if (i == 3) {workdaystring = [workdaystring stringByAppendingString:@"We, "];}
					if (i == 4) {workdaystring = [workdaystring stringByAppendingString:@"Th, "];}
					if (i == 5) {workdaystring = [workdaystring stringByAppendingString:@"Fr, "];}
					if (i == 6) {workdaystring = [workdaystring stringByAppendingString:@"Sa, "];}
				}
				i++;
			}	
			int workdaystringlength = [workdaystring length];
			if (workdaystringlength > 0){
				workdaystring = [workdaystring substringToIndex:workdaystringlength-2];
				cell.detailTextLabel.text = workdaystring;
        }
		}	else if (indexPath.row == 2)	{
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter2 stringFromDate:self.beginworkhours],[self.dateFormatter2 stringFromDate:self.endworkhours]];

//        }  else if (indexPath.row == 3) {
//                NSArray *shiftweeks = self.appDelegate.shiftweeks;
//                NSString *shiftweekstring = @"     ";
//                int i = 0;
//                for (id shiftweek in shiftweeks) {
//                    if ([shiftweek isEqualToString:@"YES"]) {
//                        if (i == 0) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 1, "];}
//                        if (i == 1) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 2, "];}
//                        if (i == 2) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 3, "];}
//                        if (i == 3) {shiftweekstring = [shiftweekstring stringByAppendingString:@"Week 4, "];}
//  
//                    }
//                    i++;
//                    
//                }
//        int shiftweekstringlength = [shiftweekstring length];
//        if (shiftweekstringlength > 0){
//            shiftweekstring = [shiftweekstring substringToIndex:shiftweekstringlength-2];
//            cell.detailTextLabel.text = shiftweekstring;
//        }
            } else if (indexPath.row == 4)	{
			NSArray *holidayList = self.appDelegate.holidaylist;
			int numberOfHolidaysSelected = 0;
			for (id holiday in holidayList) {
				if ([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]) {
					numberOfHolidaysSelected++;
				}
			}
			cell.detailTextLabel.text = [NSString stringWithFormat:@"     %i holidays selected",numberOfHolidaysSelected]; 
		} else if (indexPath.row == 5)	{
			NSString *thisYear = @"0";
			NSString *allYears = @"0";
			NSString *retireYear = @"0";
			
			if ([appDelegate.settings objectForKey:@"ThisYearDaysOff"]) {thisYear = [appDelegate.settings objectForKey:@"ThisYearDaysOff"];}
			if ([appDelegate.settings objectForKey:@"AllYearsDaysOff"]) {allYears = [appDelegate.settings objectForKey:@"AllYearsDaysOff"];}	
			if ([appDelegate.settings objectForKey:@"RetirementYearDaysOff"]) {retireYear = [appDelegate.settings objectForKey:@"RetirementYearDaysOff"];}
			
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Current - %@,  Between - %@,  Retire - %@",thisYear,allYears,retireYear];
		
		}	else if (indexPath.row == 6)	{
			NSString *option = [self.appDelegate.settings objectForKey:@"DisplayOption"];
			if ([option isEqualToString:@"Work"]) {cell.detailTextLabel.text = @"Work Days Remaining";}
			if ([option isEqualToString:@"Calendar"]) {cell.detailTextLabel.text = @"Calendar Days Remaining";}
            if ([option isEqualToString:@"None"]) {cell.detailTextLabel.text = @"Badge Option Disabled";}
            cell.imageView.image = [UIImage imageNamed:@"badgeDemo3.png"];

		}	else if (indexPath.row == 7)	{

			cell.detailTextLabel.text = nil;
        }	else if (indexPath.row == 8)	{
			cell.detailTextLabel.text = nil;
		} else {
			cell.detailTextLabel.text = nil;
		}
    
#endif
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//	self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Annual Days Off",@"Display Option", @"Select Picture", @"Select Colors",nil];
 //	self.settings0 = [NSArray arrayWithObjects:@"About",@"FAQs / Features",@"Contact Me", @"Rate this App",nil];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
			aboutViewController.title = @"Welcome";
			[[self navigationController] pushViewController:aboutViewController animated:YES];
			[aboutViewController release];		

		} else if (indexPath.row == 1) {
			FeaturesViewController *featuresViewController = [[FeaturesViewController alloc] initWithNibName:@"FeaturesViewController" bundle:nil];
			featuresViewController.title = @"FAQs and Features";
			[[self navigationController] pushViewController:featuresViewController animated:YES];
			[featuresViewController release];

		} else if (indexPath.row == 2) {
			HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
			helpViewController.title = @"Contact Me";
			[[self navigationController] pushViewController:helpViewController animated:YES];
			[helpViewController release];        

		} else if (indexPath.row == 3) {

#ifdef LITE_VERSION
            NSString *iTunesLink = @"https://itunes.apple.com/us/app/retirement-countdown-ad-free/id400298323?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
#else
            
            NSString *iTunesLink = @"https://itunes.apple.com/us/app/retirement-countdown-ad-free/id424032584?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
#endif

        }
	} else {

#ifdef LITE_VERSION
		if(indexPath.row==0) {
			RetirementDateViewController *retirementdateViewController = [[RetirementDateViewController alloc] initWithNibName:@"RetirementDate" bundle:nil];
			retirementdateViewController.retirementDate = self.retirementDate;
			[[self navigationController] pushViewController:retirementdateViewController animated:YES];
			[retirementdateViewController release];
            
		}else if(indexPath.row==1) {
            WorkdaysViewController *workdaysViewController = [[WorkdaysViewController alloc] initWithNibName:@"Workdays" bundle:nil];
            workdaysViewController.title = @"Work Days";
            [[self navigationController] pushViewController:workdaysViewController animated:YES];
            [workdaysViewController release];
//			WorkScheduleViewController *workScheduleViewController = [[WorkScheduleViewController alloc] initWithNibName:@"WorkScheduleViewController" bundle:nil];
//			workScheduleViewController.title = @"Work Schedule";
//			[[self navigationController] pushViewController:workScheduleViewController animated:YES];
//			[workScheduleViewController release];
            
		}else if(indexPath.row==2) {
			WorkhoursViewController *workhoursViewController = [[WorkhoursViewController alloc] initWithNibName:@"Workhours" bundle:nil];
			workhoursViewController.title = @"Work Hours";
			[[self navigationController] pushViewController:workhoursViewController animated:YES];
			[workhoursViewController release];
            
		//} else if(indexPath.row ==3) {
          //  ShiftWorkViewController *shiftWorkViewController = [[ShiftWorkViewController alloc] initWithNibName:@"ShiftWorkViewController" bundle:nil];
          //  shiftWorkViewController.title = @"Shift Work";
           // [[self navigationController] pushViewController:shiftWorkViewController animated:YES];
        
        }else if(indexPath.row==3) {
			HolidaysViewController *holidaysViewController = [[HolidaysViewController alloc] initWithNibName:@"Holidays" bundle:nil];
			holidaysViewController.title = @"Select Holiday";
			[[self navigationController] pushViewController:holidaysViewController animated:YES];
			[holidaysViewController release];
        
		}else if(indexPath.row==4) {
			StatutoryDaysOffViewController *statutoryDaysOffViewController = [[StatutoryDaysOffViewController alloc] initWithNibName:@"StatutoryDaysOffViewController" bundle:nil];
			statutoryDaysOffViewController.title = @"Days Off";
			[[self navigationController] pushViewController:statutoryDaysOffViewController animated:YES];
			[statutoryDaysOffViewController release];
            
		}else if(indexPath.row==5) {
			ImagePickerViewController *imagePickerViewController = [[ImagePickerViewController alloc] initWithNibName:@"ImagePickerViewController" bundle:nil];
			imagePickerViewController.title = @"Select Picture";
			[[self navigationController] pushViewController:imagePickerViewController animated:YES];
			[imagePickerViewController release];
            
		}else if(indexPath.row==6) {
			DaysViewController *daysViewController = [[DaysViewController alloc] initWithNibName:@"DaysViewController" bundle:nil];
			daysViewController.title = @"Select Colors";
			[[self navigationController] pushViewController:daysViewController animated:YES];
			[daysViewController release];
		}
    }
#else

		if(indexPath.row==0) {
			RetirementDateViewController *retirementdateViewController = [[RetirementDateViewController alloc] initWithNibName:@"RetirementDate" bundle:nil];
			retirementdateViewController.retirementDate = self.retirementDate;
			[[self navigationController] pushViewController:retirementdateViewController animated:YES];
			[retirementdateViewController release];
            
		}else if(indexPath.row==1) {
            WorkdaysViewController *workdaysViewController = [[WorkdaysViewController alloc] initWithNibName:@"Workdays" bundle:nil];
            workdaysViewController.title = @"Work Days";
            [[self navigationController] pushViewController:workdaysViewController animated:YES];
            [workdaysViewController release];
//			WorkScheduleViewController *workScheduleViewController = [[WorkScheduleViewController alloc] initWithNibName:@"WorkScheduleViewController" bundle:nil];
//			workScheduleViewController.title = @"Work Schedule";
//			[[self navigationController] pushViewController:workScheduleViewController animated:YES];
//			[workScheduleViewController release];
            
		}else if(indexPath.row==2) {
			WorkhoursViewController *workhoursViewController = [[WorkhoursViewController alloc] initWithNibName:@"Workhours" bundle:nil];
			workhoursViewController.title = @"Work Hours";
			[[self navigationController] pushViewController:workhoursViewController animated:YES];
			[workhoursViewController release];
            
		} else if(indexPath.row ==3) {
            ShiftWorkViewController *shiftWorkViewController = [[ShiftWorkViewController alloc] initWithNibName:@"ShiftWorkViewController" bundle:nil];
            shiftWorkViewController.title = @"Shift Work";
            [[self navigationController] pushViewController:shiftWorkViewController animated:YES];
    
        }else if(indexPath.row==4) {
			HolidaysViewController *holidaysViewController = [[HolidaysViewController alloc] initWithNibName:@"Holidays" bundle:nil];
			holidaysViewController.title = @"Select Holiday";
			[[self navigationController] pushViewController:holidaysViewController animated:YES];
			[holidaysViewController release];
            
		}else if(indexPath.row==5) {
			StatutoryDaysOffViewController *statutoryDaysOffViewController = [[StatutoryDaysOffViewController alloc] initWithNibName:@"StatutoryDaysOffViewController" bundle:nil];
			statutoryDaysOffViewController.title = @"Days Off";
			[[self navigationController] pushViewController:statutoryDaysOffViewController animated:YES];
			[statutoryDaysOffViewController release];
            
		}else if(indexPath.row==6) {
			DisplayOptionsViewController *displayoptionsViewController = [[DisplayOptionsViewController alloc] initWithNibName:@"DisplayOptions" bundle:nil];
			displayoptionsViewController.title = @"Badge Options";
			[[self navigationController] pushViewController:displayoptionsViewController animated:YES];
			[displayoptionsViewController release];
            
		}else if(indexPath.row==7) {
			ImagePickerViewController *imagePickerViewController = [[ImagePickerViewController alloc] initWithNibName:@"ImagePickerViewController" bundle:nil];
			imagePickerViewController.title = @"Select Picture";
			[[self navigationController] pushViewController:imagePickerViewController animated:YES];
			[imagePickerViewController release];
            
		}else if(indexPath.row==8) {
			DaysViewController *daysViewController = [[DaysViewController alloc] initWithNibName:@"DaysViewController" bundle:nil];
			daysViewController.title = @"Select Colors";
			[[self navigationController] pushViewController:daysViewController animated:YES];
			[daysViewController release];
		}
}
#endif
	}



- (void)dealloc {
	[settings release];
	[settings0 release];
	[settingsDetails release];
	[retirementDate release];
	[beginworkhours release];
	[endworkhours release];
	[dateFormatter release];
	[dateFormatter2 release];
	[tableview release];
    [super dealloc];
}


@end

