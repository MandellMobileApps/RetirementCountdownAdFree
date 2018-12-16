//
//  ShiftWorkViewController.m
//  RetirementCountdownAdFree
//
//  Created by Cami Mandell on 9/11/14.
//  Copyright (c) 2014 MandellMobileApps. All rights reserved.
//

#import "ShiftWorkViewController.h"
#import "ShiftWorkDetailViewController.h"
#import "PurchaseViewController.h"


@interface ShiftWorkViewController ()

@end

@implementation ShiftWorkViewController

@synthesize timeArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.purchaseViewController = [[PurchaseViewController alloc]init];
    
//    [[SKPaymentQueue defaultQueue]
//     addTransactionObserver:self.homePurchaseViewController];
    
    //self.workHoursBeginOn = YES;
    
    UIImage* image = [UIImage imageNamed:@"checkbox-empty.V2.png"];
    
    CGRect frameimg = CGRectMake(0, 0, 30, 40);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(purchase:)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    
    [self.navigationItem setRightBarButtonItem:barBtn];
    
    //self.offOnTimeArray = [NSArray arrayWithObjects:
//                             @"0",
//                             @"1",
//                             @"2",
//                             @"3",
//                             @"4",
//                             @"5",
//                             @"6",
//                             @"7",
//                             @"8",
//                             @"9",
//                             @"10",
//                             @"11",
//                             @"12",
//                             @"13",
//                             @"14",
//                             @"15",
//                             @"16",
//                             @"17",
//                             @"18",
//                             @"19",
//                             @"20",
//                             @"21",
//                           @"22",
//                           @"23",
//                           @"24",
//                           @"25",
//                           @"26",
//                           @"27",
//                           @"28",
//                           @"29",
//                           @"30",
//                           @"31",
//                           @"32",
//                           @"33",
//                           @"34",
//                           @"35",
//                           @"36",
//                           @"37",
//                           @"38",
//                           @"39",
//                           @"40",
//                           @"41",
//                           @"42",
//                           @"43",
//                           @"44",
//                           @"45",
//                           @"46",
//                           @"47",
//                           @"48",
//                           @"49",
//                             nil];
    
//    CGRect frameimg = CGRectMake(0, 0, 30, 40);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    //[someButton setBackgroundImage:image forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(shiftWorkOnOff:)
//         forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *someButton = [[UIBarButtonItem alloc] initWithTitle:@"Turn On" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    //UIBarButtonItem *barBtn =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    
    //[self.navigationItem setRightBarButtonItem:someButton];
    
    NSInteger shiftWorkInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"shiftWorkType"];
    [self.shiftWorkType setSelectedSegmentIndex:shiftWorkInteger];
    
    self.setWeekButtonOn1 = [[NSUserDefaults standardUserDefaults] boolForKey:@"setWeekButtonOn1"];
    
    self.setWeekButtonOn2 = [[NSUserDefaults standardUserDefaults] boolForKey:@"setWeekButtonOn2"];
    
    self.setWeekButtonOn3 = [[NSUserDefaults standardUserDefaults] boolForKey:@"setWeekButtonOn3"];
    
    self.setWeekButtonOn4 = [[NSUserDefaults standardUserDefaults] boolForKey:@"setWeekButtonOn4"];
    

    
    self.beginhoursbutton.tintColor = [UIColor blueColor];
    
    self.offOnHoursTimeArray = [NSMutableArray arrayWithObjects:@"HoursOn", @"HoursOff",nil];

    self.allworkoffon = [NSMutableArray arrayWithObjects: @"Start date and time", @"Hours on", @"Hours off",nil];
    self.timeArray = [NSMutableArray arrayWithObjects:@"Begin", @"End",nil];
//	self.selectedshiftdays = self.appDelegate.shiftworkdays;
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    
//    self.dataArray = [NSArray arrayWithObjects:@"Begin", @"End",nil];
    
    self.shiftDaysArray = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    
    self.shiftdays0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"shiftdays0"];
    self.shiftdays1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"shiftdays1"];
    self.shiftdays2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"shiftdays2"];
    self.shiftdays3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"shiftdays3"];

    
    if (!self.shiftdays0) {
        self.shiftdays0 = [self defaultArray];
    }
    else
    {
        self.shiftdays0 = [NSMutableArray arrayWithArray:self.shiftdays0];
    }

    
    if (!self.shiftdays1) {
        self.shiftdays1 = [self defaultArray];
    }
    else
    {
        self.shiftdays1 = [NSMutableArray arrayWithArray:self.shiftdays0];
    }
    
    if (!self.shiftdays2) {
        self.shiftdays2 = [self defaultArray];
    }
    else
    {
        self.shiftdays2 = [NSMutableArray arrayWithArray:self.shiftdays0];
    }
    
    if (!self.shiftdays3) {
        self.shiftdays3 = [self defaultArray];
    }
     else
    {
        self.shiftdays3 = [NSMutableArray arrayWithArray:self.shiftdays0];
    }
    
    self.currentSelection = -1;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    //self.beginshiftworkhours = [[NSUserDefaults standardUserDefaults] objectForKey:@"Begin"];
    //self.endshiftworkhours = [[NSUserDefaults standardUserDefaults] objectForKey:@"End"];
    
