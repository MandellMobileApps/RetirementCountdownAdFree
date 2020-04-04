//
//  HolidaysViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "HolidaysViewController.h"



@implementation HolidaysViewController


- (void)viewDidLoad {
    [super viewDidLoad];

	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;

	self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self refreshHolidayList];

}

-(void)refreshHolidayList
{
    self.holidayListStandard = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Holidays WHERE isCustom = 0"];
    
     self.holidayListCustom = [NSMutableArray arrayWithArray:[SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Holidays WHERE isCustom = 1"]];
    
    [self.holidayTableView reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.holidayTableView setEditing:editing animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	 if (indexPath.section == 0)
     {
         if (indexPath.row != 0)
         {
             return UITableViewCellEditingStyleDelete;
         }
     }
    return UITableViewCellEditingStyleNone;
   

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row != 0)
        {
               // delete from sqlite
                NSDictionary* this = [self.holidayListCustom objectAtIndex:indexPath.row-1];
                NSString* sql = [NSString stringWithFormat:@"DELETE FROM Holidays WHERE id = %@",[this objectForKey:@"id"]];
                [SQLiteAccess deleteWithSQL:sql];
            
                // delete from array
                [self.holidayListCustom removeObjectAtIndex:indexPath.row-1];
                
                // delete from tableview
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];

        }
    }
}

- (void)tableView:(UITableView *)tableView
                   didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
 

    
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section;
{
     return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{

    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 300, 22)];
     if (section == 0)
    {
     
      label1.text = @"Custom Holidays";
    }
    else
    {
           label1.text = @"Holidays";
  

    }
    [headerView addSubview:label1];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return self.holidayListCustom.count+1;
    }
    return [self.holidayListStandard count];


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.detailTextLabel.textColor = [UIColor redColor];
	}

    if (indexPath.section == 1)
    {
        NSDictionary *holiday = [self.holidayListStandard objectAtIndex:indexPath.row];
        cell.textLabel.text = [holiday objectForKey:@"name"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([[holiday objectForKey:@"selected"] integerValue])
        {
            cell.imageView.image = [UIImage imageNamed:@"checkbox_checked_gray.png"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"checkbox_unchecked_gray.png"];
        }
 
    }
   if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Add New Holiday";
            cell.textLabel.textColor = [UIColor blueColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.imageView.image = nil;
            
        }
        else
        {
            NSDictionary *holiday = [self.holidayListCustom objectAtIndex:indexPath.row-1];
            cell.textLabel.text = [holiday objectForKey:@"name"];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = @"";
            if ([[holiday objectForKey:@"selected"] integerValue])
            {
                cell.imageView.image = [UIImage imageNamed:@"checkbox_checked_gray.png"];
            }
            else
            {
                cell.imageView.image = [UIImage imageNamed:@"checkbox_unchecked_gray.png"];
            }
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
        AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
        addHolidayViewController.title = @"Add Holiday";
        addHolidayViewController.newHoliday = YES;
         addHolidayViewController.holidaysViewController = self;
        [[self navigationController] pushViewController:addHolidayViewController animated:YES];
        }
        else
        {
            AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
            addHolidayViewController.title = @"Edit Holiday";
            addHolidayViewController.newHoliday = NO;
            addHolidayViewController.holiday = [self.holidayListCustom objectAtIndex:indexPath.row-1];;
             addHolidayViewController.holidaysViewController = self;
            [[self navigationController] pushViewController:addHolidayViewController animated:YES];
            
        }
    }

     self.appDelegate.settingsChanged = YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
        
            AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
            addHolidayViewController.title = @"Add Holiday";
            addHolidayViewController.newHoliday = YES;
            addHolidayViewController.holidaysViewController = self;
            [[self navigationController] pushViewController:addHolidayViewController animated:YES];
        }
        else
        {
            
            NSMutableDictionary *holiday = [NSMutableDictionary dictionaryWithDictionary:[self.holidayListCustom objectAtIndex:indexPath.row-1]];

            if ([[holiday objectForKey:@"selected"] integerValue]) {
                [holiday setValue:@"0" forKey:@"selected"];
            } else {
                 [holiday setValue:@"1" forKey:@"selected"];
            }
            NSString *sql = [NSString stringWithFormat:@"UPDATE Holidays Set selected = %@ WHERE id = %@",[holiday objectForKey:@"selected"],[holiday objectForKey:@"id"]];
            [SQLiteAccess updateWithSQL:sql];

             [self refreshHolidayList];
            
        }
        
    }
    else if (indexPath.section == 1)
    {
	
        NSMutableDictionary *holiday = [NSMutableDictionary dictionaryWithDictionary:[self.holidayListStandard objectAtIndex:indexPath.row]];
       
        if ([[holiday objectForKey:@"selected"] integerValue]) {
            [holiday setValue:@"0" forKey:@"selected"];
        } else {
             [holiday setValue:@"1" forKey:@"selected"];
        }
        NSString *sql = [NSString stringWithFormat:@"UPDATE Holidays Set selected = %@ WHERE id = %@",[holiday objectForKey:@"selected"],[holiday objectForKey:@"id"]];
        [SQLiteAccess updateWithSQL:sql];
         
         [self refreshHolidayList];

    }
    self.appDelegate.settingsChanged = YES;
}



@end

