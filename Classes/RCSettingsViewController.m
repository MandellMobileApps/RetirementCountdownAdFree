//
//  RCSettings.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/21/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "RCSettingsViewController.h"
#import "AboutViewController.h"

#import "FeaturesViewController.h"
#import "ShiftWorkViewController.h"
#import "PurchaseViewController.h"
#import "WebViewController.h"


@implementation RCSettingsViewController




- (void)viewDidLoad {
    [super viewDidLoad];


//	self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Days Off (Personal/Vacation)",@"Icon Badge Options", @"Select Picture", @"Select Colors",nil];
    
    self.settings = [NSArray arrayWithObjects:@"Retirement Date", @"Work Days",@"Work Hours", @"Holidays", @"Days Off (Personal/Vacation)",@"Icon Badge Options", @"Select Picture", @"Select Colors",nil];



 	self.settings0 = [NSArray arrayWithObjects:@"About",@"FAQs",@"Support",@"Rate this App",nil];
			
					
}
-(void)popThisViewController
{
   // [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

     [self.tableview reloadData];
	
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self capturescreen];
}
-(NSData*)capturescreen {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screencapture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageinpng = UIImagePNGRepresentation(screencapture);
    NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"SettingsScreenCapture"];
    [imageinpng writeToFile:pathName atomically:YES];
    NSData *returnData = [[NSData alloc] initWithData:imageinpng];
    return returnData;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];
	
	if (section == 0) {
		return [self.settings0 count];
	} 
	 return [self.settings count];
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		
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

		cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
        cell.imageView.image = nil;
		if (indexPath.row == 0)
        {
            NSString* dateString = [GlobalMethods formattedDateForYear:self.appDelegate.settingsNew.retirementYear month:self.appDelegate.settingsNew.retirementMonth day:self.appDelegate.settingsNew.retirementDay];
            cell.detailTextLabel.text = dateString;
		}
        else if (indexPath.row == 1)
        {
            NSString* sql = [NSString stringWithFormat:@"SELECT * FROM Workdays"];
            NSArray* workdays = [SQLiteAccess selectManyRowsWithSQL:sql];
			NSString *workdaystring = @"     ";

			for (NSDictionary* workday in workdays)
            {
                NSInteger isWorkday = [[workday objectForKey:@"workday"] integerValue];
				if (isWorkday == 1)
                {
					{workdaystring = [workdaystring stringByAppendingFormat:@"%@, ",[workday objectForKey:@"abbr"]];}
				}
			}	
			NSInteger workdaystringlength = [workdaystring length];
			if (workdaystringlength > 0)
            {
				workdaystring = [workdaystring substringToIndex:workdaystringlength-2];
				cell.detailTextLabel.text = workdaystring;
            }
        }
        else if (indexPath.row == 2)
        {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self formattedTimeStringforBeginWorkhours],[self formattedTimeStringforEndWorkhours]];

        }
        else if (indexPath.row == 3)
        {
                NSString* sql = [NSString stringWithFormat:@"SELECT * FROM Holidays WHERE selected = 1"];
                NSArray *holidayList =  [SQLiteAccess selectManyRowsWithSQL:sql];
                NSInteger numberOfHolidaysSelected = holidayList.count;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"     %li holidays selected",(long)numberOfHolidaysSelected];
                
		}
        else if (indexPath.row == 4)
        {
			NSString *thisYear = [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.thisYearDaysOff];
			NSString *allYears =  [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.otherYearsDaysOff];
			NSString *retireYear =  [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.retirementYearDaysOff];
			
//			if ([self.appDelegate.settingsNew.thisYearDaysOff]) {thisYear = [self.appDelegate.settingsNew.ThisYearDaysOff"];}
//			if ([self.appDelegate.settingsNew.AllYearsDaysOff"]) {allYears = [self.appDelegate.settingsNew.AllYearsDaysOff"];}
//			if ([self.appDelegate.settingsNew.RetirementYearDaysOff"]) {retireYear = [self.appDelegate.settingsNew.RetirementYearDaysOff"];}
//
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Current - %@,  Between - %@,  Retire - %@",thisYear,allYears,retireYear];
		
        }
        else if (indexPath.row == 5)
        {
                NSString *option = self.appDelegate.settingsNew.displayOption;
                if ([option isEqualToString:@"Work"]) {cell.detailTextLabel.text = @"Work Days Remaining";}
                if ([option isEqualToString:@"Calendar"]) {cell.detailTextLabel.text = @"Calendar Days Remaining";}
                if ([option isEqualToString:@"None"]) {cell.detailTextLabel.text = @"Badge Option Disabled";}
                cell.imageView.image = [UIImage imageNamed:@"badgeDemo3.png"];

		}
        else if (indexPath.row == 6)
        {

			cell.detailTextLabel.text = nil;
        }
        else if (indexPath.row == 7)
        {
			cell.detailTextLabel.text = nil;
		}
        else
        {
			cell.detailTextLabel.text = nil;
		}
    

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor =[UIColor whiteColor];
    cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];

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

		} else if (indexPath.row == 1) {
			WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
			webViewController.title = @"FAQs";
            webViewController.urlString = @"https://mandellmobileapps.com/faqs";
			[[self navigationController] pushViewController:webViewController animated:YES];

        } else if (indexPath.row == 2) {
                HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
                helpViewController.title = @"Contact Me";
                [[self navigationController] pushViewController:helpViewController animated:YES];

                
		} else if (indexPath.row == 3) {

            NSString *iTunesLink = @"https://itunes.apple.com/us/app/retirement-countdown-ad-free/id424032584?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];


        }
	} else {



		if(indexPath.row==0) {
			RetirementDateViewController *retirementdateViewController = [[RetirementDateViewController alloc] initWithNibName:@"RetirementDate" bundle:nil];
//			retirementdateViewController.retirementDate = self.retirementDate;
			[[self navigationController] pushViewController:retirementdateViewController animated:YES];
            
		}else if(indexPath.row==1) {
            WorkdaysViewController *workdaysViewController = [[WorkdaysViewController alloc] initWithNibName:@"Workdays" bundle:nil];
            workdaysViewController.title = @"Work Days";
            [[self navigationController] pushViewController:workdaysViewController animated:YES];
            
		}else if(indexPath.row==2) {
			WorkhoursViewController *workhoursViewController = [[WorkhoursViewController alloc] initWithNibName:@"Workhours" bundle:nil];
			workhoursViewController.title = @"Work Hours";
			[[self navigationController] pushViewController:workhoursViewController animated:YES];

        }else if(indexPath.row==3) {
			HolidaysViewController *holidaysViewController = [[HolidaysViewController alloc] initWithNibName:@"Holidays" bundle:nil];
			holidaysViewController.title = @"Select Holiday";
			[[self navigationController] pushViewController:holidaysViewController animated:YES];
            
		}else if(indexPath.row==4) {
			StatutoryDaysOffViewController *statutoryDaysOffViewController = [[StatutoryDaysOffViewController alloc] initWithNibName:@"StatutoryDaysOffViewController" bundle:nil];
			statutoryDaysOffViewController.title = @"Annual Vacation Days";
			[[self navigationController] pushViewController:statutoryDaysOffViewController animated:YES];
        }else if(indexPath.row==5) {
                DisplayOptionsViewController *displayoptionsViewController = [[DisplayOptionsViewController alloc] initWithNibName:@"DisplayOptions" bundle:nil];
                displayoptionsViewController.title = @"Badge Options";
                [[self navigationController] pushViewController:displayoptionsViewController animated:YES];
		}else if(indexPath.row==6) {
			ImagePickerViewController *imagePickerViewController = [[ImagePickerViewController alloc] initWithNibName:@"ImagePickerViewController" bundle:nil];
			imagePickerViewController.title = @"Select Picture";
			[[self navigationController] pushViewController:imagePickerViewController animated:YES];
            
		}else if(indexPath.row==7) {
			DaysViewController *daysViewController = [[DaysViewController alloc] initWithNibName:@"DaysViewController" bundle:nil];
			daysViewController.title = @"Select Colors";
			[[self navigationController] pushViewController:daysViewController animated:YES];
		}
}

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
@end