//    self.beginshiftworkhours = [self.appDelegate.settings objectForKey:@"Begin"];
//    self.endshiftworkhours = [self.appDelegate.settings objectForKey:@"End"];

    
//    self.detaildataArray = [NSArray arrayWithObjects:self.beginshiftworkhours,self.endshiftworkhours,nil];
    
    self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    self.pickerViewContainer.frame = CGRectMake(0,self.view.bounds.size.height, 320, 250);
    
    self.endhoursbutton.tintColor = [UIColor lightGrayColor];

    [self.thisTableView reloadData];
}

//-(void)createShiftDays0 {
//    self.shiftdays0 = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",nil];
//
//}
//
//-(void)createShiftDays1 {
//    self.shiftdays1 = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",nil];
//}
//
//-(void)createShiftDays2 {
//    self.shiftdays2 = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",nil];
//}
//
//-(void)createShiftDays3 {
//    self.shiftdays3 = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",nil];
//}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}




#pragma mark Table view methods


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    int h = 25;
    
    return h;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.bounds.size.width, 50)];
    [headerView setBackgroundColor:[UIColor grayColor]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];

    
    self.setWeekButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 2.5, 20, 20)];
    self.setWeekButton.backgroundColor = [UIColor clearColor];
    
    if (self.shiftWorkType.selectedSegmentIndex == 1) {
        self.setWeekButton.enabled = YES;
    }
    
    else {
        self.setWeekButton.enabled = NO;
    }

    [self.setWeekButton addTarget:self action:@selector(setWeek:) forControlEvents:UIControlEventTouchUpInside];
    self.setWeekButton.tag = section;
[headerView addSubview:self.setWeekButton];
//    
    if (section == 0){
        [headerLabel setText:@"Week 1"];
        if (self.setWeekButtonOn1) {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-filled.png"] forState:UIControlStateNormal];
        }
        
        else {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-empty.V2.png"] forState:UIControlStateNormal];
        }
    }
    else if (section == 1){
        [headerLabel setText:@"Week 2"];
        
        if (self.setWeekButtonOn2) {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-filled.png"] forState:UIControlStateNormal];
        }
        
        else {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-empty.V2.png"] forState:UIControlStateNormal];
        }

    }
    else if (section == 2){
        [headerLabel setText:@"Week 3"];
        
        if (self.setWeekButtonOn3) {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-filled.png"] forState:UIControlStateNormal];
        }
        
        else {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-empty.V2.png"] forState:UIControlStateNormal];
        }
    }
    else if (section == 3){
        [headerLabel setText:@"Week 4"];
        
        if (self.setWeekButtonOn4) {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-filled.png"] forState:UIControlStateNormal];
        }
        
        else {
            [self.setWeekButton setImage:[UIImage imageNamed:@"checkbox-empty.V2.png"] forState:UIControlStateNormal];
        }
    }
    else if (section == 4)
    {
        [headerLabel setText:@"Time On/Off"];
    }
    
    [headerView addSubview:headerLabel];
