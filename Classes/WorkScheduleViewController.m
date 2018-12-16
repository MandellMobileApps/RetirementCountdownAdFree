//
//  WorkScheduleViewController.m
//  RetirementCountdownAdFree
//
//  Created by Jon Mandell on 2/4/13.
//  Copyright (c) 2013 MandellMobileApps. All rights reserved.
//

#import "WorkScheduleViewController.h"
#import "WorkhoursViewController.h"

#define NotThisMonthPicture @"GlossAluminum"

@interface WorkScheduleViewController ()

@end

@implementation WorkScheduleViewController


@synthesize thisTableView, thisView, firstDayOfWeek1, weekdaysList;

- (void)dealloc {

    [thisTableView release];
    [thisView release];
    [firstDayOfWeek1 release];
    [weekdaysList release];
	[super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.thisTableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

	self.weekdaysList = [NSArray arrayWithObjects:
    	@"Monday",
        @"Tuesday",
        @"Wednesday",
        @"Thursday",
        @"Friday",
        @"Saturday",
        @"Sunday",
    	@"Monday",
        @"Tuesday",
        @"Wednesday",
        @"Thursday",
        @"Friday",
        @"Saturday",
        @"Sunday",
    	nil];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    self.firstDayOfWeek1 = [[NSDate date] dateByAddingTimeInterval:-(([comps weekday]-1)*60*60*24)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTwoWeekCalendar
{
    

    
}

//
//
//
//
//
//
//	//loop through days  //////////////////////////////////////////////////////////////////
//	for(int i = 0; i < 14; i++) {
//		// get currrent date components
//		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//		NSDateComponents *currentdaycomps = [gregorian components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentdate];
//		int currentday = [currentdaycomps day];
//		int currentmonth = [currentdaycomps month];	
//		[gregorian release];
//		
//		//get day objects for current day
//		UILabel *daylabel = [self.labels objectAtIndex:i];
//		UILabel *checkmarklabel = [self.labelCheckmarks objectAtIndex:i];
//		UIButton *daybutton = [self.dayButtons objectAtIndex:i];
//		//UIImage *buttonBackground;
//
//		// set tag on buttons to current day (for identifying during tapping)
//        daybutton.tag = i;
//        [self getDayColorsFor:currentdate];
//        daylabel.textColor  = self.textColor;
//
//	
//		if ([[[[NSUserDefaults standardUserDefaults] arrayForKey:DaysForTwoWeekSchedule] objectAtIndex:i] isEqualToString:@"Yes"]) {
//			self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]];
//			daylabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:5])];
//		} else {   //@"Non workday
//			self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]];
//			daylabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:6])];
//		}
//		
//		[daybutton setBackgroundImage:self.buttonBackground forState:UIControlStateNormal];
//		[daybutton setBackgroundImage:self.buttonBackground forState:UIControlStateHighlighted];
//		
//		// add date to cell		
//		NSString *daylabeltext = [[NSString alloc] initWithFormat:@"%i", currentday];
//		daylabel.text = daylabeltext;
//		[daylabeltext release];
//
//		// is current day before today?  if so, put checkmark on it.
//		if ([self.thisIsToday compare:currentdate] == NSOrderedDescending) {  
//			unichar	character = 0x2573;
//			NSString *checkmark = [NSString stringWithCharacters:&character length:1];
//			checkmarklabel.text = checkmark;						
//		}
//
//		// increment to the next day of the month
//		currentdate = [self dateincrement:currentdate daystostep:1 monthstostep:0];
//		
//	}  // end of looping through days
//		
//	self.currentYear = year;  // set instance variable to current year
//	self.currentMonth = month; // set instance variable to current month
//	//NSLog(@"here 9");
//}
//
//
//
//-(NSInteger)getdaysinmonth:(NSInteger)month year:(NSInteger)year {
//	NSInteger dim;
//	dim = 0;
//	switch(month) {
//		case 1:		// January
//			dim = 31;
//			break;
//		case 2:		// February (check if leap-year)
//			dim = ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? 29 : 28;
//			break;
//		case 3:		// March
//			dim = 31;
//			break;
//		case 4:		// April
//			dim = 30;
//			break;
//		case 5:		// May
//			dim = 31;
//			break;
//		case 6:		// June
//			dim = 30;
//			break;
//		case 7:		// July
//			dim = 31;
//			break;
//		case 8:		// August
//			dim = 31;
//			break;
//		case 9:		// September
//			dim = 30;
//			break;
//		case 10:	// October
//			dim = 31;
//			break;
//		case 11:	// November
//			dim = 30;
//			break;
//		case 12:	// December
//			dim = 31;
//			break;
//	}
//	return dim;
//}
//
//
//- (void)previousMonth {
//	if(self.currentMonth == 1) {
//		self.currentYear--;
//		self.currentMonth = 12;
//	} else {
//		self.currentMonth--;
//	}	
//	[self drawCalendarForYear:self.currentYear month:self.currentMonth];	
//}
//
//
//- (void)nextMonth {
//	if(self.currentMonth == 12) {
//		self.currentYear++;
//		self.currentMonth = 1;
//	} else {
//		self.currentMonth++;
//	}	
//	[self drawCalendarForYear:self.currentYear month:self.currentMonth];	
//}
//
//
//- (void)previousYear {
//	self.currentYear--;
//	[self drawCalendarForYear:self.currentYear month:self.currentMonth];
//}
//
//
//- (void)nextYear {
//	self.currentYear++;
//	[self drawCalendarForYear:self.currentYear month:self.currentMonth];
//}
//
//
//- (void)updateSelectionDoubleTap:(id)sender {
//	NSDate *thedateselected = [self getdatefromcomps:self.currentMonth day:[sender tag] year:self.currentYear];
//	int index = 0;
//	int index2 = 0;
//	for (id workday in self.appDelegate.manualworkdays) {
//		index++;
//		if ([(NSDate*)[workday objectAtIndex:0] compare:thedateselected] == NSOrderedSame) {
//				index2 = index;
//		}
//		
//	}
//		if (index2 > 0) {
//		[self.appDelegate.manualworkdays removeObjectAtIndex:index2-1];
//		}
//		
//		//set manual workdays in DataEngine
//
//		[self drawCalendarForYear:self.currentYear month:self.currentMonth];		
//}
//
//
//- (void)updateSelection:(id)sender {
//	NSDate *thedateselected = [self getdatefromcomps:self.currentMonth day:[sender tag] year:self.currentYear];
////NSLog(@"here");
//		int indb = 0;
//	NSString *stateofday;
//
//	int w = 0;	
//	//NSLog(@"here 1 ");
//		for (id workday in self.appDelegate.manualworkdays) {
//	//	NSLog(@"here 2 ");
//			if ([(NSDate*)[workday objectAtIndex:0] isEqualToDate:thedateselected]) {
//				indb = 1;
//				if ([[workday objectAtIndex:1] isEqualToString:@"YES"]) {
//					[[self.appDelegate.manualworkdays objectAtIndex:w] replaceObjectAtIndex:1  withObject:@"NO"];
//					stateofday = @"NO";
//				} else {
//					[[self.appDelegate.manualworkdays objectAtIndex:w] replaceObjectAtIndex:1  withObject:@"YES"];
//					stateofday = @"YES";
//				}
//			}
//			w++;
//		}
//	//NSLog(@"here 3 ");
//
//	//add to manual if not already on manual list	
//		if (indb==0) {
//			// get current status (is it currently a workday?)
//			stateofday = [GlobalMethods isDefaultDayWorkday:thedateselected forWorkdays:self.appDelegate.workdays forHolidays:self.appDelegate.holidaylist];
//			NSLog(@"stateofday %@",stateofday);
//
//			if ([stateofday isEqualToString:@"YES"]) {
//				stateofday = @"NO";
//			}else{
//				stateofday = @"YES";
//			}
//			NSMutableArray *objectarray = [[NSMutableArray alloc ] initWithObjects:thedateselected,stateofday,nil];
//			[self.appDelegate.manualworkdays addObject:objectarray];
//			[objectarray release];
//
//		}
//
//
//	if ([stateofday isEqualToString:@"YES"]) {  // workday
//		[[self.dayButtons objectAtIndex:[sender tag] + self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]] forState:UIControlStateNormal];
//		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]] forState:UIControlStateHighlighted];
//		[[self.labels objectAtIndex:[sender tag]+ self.day1weekday - 2] setTextColor:[ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:5])]];
//	} else {
//		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]] forState:UIControlStateNormal];
//		[[self.dayButtons objectAtIndex:[sender tag]+ self.day1weekday - 2]  setBackgroundImage:[self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]] forState:UIControlStateHighlighted];
//		[[self.labels objectAtIndex:[sender tag]+ self.day1weekday - 2] setTextColor:[ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:6])]];
//	}	
//	
//
//}
//
//- (NSString*)currentMonthName {
//	return [self.monthNames objectAtIndex:self.currentMonth - 1];
//}
//
//-(NSDate*) dateincrement:(NSDate*)date daystostep:(NSInteger)daystoStep monthstostep:(NSInteger)monthstoStep {
//	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//		[offsetComponents  setDay:daystoStep];	
//		[offsetComponents  setMonth:monthstoStep];
//	NSDate *newdate = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];// autorelease];
//	[gregorian release];
//	[offsetComponents release];
//	return newdate;
//}
//
//-(NSDate *)getfirstdayofmonth:(NSDate *)date {
//	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *todaycomps = [gregorian components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
//	[todaycomps setDay:1];
//	NSDate *todayfirstofmonthdate= [gregorian dateFromComponents:todaycomps];
//	[gregorian release];	
//	return todayfirstofmonthdate;
//}
//
//-(NSDate *)getdatefromcomps:(NSInteger)month day:(NSInteger)day year:(NSInteger)year {
//	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *comps = [[NSDateComponents alloc] init];
//	[comps setDay:day];
//	[comps setMonth:month];
//	[comps setYear:year];
//	NSDate *date = [gregorian dateFromComponents:comps];
//	[comps release];
//	[gregorian release];
//	return date;
//
//}
//
//
//#pragma mark -
//#pragma mark Day Methods
//
//-(void)getDayColorsFor:(NSDate*)date {
//	
//	NSString *workdayStatus = [GlobalMethods isWorkday:date forWorkdays:self.appDelegate.workdays];	
//	NSString *holidayStatus = [GlobalMethods isHoliday:date forHolidays:self.appDelegate.holidaylist];
//	NSString *manualWorkdayStatus = [GlobalMethods isManualWorkday:date forManualWorkdays:self.appDelegate.manualworkdays];
//	//NSLog(@"date %@",date);
//
//
//	if ([workdayStatus isEqualToString:@"YES"]) { //@"Workday";
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:2]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:2])];
//	}else {  //@"NonWorkday";
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:3]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:3])];
//	}
//	
//	
//	if (![holidayStatus isEqualToString:@"NO"]) {
//		NSArray *tempHolidays = [[NSArray alloc] initWithObjects:@"USA Independance Day",@"Thanksgiving Day",@"Christmas",nil];
//		for (NSString *holiday in tempHolidays) {
//			if ([holidayStatus isEqualToString:holiday]) {
//				if ([holiday isEqualToString:@"USA Independance Day"]) {
//					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
//					self.textColor = [UIColor whiteColor];
//				} else if ([holiday isEqualToString:@"Thanksgiving Day"]) {
//					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
//					self.textColor = [UIColor whiteColor];				
//				} else if ([holiday isEqualToString:@"Christmas"]) {
//					self.buttonBackground = [self.appDelegate imageFromCache:holidayStatus];
//					self.textColor = [UIColor blackColor];
//				}
//			} else {
//				self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:4]];
//				self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:4])];
//			}
//			
//		}
//		[tempHolidays release];
//		
//		
//	}	
//	//NSLog(@"here 7");
//	
//	if ([[GlobalMethods getToday] compare:date] == NSOrderedSame) {  	//@"Today";
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:0]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:0])];
//	}
//
//	if ([[GlobalMethods getThisDateAtMidnight:[self.appDelegate.settings objectForKey:@"RetirementDate"]] compare:date] == NSOrderedSame) {  //@"Retirement Day";
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:1]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:1])];
//	}
//	
//	if ([manualWorkdayStatus isEqualToString:@"ManualYES"]) {
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:5]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:5])];
//		
//	}else if ([manualWorkdayStatus isEqualToString:@"ManualNO"]){
//		self.buttonBackground = [self.appDelegate imageFromCache:[self.appDelegate.backgroundColors objectAtIndex:6]];
//		self.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:6])];
//	}
//	
////NSLog(@"here 8");
//}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0)
    {
    	return 2;
    }
	if ([[NSUserDefaults standardUserDefaults] integerForKey:WorkScheduleSelected] == 0) {
    	return 7;
    }
	return 14;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"One Week Schedule";
            cell.detailTextLabel.text = @"";
        }
        else
        {
            cell.textLabel.text = @"Two Week Schedule";
            cell.detailTextLabel.text = @"";
        }
        if (indexPath.row == [[NSUserDefaults standardUserDefaults] integerForKey:WorkScheduleSelected]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark; 
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.weekdaysList objectAtIndex:indexPath.row],[self stringFromDate:[self.firstDayOfWeek1 dateByAddingTimeInterval:(24*60*60*indexPath.row)]]];
        cell.detailTextLabel.text = @"Workday";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
 
    if (indexPath.section == 0)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:WorkScheduleSelected];
        [tableView reloadData];
    }
    else
    {
        WorkhoursViewController *workhoursViewController = [[WorkhoursViewController alloc] initWithNibName:@"Workhours" bundle:nil];
        workhoursViewController.title = @"Work Day Schedule";
        [[self navigationController] pushViewController:workhoursViewController animated:YES];
        [workhoursViewController release];    	
    
    }

}

-(NSString*)stringFromDate:(NSDate*)thisDate
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [dateFormatter stringFromDate:thisDate];

}

@end
