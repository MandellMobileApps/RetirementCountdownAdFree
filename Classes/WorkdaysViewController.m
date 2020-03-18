//
//  Workdays.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "WorkdaysViewController.h"


@implementation WorkdaysViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allworkdays = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Workdays"];

    
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
    NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"WorkdaysScreenCapture"];
    [imageinpng writeToFile:pathName atomically:YES];
    NSData *returnData = [[NSData alloc] initWithData:imageinpng];
    return returnData;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    tableView.accessibilityIgnoresInvertColors = YES;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = self.backgroundColor;
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary* thisDay = [self.allworkdays objectAtIndex:indexPath.row];
    cell.textLabel.text = [thisDay objectForKey:@"name"];
    NSInteger selected = [[thisDay objectForKey:@"workday"] integerValue];
	if (selected == 1) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark; 
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundView.accessibilityIgnoresInvertColors = YES;
	//cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* thisDay = [self.allworkdays objectAtIndex:indexPath.row];
    NSInteger selected = [[thisDay objectForKey:@"workday"] integerValue];
    if (selected == 1)
    {
        NSString *sql = [NSString stringWithFormat:@"UPDATE Workdays Set workday = 0 WHERE id = %li ",indexPath.row+1];
         [SQLiteAccess updateWithSQL:sql];
        
        
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"UPDATE Workdays Set workday = 1 WHERE id = %li ",indexPath.row+1];
         [SQLiteAccess updateWithSQL:sql];
        
    }
    self.allworkdays = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Workdays"];
	[tableView reloadData];
	self.appDelegate.settingsChanged = YES;
}




@end