//    return headerLabel;
   // return resetWeekButton;
    return headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    
    switch (section) {
        case 0:
            return self.shiftdays0.count;
            break;
        case 1:
            return self.shiftdays1.count;
            break;
        case 2:
            return self.shiftdays2.count;
            break;
        case 3:
            return self.shiftdays3.count;
            break;
        case 4:
            return self.allworkoffon.count;
            break;
        default:
            break;
    }
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.opaque = NO;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

    
    if (indexPath.section == 4) {
        cell.textLabel.text = [self.allworkoffon objectAtIndex:indexPath.row];
        
//        if (indexPath.row == 0) {
//            
        }
        
        
    
    else {
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = [self.shiftDaysArray objectAtIndex:indexPath.row];
            //cell.detailTextLabel =
        }
    
    

    switch (self.shiftWorkType.selectedSegmentIndex)
    {
    case 0:{
            self.setWeekButton.enabled = NO;
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            if (indexPath.section == 0) {
                NSMutableDictionary *temp = [self.shiftdays0 objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];
            
            }
       else if (indexPath.section == 1) {
            NSMutableDictionary *temp = [self.shiftdays1 objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];
            
        }
        else if (indexPath.section == 2) {
            NSMutableDictionary *temp = [self.shiftdays2 objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];
            
        }
       else  if (indexPath.section == 3) {
            NSMutableDictionary *temp = [self.shiftdays3 objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];
            
        }
        
            else if (indexPath.section == 4) {
                cell.textLabel.text = [self.allworkoffon objectAtIndex:indexPath.row];
                
                if (indexPath.row == 0) {
                    
                }
                
                else {
                    cell.detailTextLabel.text = @"";
                }
            }
        
            else {
            

            cell.textLabel.text = [self.shiftDaysArray objectAtIndex:indexPath.row];

            }
    }
            break;
            
    case 1:{
    
            switch (indexPath.section) {
                case 0:{
                    if (self.setWeekButtonOn1) {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor blueColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }
                    
                    else {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor grayColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    NSMutableDictionary *temp = [self.shiftdays0 objectAtIndex:indexPath.row];
                    cell.textLabel.text = [temp objectForKey:@"label"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];

                }
                    break;
                    
                case 1:{
                    if (self.setWeekButtonOn2) {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor blueColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }
                    
                    else {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor grayColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    NSDictionary *temp = [self.shiftdays1 objectAtIndex:indexPath.row];
                    cell.textLabel.text = [temp objectForKey:@"label"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];

                }
                    break;
                    
                case 2:{
                    if (self.setWeekButtonOn3) {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor blueColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }
                    
                    else {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor grayColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    NSDictionary *temp = [self.shiftdays2 objectAtIndex:indexPath.row];
                    cell.textLabel.text = [temp objectForKey:@"label"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];

                }
                    break;
                    
                case 3:{
                    if (self.setWeekButtonOn4) {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor blueColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }
                    
                    else {
                        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                        cell.detailTextLabel.textColor = [UIColor grayColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    NSDictionary *temp = [self.shiftdays3 objectAtIndex:indexPath.row];
                    cell.textLabel.text = [temp objectForKey:@"label"];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"     %@ - %@",[self.dateFormatter stringFromDate:[temp objectForKey:@"Begin"]],[self.dateFormatter stringFromDate:[temp objectForKey:@"End"]]];
                }
                    break;

                case 4:{
                        cell.textLabel.text = [self.allworkoffon objectAtIndex:indexPath.row];
                    
                    if (indexPath.row == 0) {
                        
                    }
                    
                    else {
                        cell.detailTextLabel.text = @"";
                    }
                    break;
                default:
                break;
                }
            }
    break;
    
    case 2:{
        
      // NSDictionary *temp = [self.offOnHoursTimeArray objectAtIndex:indexPath.row];
        
        
        if (indexPath.row == 0) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:[temp objectForKey:@"HoursOn"]]];
        }
        
        else {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:[temp objectForKey:@"HoursOff"]]];
        }


        
        if (indexPath.section == 4) {
            
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            cell.detailTextLabel.textColor = [UIColor blueColor];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.textLabel.text = [self.allworkoffon objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0) {
                
            }
            
            else {
                    
                    if (indexPath.row == 1) {
                        
                        cell.detailTextLabel.text = @"HoursOn";
                        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
                        
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.numberStyle = NSNumberFormatterDecimalStyle;
//                        cell.detailTextLabel.text = [formatter stringFromNumber:[NSNumber numberWithFloat:[self.appDelegate.day.steps floatValue]]];
//
//                        if (self.trackStepSwitchButton.isOn) {
//                            
//                        }
//                        
//                        else {
//                            [self addBorderAround:MyCell.timeLabel cornerType:CornerTypeSquare withColor:[UIColor blackColor]];
//                        }
                        
                    }
                    
                    if (indexPath.row == 2) {
                        
                        cell.detailTextLabel.text = @"HoursOff";
                        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
                        
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.numberStyle = NSNumberFormatterDecimalStyle;
//                        cell.detailTextLabel.text = [formatter stringFromNumber:[NSNumber numberWithFloat:[self.appDelegate.day.steps floatValue]]];
                        //
                        //                        if (self.trackStepSwitchButton.isOn) {
                        //
                        //                        }
                        //
                        //                        else {
                        //                            [self addBorderAround:MyCell.timeLabel cornerType:CornerTypeSquare withColor:[UIColor blackColor]];
                        //                        }
                        
                    }
            }
            

        }
        
        else {
            
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
        }
        }
    break;
    
default:
    break;
    
    }
    }

    return cell;
    }




