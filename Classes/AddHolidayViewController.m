//
//  AddHolidayViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "AddHolidayViewController.h"
#import "HolidaysViewController.h"


@implementation AddHolidayViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.changeMade = NO;
	self.holidayNameTextField.delegate = self;
	UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
	self.navigationItem.rightBarButtonItem = cancelBarItem;

	
	UIBarButtonItem *saveBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAndReturnToHolidayList)];
	self.navigationItem.leftBarButtonItem = saveBarItem;
	
//	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//	self.navigationItem.backBarButtonItem = backBarItem;

    if (self.newHoliday)
    {
        self.holiday = [NSMutableDictionary dictionaryWithObjects:
                        [NSArray arrayWithObjects:
                         @"0",
                         @"0",
                         @"",
                         @"0",
                         @"0",
                         @"0",
                         @"1",
                         nil]
                         forKeys:
                        [NSArray arrayWithObjects:
                         @"day",
                         @"month",
                         @"name",
                         @"ordinalweekday",
                         @"selected",
                         @"weekday",
                         @"isCustom",
                         nil]
                        ];
    }
    
    
    self.holidayNameTextField.text = [self.holiday objectForKey:@"name"];
    
//    if ([[self.holiday objectForKey:@"deleteok"]integerValue] == 0) {
//        self.holidayNameTextField.userInteractionEnabled = NO;
//        self.holidayNameTextField.backgroundColor = self.backgroundColor;
//
//    } else {
//        self.holidayNameTextField.userInteractionEnabled = YES;
//        self.holidayNameTextField.backgroundColor = [UIColor whiteColor];
//    }
    
    if ([[self.holiday objectForKey:@"day"]integerValue] > 0) {
        self.holidayTypeSegmentControl.selectedSegmentIndex = 0;
    } else {
        self.holidayTypeSegmentControl.selectedSegmentIndex = 1;
    }

}

-(void) cancelEdit {
    if (self.changeMade)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have made changes!\nAre you sure you want to cancel?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
        alertView.tag = 10;
        [alertView show];
        
    }
    else
    {
        [self.navigationController  popViewControllerAnimated:YES];
    }
	

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.holidayTypeTableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

    if ((buttonIndex == 0) && (alertView.tag == 10))
    {
        [self.navigationController  popViewControllerAnimated:YES];
        
    }
    [alertView dismissWithClickedButtonIndex:0 animated:YES];

}


-(void)saveAndReturnToHolidayList {
    [self.holidayNameTextField resignFirstResponder];
    BOOL validData = [self validateData];
	if (validData == YES)
    {
        if (self.newHoliday)
        {
            [self.appDelegate insertIntoTable:@"Holidays" forDictionary:self.holiday];
        }
        else
        {
            [self.appDelegate updateTable:@"Holidays" forDictionary:self.holiday];
            
        }
		self.appDelegate.settingsChanged = YES;
        [self.holidaysViewController refreshHolidayList];
		[self.navigationController popViewControllerAnimated:YES];
	}

}

-(BOOL)validateData {

    BOOL validData = NO;
    
	if (self.holidayTypeSegmentControl.selectedSegmentIndex == 0) {
        
        if ((([[self.holiday objectForKey:@"day"] integerValue] > 0) && ([[self.holiday objectForKey:@"month"] integerValue]> 0)) && ([[self.holiday objectForKey:@"name"] length] > 0)) {
            validData = YES;
            [self.holiday setObject:@"0" forKey:@"weekday"];
            [self.holiday setObject:@"0" forKey:@"ordinalweekday"];

		} else {

			validData = NO;
		}
	} else {
        if ((([[self.holiday objectForKey:@"weekday"] integerValue] > 0) && ([[self.holiday objectForKey:@"ordinalweekday"] integerValue]> 0)) && ([[self.holiday objectForKey:@"month"] integerValue] > 0 && ([[self.holiday objectForKey:@"name"] length] > 0))) {
			validData = YES;
            [self.holiday setObject:@"0" forKey:@"day"];
		} else {
			
			validData = NO;
		}
	}
	if (validData == NO)
    {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Holiday Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];

	}
	return validData;

}


- (IBAction)segmentAction:(id)sender
{
//	self.holidayType = [sender selectedSegmentIndex];
    self.changeMade = YES;
	[self.holidayTypeTableView reloadData];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.changeMade = YES;
    [self.holiday setValue:textField.text forKey:@"name"];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
			[self.holidayNameTextField resignFirstResponder];
			return YES;
}