-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.selectedIndexPath = indexPath;
    NSMutableDictionary* times;
    
    switch (self.shiftWorkType.selectedSegmentIndex) {
        case 0:{
            
            //no selection
            
        }
        break;
            
        case 1:{
            
            switch (indexPath.section) {
                case 0:{
                    if (self.setWeekButtonOn1) {
                        times = [self.shiftdays0 objectAtIndex:self.selectedIndexPath.row];
                        [self showDatePickerForDayTimes:times];
                        [tableView reloadData];
                        self.appDelegate.colorsChanged = YES;
                        
                    }
                }
                    break;
                    
                case 1:{
                    if (self.setWeekButtonOn2) {
                        times = [self.shiftdays1 objectAtIndex:self.selectedIndexPath.row];
                        [self showDatePickerForDayTimes:times];
                        [tableView reloadData];
                        self.appDelegate.colorsChanged = YES;
                        
                    }
                    
                }
                    break;
                    
                case 2:{
                    if (self.setWeekButtonOn3) {
                        times = [self.shiftdays2 objectAtIndex:self.selectedIndexPath.row];
                        [self showDatePickerForDayTimes:times];
                        [tableView reloadData];
                        self.appDelegate.colorsChanged = YES;
                        
                    }
                    
                    
                }
                    break;
                    
                case 3:{
                    if (self.setWeekButtonOn4) {
                        times = [self.shiftdays3 objectAtIndex:self.selectedIndexPath.row];
                        [self showDatePickerForDayTimes:times];
                        [tableView reloadData];
                        self.appDelegate.colorsChanged = YES;
                        
                    }
                    
                }
                    break;
                    
                case 4:{
                    [self showDatePicker];
//                    //            times = [self.detaildataArray objectAtIndex:self.selectedIndexPath.row];
//                    //            [self showDatePickerForDayTimes:times];
//                    //            [tableView reloadData];
//                    self.appDelegate.colorsChanged = YES;
//                    self.pickerView.hidden = YES;
//                    self.pickerViewOffOn.hidden = NO;
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
            
       
        
        case 2:{
            
            if (indexPath.section == 4) {
                
                if (indexPath.row == 0) {
            
                    self.appDelegate.colorsChanged = YES;
                    self.pickerView.hidden = NO;
                }
                
                else {
                    
                }
                
            }
            
            else {
                
            }
            
        }
            break;
        default:
            break;
    
case 3:{
    if (indexPath.section == 4) {
        if (indexPath.row == 1) {

                //self.baseContentView.userInteractionEnabled = NO;
                //[self addNumberPadForString:self.lastSelectedCell.detailTextLabel.text withTitle:[TIHDate dateStringFromDate:self.appDelegate.day.date withFormat:DateFormatMediumDateNoTime] andUnits:@"Enter Hours On" tag:1];
                
           
        }
        
        else if (indexPath.row == 1) {
            
            //self.baseContentView.userInteractionEnabled = NO;
            //[self addNumberPadForString:self.lastSelectedCell.detailTextLabel.text withTitle:[TIHDate dateStringFromDate:self.appDelegate.day.date withFormat:DateFormatMediumDateNoTime] andUnits:@"Enter Hours Off" tag:2];
            
            
        }
    }
}

}
}


#pragma mark Date Picker

- (IBAction)dateAction:(id)sender {
    
//    NSMutableDictionary *temp;
//    
//    if (self.selectedIndexPath.section == 0)
//    {
//        temp = [self.shiftdays0 objectAtIndex:self.selectedIndexPath.row];
//        
//    }
//    
//    else if (self.selectedIndexPath.section == 1)
//    {
//        temp = [self.shiftdays1 objectAtIndex:self.selectedIndexPath.row];
//        
//    }
//    
//    else if (self.selectedIndexPath.section == 2)
//    {
//        temp = [self.shiftdays2 objectAtIndex:self.selectedIndexPath.row];
//        
//    }
//    
//    else if (self.selectedIndexPath.section == 3)
//    {
//        temp = [self.shiftdays3 objectAtIndex:self.selectedIndexPath.row];
//        
//    }
//    else if (self.selectedIndexPath.section == 4)
//    {
//        temp = [self.detaildataArray objectAtIndex:self.selectedIndexPath.row];
//        
//    }
//    temp = [NSMutableDictionary dictionaryWithDictionary:temp];
    
    if (self.workHoursBeginOn)
    {
        //[temp setObject:self.pickerView.date forKey:@"Begin"];
        self.currentBeginshiftworkhours = self.pickerView.date;
    }
    
    else
        
    {
       //[temp setObject:self.pickerView.date forKey:@"End"];
        self.currentEndshiftworkhours = self.pickerView.date;
    }
    
}

//-(BOOL) isThereDate:(NSDate*)date
//
//{
//    if ([date compare:[NSDate dateWithTimeIntervalSince1970:0]] == NSOrderedSame)
//    {
//        return NO;
//    }
//    
//    return YES;
//}


-(void) showDatePickerForDayTimes:(NSMutableDictionary*)temp

{

    NSDate *begin = [temp objectForKey:@"Begin"];
    NSDate* end = [temp objectForKey:@"End"];
    NSString* label = [temp objectForKey:@"label"];
    
    self.currentShiftLabel = label;
    
    self.currentBeginshiftworkhours = begin;
    self.currentEndshiftworkhours = end;

    CGRect  showRect = CGRectMake(0,self.view.bounds.size.height-250, 320, 250);
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.view addSubview:self.pickerViewContainer];
                         self.pickerViewContainer.frame = showRect;
                     }
                     completion:^(BOOL finished){
                         
                         if (self.workHoursBeginOn)
                         {
                            [self.pickerView setDate:begin animated:YES];
                         }
                         
                         else
                            
                         {
                            [self.pickerView setDate:end animated:YES];
                         }
                         
                     }];
}

-(void) showDatePicker

{
    
    if (!self.startDateTime) {
        self.startDateTime = [NSDate date];
    }
    

    
    CGRect  showRect = CGRectMake(0,self.view.bounds.size.height-250, 320, 250);
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.view addSubview:self.pickerView];
                         self.pickerView.frame = showRect;
                     }
                     completion:^(BOOL finished){
                         [self.pickerView setDate:self.startDateTime];
                         
                     }];
}

-(void) hideDatePicker
{
    
    CGRect	hideRect = CGRectMake(0,self.view.bounds.size.height, 320, 0);
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.pickerViewContainer.frame = hideRect;
                     }
                     completion:^(BOOL finished){
                         [self.pickerViewContainer removeFromSuperview];
                     }];
    
    
}

-(IBAction)datePickerDoneButtonTapped:(id)sender {
    
        NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.currentShiftLabel, @"label",
                                     self.currentBeginshiftworkhours, @"Begin",
                                     self.currentEndshiftworkhours, @"End",
                                     nil];
    
        if (self.selectedIndexPath.section == 0)
        {
            [self.shiftdays0 replaceObjectAtIndex:self.selectedIndexPath.row withObject:temp];
    
        }
    
        else if (self.selectedIndexPath.section == 1)
        {
            [self.shiftdays1 replaceObjectAtIndex:self.selectedIndexPath.row withObject:temp];
    
        }
    
        else if (self.selectedIndexPath.section == 2)
        {
            [self.shiftdays2 replaceObjectAtIndex:self.selectedIndexPath.row withObject:temp];
    
        }
    
        else if (self.selectedIndexPath.section == 3)
        {
            [self.shiftdays3 replaceObjectAtIndex:self.selectedIndexPath.row withObject:temp];
    
        }
        else if (self.selectedIndexPath.section == 4)
        {
           [self.shiftdays0 replaceObjectAtIndex:self.selectedIndexPath.row withObject:temp];
    
        }
        temp = [NSMutableDictionary dictionaryWithDictionary:temp];
    
    if (self.workHoursBeginOn)
    {
        //[temp setObject:self.pickerView.date forKey:@"Begin"];
        self.currentBeginshiftworkhours = self.pickerView.date;
    }
    
    else
        
    {
        //[temp setObject:self.pickerView.date forKey:@"End"];
        self.currentEndshiftworkhours = self.pickerView.date;
    }
    
    [self hideDatePicker];
    [self.thisTableView reloadData];

    
}

-(IBAction)beginworkhours:(id)sender {
    
    self.workHoursBeginOn = YES;

    self.endhoursbutton.tintColor = [UIColor lightGrayColor];
    self.beginhoursbutton.tintColor = [UIColor blueColor];
    
    if (self.pickerView)
    {
        if (self.workHoursBeginOn)
         {
            [self.pickerView setDate:self.currentBeginshiftworkhours animated:YES];
         }
         
         else
            
         {
            [self.pickerView setDate:self.currentEndshiftworkhours animated:YES];
         }
     }

}

-(IBAction)endworkhours:(id)sender {
    
    self.workHoursBeginOn = NO;
    
    self.beginhoursbutton.tintColor = [UIColor lightGrayColor];
    self.endhoursbutton.tintColor = [UIColor blueColor];
    if (self.pickerView)
    {
        if (self.workHoursBeginOn)
         {
            [self.pickerView setDate:self.currentBeginshiftworkhours animated:YES];
         }
         
         else
            
         {
            [self.pickerView setDate:self.currentEndshiftworkhours animated:YES];
         }
     }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.shiftdays0 forKey:@"shiftdays0"];
    [[NSUserDefaults standardUserDefaults] setObject:self.shiftdays1 forKey:@"shiftdays1"];
    [[NSUserDefaults standardUserDefaults] setObject:self.shiftdays2 forKey:@"shiftdays2"];
    [[NSUserDefaults standardUserDefaults] setObject:self.shiftdays3 forKey:@"shiftdays3"];

    [[NSUserDefaults standardUserDefaults] setObject:self.startDateTime forKey:@"startDateTime"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.hoursOn forKey:@"HoursOn"];
    [[NSUserDefaults standardUserDefaults] setObject:self.hoursOff forKey:@"HoursOff"];


}