- (IBAction)backgroundClick:(id)sender {
	[self.holidayNameTextField resignFirstResponder];

}

- (IBAction) changeHolidayName {
	
	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	tableView.backgroundColor = self.backgroundColor;
    NSInteger r = 0;
	if (self.holidayTypeSegmentControl.selectedSegmentIndex == 0) {
		r = 2;
	} else {
		r = 3;
	}
	return r;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if (self.holidayTypeSegmentControl.selectedSegmentIndex == 0)
    {
		if (indexPath.row == 0)
        {
			cell.textLabel.text = @"Month";
				if ([[self.holiday objectForKey:@"month"]integerValue]> 0) {
					cell.detailTextLabel.text = [GlobalMethods nameOfMonthForInt:[[self.holiday objectForKey:@"month"]integerValue]];
				} else {
					cell.detailTextLabel.text = @"Enter";
				}
			}
		if (indexPath.row == 1)
        {
			cell.textLabel.text = @"Day of the Month";
            if ([[self.holiday objectForKey:@"day"]integerValue]> 0) {
                cell.detailTextLabel.text = [self.holiday objectForKey:@"day"];
            } else {
                cell.detailTextLabel.text = @"Enter";
            }
		}
	}
	if (self.holidayTypeSegmentControl.selectedSegmentIndex== 1)
    {
		if (indexPath.row == 0)
        {
			cell.textLabel.text = @"Month";
                if ([[self.holiday objectForKey:@"month"]integerValue]> 0) {
                    cell.detailTextLabel.text =[GlobalMethods nameOfMonthForInt:[[self.holiday objectForKey:@"month"]integerValue]];
                } else {
                    cell.detailTextLabel.text = @"Enter";
                }
		}
		if (indexPath.row == 1)
        {
			cell.textLabel.text = @"Week of the Month";
              if ([[self.holiday objectForKey:@"ordinalweekday"]integerValue]> 0) {
                    cell.detailTextLabel.text = [self.holiday objectForKey:@"ordinalweekday"];
                } else {
                    cell.detailTextLabel.text = @"Enter";
                }
		}
		if (indexPath.row == 2)
        {
			cell.textLabel.text = @"Day of the Week";
              if ([[self.holiday objectForKey:@"weekday"]integerValue]> 0)
              {
                    cell.detailTextLabel.text = [GlobalMethods dayTextForDayofWeek:[[self.holiday objectForKey:@"weekday"]integerValue]];
                } else
                {
                    cell.detailTextLabel.text = @"Enter";
                }
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
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	[self.holidayNameTextField resignFirstResponder];
	self.changeMade = YES;
	SelectHolidayDateViewController *selectHolidayDateViewController = [[SelectHolidayDateViewController alloc] initWithNibName:@"SelectHolidayDateViewController" bundle:nil];
    selectHolidayDateViewController.holiday = [NSMutableDictionary dictionaryWithDictionary:self.holiday];
    selectHolidayDateViewController.addHolidayViewController = self;
	BOOL validSelection = YES;
	if (self.holidayTypeSegmentControl.selectedSegmentIndex == 0) {
		if (indexPath.row == 0) {
			selectHolidayDateViewController.tableToLookup = @"Month";
			selectHolidayDateViewController.title = @"Month";
		}
		if (indexPath.row == 1) {
			selectHolidayDateViewController.tableToLookup = @"Day of the Month";
			selectHolidayDateViewController.title = @"Day of the Month";
			if ([[self.holiday objectForKey:@"month"]integerValue] == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];

			}
		}
	}
	if (self.holidayTypeSegmentControl.selectedSegmentIndex == 1) {
		if (indexPath.row == 0) {
			selectHolidayDateViewController.tableToLookup = @"Month";
			selectHolidayDateViewController.title = @"Month";
		}
		if (indexPath.row == 1) {
			selectHolidayDateViewController.tableToLookup = @"Week of the Month";
			selectHolidayDateViewController.title = @"Week of the Month";
			if ([[self.holiday objectForKey:@"month"]integerValue] == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];

			}
		}
		if (indexPath.row == 2) {
			selectHolidayDateViewController.tableToLookup = @"Day of the Week";
			selectHolidayDateViewController.title = @"Day of the Week";
			if ([[self.holiday objectForKey:@"month"]integerValue] == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];

			}
		}
	}
	if (validSelection == YES) {
		[[self navigationController] pushViewController:selectHolidayDateViewController animated:YES];

	}
	
}







@end