-(NSMutableArray *)defaultArray {
    NSMutableArray* temp = [NSMutableArray array];
    
    [temp addObject: [self defaultDictionaryFor:0]];
    [temp addObject: [self defaultDictionaryFor:1]];
    [temp addObject: [self defaultDictionaryFor:2]];
    [temp addObject: [self defaultDictionaryFor:3]];
    [temp addObject: [self defaultDictionaryFor:4]];
    [temp addObject: [self defaultDictionaryFor:5]];
    [temp addObject: [self defaultDictionaryFor:6]];
    
    return temp;
}

-(NSMutableDictionary *)defaultDictionaryFor:(int)label  {
    NSMutableDictionary* temp = [NSMutableDictionary dictionary];
    [temp setObject:[NSDate dateWithTimeIntervalSince1970:-60*60*8] forKey:@"Begin"];
    [temp setObject:[NSDate dateWithTimeIntervalSince1970:0] forKey:@"End"];
    [temp setObject:[self.shiftDaysArray objectAtIndex:label] forKey:@"label"];
    
    
    return temp;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30.0;
//}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   // self.appDelegate.day.waterCupsString = [self.waterAmountArray objectAtIndex:row];

    [self.thisTableView reloadData];
    
}

- (void)dealloc {
    [self.shiftdays0 release];
    [self.shiftdays1 release];
    [self.shiftdays2 release];
    [self.shiftdays3 release];
    [self.allworkoffon release];
    [self.allshiftdays release];
    [self.selectedshiftdays release];
    [super dealloc];
}


- (IBAction)shiftWorkType:(UISegmentedControl* )sender {
    
    [self.thisTableView reloadData];
    
    //Default is regular code
    switch (self.shiftWorkType.selectedSegmentIndex) {
        case 0:
            //Use regular code
            //[self regularCodeFirstMethod]
            break;
        case 1:
            //Use shiftwork code
            //[self shiftWorkCodeFirstMethod]
            break;
        case 2:
            //Use on/off hours code
            //[self off/on code first method]
            break;
        default:
            break;
    }
    
     [[NSUserDefaults standardUserDefaults] setInteger:self.shiftWorkType.selectedSegmentIndex forKey:@"shiftWorkType"];
}

-(IBAction)setWeek:(UIButton*)sender {
    
    
    switch (sender.tag) {
        case 0:{
            
            
            if (self.setWeekButtonOn1)
            {
                self.setWeekButtonOn1 = NO;
            }
            
            else {
                self.setWeekButtonOn1 = YES;
                
            }
                [[NSUserDefaults standardUserDefaults] setBool:self.setWeekButtonOn1 forKey:@"setWeekButtonOn1"];
            }
            break;
            
        case 1:{
            
            
            if (self.setWeekButtonOn2)
            {
                self.setWeekButtonOn2 = NO;
            }
            
            else {
                self.setWeekButtonOn2 = YES;
            }
            [[NSUserDefaults standardUserDefaults] setBool:self.setWeekButtonOn2 forKey:@"setWeekButtonOn2"];
            
        }
            break;
            
        case 2:{
            
            
            if (self.setWeekButtonOn3)
            {
                self.setWeekButtonOn3 = NO;
            }
            
            else {
                self.setWeekButtonOn3 = YES;
            }
            [[NSUserDefaults standardUserDefaults] setBool:self.setWeekButtonOn3 forKey:@"setWeekButtonOn3"];
            
        }
            break;
            
        case 3:{
            
            
            if (self.setWeekButtonOn4)
            {
                self.setWeekButtonOn4 = NO;
            }
            
            else {
                self.setWeekButtonOn4 = YES;
            }
            [[NSUserDefaults standardUserDefaults] setBool:self.setWeekButtonOn4 forKey:@"setWeekButtonOn4"];
            
        }
            break;
            
        default:
            break;
    }
    
    [self.thisTableView reloadData];
}

#pragma inAppPurchase code


#define shiftWorkProductIdentifier @"RetirementShiftWork"

-(IBAction)purchase:(id)sender
{
    HomePurchaseViewController *homePurchaseViewController = [[HomePurchaseViewController alloc] initWithNibName:@"HomePurchaseViewController" bundle:nil];
    //HomePurchaseViewController.title = @"HomePurchaseViewController";
    [[self navigationController] pushViewController:homePurchaseViewController animated:YES];
    [HomePurchaseViewController release];
}


-(IBAction)inAppPurchase:(id)sender
{
    
    
}

- (IBAction)purchaseShiftWork:(id)sender {
    
    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        
        //If you have more than one in-app purchase, and would like
        //to have the user purchase a different product, simply define
        //another function and replace kRemoveAdsProductIdentifier with
        //the identifier for the other product
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:shiftWorkProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
    
//    _purchaseController.productID =
//    @"<YOUR PRODUCT ID GOES HERE>";
//    
//    [self.navigationController
//     pushViewController:_purchaseController animated:YES];
//    
//    [_purchaseController getProductInfo: self];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

//- (void)purchase:(SKProduct *)product{
//    SKPayment *payment = [SKPayment paymentWithProduct:product];
//    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
//}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            NSLog(@"Transaction state -> Restored");
            
            //if you have more than one in-app purchase product,
            //you restore the correct product for the identifier.
            //For example, you could use
            //if(productID == kRemoveAdsProductIdentifier)
            //to get the product identifier for the
            //restored purchases, you can use
            //
            //NSString *productID = transaction.payment.productIdentifier;
            //[self doRemoveAds];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                //[self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

#pragma mark - Number pad methods

-(void)addNumberPadForString:(NSString*)currentValue withTitle:(NSString*)title andUnits:(NSString*)units tag:(NSInteger)tag
{
    
    
    self.keyboardEntry = [NSMutableString stringWithString:currentValue];
    self.keyboardTag = tag;
    float startY = 100;
    float startX = (self.view.bounds.size.width-210)/2;
    
    self.keyboardTitleLabel = [[UILabel alloc] init];
    self.keyboardUnitsLabel = [[UILabel alloc] init];
    self.keyboardEntryLabel = [[UILabel alloc] init];
    
    self.keyboardTitleLabel.text = title;
    self.keyboardUnitsLabel.text = units;
    self.keyboardEntryLabel.text = self.keyboardEntry;
    
    self.keyboardTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.keyboardUnitsLabel.textAlignment = NSTextAlignmentCenter;
    self.keyboardEntryLabel.textAlignment = NSTextAlignmentRight;
    
    self.keyboardTitleLabel.frame = CGRectMake(startX, 0, 210, 40);
    self.keyboardUnitsLabel.frame = CGRectMake(startX, 40, 210, 20);
    self.keyboardEntryLabel.frame = CGRectMake(startX, 60, 210, 40);
    
    self.keyboardTitleLabel.font = [UIFont systemFontOfSize:24];
    self.keyboardUnitsLabel.font = [UIFont systemFontOfSize:18];
    self.keyboardEntryLabel.font = [UIFont systemFontOfSize:40];
    
    self.keyboardView = [[UIView alloc] init];
    self.keyboardView.backgroundColor = [UIColor lightGrayColor];
    
    self.keyboardTitleLabel.backgroundColor = [UIColor lightGrayColor];
    self.keyboardUnitsLabel.backgroundColor = [UIColor lightGrayColor];
    self.keyboardEntryLabel.backgroundColor = [UIColor whiteColor];
    
    self.keyboardTitleLabel.textColor = [UIColor blackColor];
    self.keyboardUnitsLabel.textColor = [UIColor blackColor];
    self.keyboardEntryLabel.textColor = [UIColor blackColor];
    
    [self.keyboardView addSubview:self.keyboardTitleLabel];
    [self.keyboardView addSubview:self.keyboardUnitsLabel];
    [self.keyboardView addSubview:self.keyboardEntryLabel];
    
    int i=1;
    for(int r = 0; r < 4; r++) {
        for(int c = 0; c < 3; c++) {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setBackgroundColor:[UIColor darkGrayColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            [button.layer setBorderWidth:1.0];
            [button.layer setCornerRadius:8.0f];
            [button.layer setMasksToBounds:YES];
            [button addTarget:self action:@selector(keyboardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            CGRect buttonRect = CGRectMake(startX+((c * 70)+2), startY + (r * 50)+2, 65, 46);
            button.frame = buttonRect;
            if (i==10)
            {
                [button setTitle:@"Done" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
                button.tag = 10;
                
            }
            else if (i==11)
            {
                [button setTitle:@"0" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:28];
                button.tag = 0;
                
            }
            else if (i==12)
            {
                [button setTitle:@"<" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:28];
                button.tag = 11;
                
            }
            else
            {
                [button setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:28];
            }
            
            [self.keyboardView addSubview:button];
            i++;
        }
        
    }
    
    [self addBorderAround:self.keyboardView cornerType:CornerTypeSquare withColor:[UIColor blackColor]];
    
    CGRect hideRect = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 300);
    CGRect showRect;
//    if (self.adBannerViewIsVisible)
//    {
//        showRect = CGRectMake(0, self.view.bounds.size.height-(300 + self.adBannerView.bounds.size.height), self.view.bounds.size.width, 300);
//    }
//    else
//    {
        showRect = CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300);
        
    //}
    self.keyboardView.frame = hideRect;
    [self.view addSubview:self.keyboardView];
    [self shrinkTable:200];
    [UIView animateWithDuration:0.3
                     animations:^
     {
         self.keyboardView.frame = showRect;
         
     }
                     completion:^(BOOL finished)
     {
         
     }];
    
}


- (void) keyboardButtonClicked:(UIButton*)button
{
    if (button.tag==10)
    {
        [self keyboardEntryUpdated:self.keyboardEntry tag:self.keyboardTag];
        [self removeNumberPad];
        
    }
    else if (button.tag==11)
    {
        if (self.keyboardEntry.length>0)
        {
            self.keyboardEntry = [NSMutableString stringWithString:[self.keyboardEntry substringToIndex:self.keyboardEntry.length-1]];
            self.keyboardEntryLabel.text = self.keyboardEntry;
        }
    }
    else
    {
        if ([self.keyboardEntry isEqualToString:@"0"])
        {
            self.keyboardEntry = [NSMutableString stringWithFormat:@"%li",(long)button.tag];
            self.keyboardEntryLabel.text = self.keyboardEntry;
        }
        else
        {
            [self.keyboardEntry appendString:[NSString stringWithFormat:@"%li",(long)button.tag]];
            self.keyboardEntryLabel.text = self.keyboardEntry;
        }
        
    }
    
    
}

- (void)keyboardEntryUpdated:(NSString*)entry forTag:(NSInteger)tag {}



-(void)removeNumberPad
{
    [self enlargeTable:200];
    
    CGRect hideRect = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200);
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         self.keyboardView.frame = hideRect;
         
     }
                     completion:^(BOOL finished)
     {
         [self.keyboardView removeFromSuperview];
     }];
    
}

#pragma mark - Borders

-(void)addBorderAround:(id)object cornerType:(NSInteger)corner withColor:(UIColor*)color
{
    
    if ([object isKindOfClass:[UIButton class]])
    {
        UIButton* thisObject = (UIButton*)object;
        [thisObject.layer setBorderColor:[color CGColor]];
        [thisObject.layer setBorderWidth:1.0];
        if (corner == CornerTypeRounded)
        {
            [thisObject.layer setCornerRadius:8.0f];
            [thisObject.layer setMasksToBounds:YES];
        }
        
    }
    else if ([object isKindOfClass:[UITextField class]])
    {
        UITextField* thisObject = (UITextField*)object;
        [thisObject.layer setBorderColor:[color CGColor]];
        [thisObject.layer setBorderWidth:1.0];
        if (corner == CornerTypeRounded)
        {
            [thisObject.layer setCornerRadius:8.0f];
            [thisObject.layer setMasksToBounds:YES];
        }
        
    }
    else if ([object isKindOfClass:[UITextView class]])
    {
        UITextView* thisObject = (UITextView*)object;
        [thisObject.layer setBorderColor:[color CGColor]];
        [thisObject.layer setBorderWidth:1.0];
        if (corner == CornerTypeRounded)
        {
            [thisObject.layer setCornerRadius:8.0f];
            [thisObject.layer setMasksToBounds:YES];
        }
        
    }
    else if ([object isKindOfClass:[UILabel class]])
    {
        UILabel* thisObject = (UILabel*)object;
        [thisObject.layer setBorderColor:[color CGColor]];
        [thisObject.layer setBorderWidth:1.0];
        if (corner == CornerTypeRounded)
        {
            [thisObject.layer setCornerRadius:8.0f];
            [thisObject.layer setMasksToBounds:YES];
        }
        
    }
    else if ([object isKindOfClass:[UIView class]])
    {
        UIView* thisObject = (UIView*)object;
        [thisObject.layer setBorderColor:[color CGColor]];
        [thisObject.layer setBorderWidth:1.0];
        if (corner == CornerTypeRounded)
        {
            [thisObject.layer setCornerRadius:8.0f];
            [thisObject.layer setMasksToBounds:YES];
        }
        
    }
}

-(void)removeBorderFrom:(id)object
{
    
    if ([object isKindOfClass:[UIButton class]])
    {
        UIButton* thisObject = (UIButton*)object;
        [thisObject.layer setBorderWidth:0.0];
        [thisObject.layer setCornerRadius:0.0f];
        [thisObject.layer setMasksToBounds:NO];
        
    }
    else if ([object isKindOfClass:[UITextField class]])
    {
        UITextField* thisObject = (UITextField*)object;
        [thisObject.layer setBorderWidth:0.0];
        [thisObject.layer setCornerRadius:0.0f];
        [thisObject.layer setMasksToBounds:NO];
        
    }
    else if ([object isKindOfClass:[UITextView class]])
    {
        UITextView* thisObject = (UITextView*)object;
        [thisObject.layer setBorderWidth:0.0];
        [thisObject.layer setCornerRadius:0.0f];
        [thisObject.layer setMasksToBounds:NO];
        
    }
    else if ([object isKindOfClass:[UILabel class]])
    {
        UILabel* thisObject = (UILabel*)object;
        [thisObject.layer setBorderWidth:0.0];
        [thisObject.layer setCornerRadius:0.0f];
        [thisObject.layer setMasksToBounds:NO];
        
    }
    else if ([object isKindOfClass:[UIView class]])
    {
        UIView* thisObject = (UIView*)object;
        [thisObject.layer setBorderWidth:0.0];
        [thisObject.layer setCornerRadius:0.0f];
        [thisObject.layer setMasksToBounds:NO];
        
    }
}


@end

