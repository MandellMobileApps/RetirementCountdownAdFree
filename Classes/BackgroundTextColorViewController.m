//
//  BackgroundTextColorViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "BackgroundTextColorViewController.h"
//#import "RetirementCountdownAppDelegate.h"


@implementation BackgroundTextColorViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//
//    CGRect thisFrame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60);
//    self.backgroundTextColorTable.frame = thisFrame;
    self.upperLine.font = [UIFont boldSystemFontOfSize:24];
    self.lowerLine.font = [UIFont boldSystemFontOfSize:24];
self.backgroundTextColorTable.backgroundColor = [UIColor lightGrayColor];
    self.colors = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Colors"];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshColors];
    
    NSString* indexString = [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.textColorIndex];
    NSUInteger index = [self.colors indexOfObjectPassingTest:
            ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
            {
                return [[dict objectForKey:@"id"] isEqual:indexString];
            }
    ];
    
    // go to selected item in background tableview
    NSIndexPath *tempIndexPath1 = [NSIndexPath indexPathForRow:index inSection:0];
    [self.backgroundTextColorTable scrollToRowAtIndexPath:tempIndexPath1 atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
}

-(void)refreshColors
{
    self.backgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];
    self.textColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndex];
    
    NSString* backgroundColorSql = [NSString stringWithFormat:@"SELECT * FROM Colors WHERE id=%li",self.appDelegate.settingsNew.backgroundColorIndex];
    NSDictionary* backgroundColorDict = [SQLiteAccess selectOneRowWithSQL:backgroundColorSql];
 
    NSString* textColorSql = [NSString stringWithFormat:@"SELECT * FROM Colors WHERE id=%li",self.appDelegate.settingsNew.textColorIndex];
    NSDictionary* textColorDict = [SQLiteAccess selectOneRowWithSQL:textColorSql];
    
    self.view.backgroundColor = self.backgroundColor ;
    self.lowerLine.backgroundColor = self.backgroundColor ;
    self.upperLine.backgroundColor = self.backgroundColor ;
    self.lowerLine.textColor = self.textColor;
    self.upperLine.textColor = self.textColor;
    self.upperLine.text = [textColorDict objectForKey:@"name"];
    self.lowerLine.text = [NSString stringWithFormat:@"on %@",[backgroundColorDict objectForKey:@"name"]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction) startFastScrollUp {
    self.currentRow = self.currentIndexPathRow;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scrollUp) userInfo:nil repeats:YES];
}

-(IBAction) stopFastScrollUp {
    [self.timer invalidate];
}

-(void) scrollUp {
    if (self.currentRow > 1) {
        self.currentRow = self.currentRow-1;
    } else {
        self.currentRow = 0;
    }
    NSIndexPath *tempIndexPathUp = [NSIndexPath indexPathForRow:self.currentRow inSection:0];
    [self.backgroundTextColorTable scrollToRowAtIndexPath:tempIndexPathUp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


-(IBAction) startFastScrollDown {
    self.currentRow = self.currentIndexPathRow;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scrollDown) userInfo:nil repeats:YES];
}

-(IBAction) stopFastScrollDown {
    [self.timer invalidate];
}

-(void) scrollDown {
    if (self.currentRow <  ([ColorsClass getCountForPredefinedColorNames] - 2)) {
        self.currentRow = self.currentRow+1;
    } else {
        self.currentRow = [ColorsClass getCountForPredefinedColorNames] - 2;
    }
    NSIndexPath *tempIndexPathUp = [NSIndexPath indexPathForRow:self.currentRow inSection:0];
    [self.backgroundTextColorTable scrollToRowAtIndexPath:tempIndexPathUp atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    self.currentIndexPathRow = indexPath.row;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
//        cell.textLabel.adjustsFontSizeToFitWidth = YES;
//        cell.textLabel.minimumScaleFactor=0.6;
    }
    
    NSDictionary* textColorsDict = [self.colors objectAtIndex:indexPath.row];
    cell.textLabel.text = [textColorsDict objectForKey:@"name"];
    NSInteger textColorId = [[textColorsDict objectForKey:@"id"] integerValue];
    cell.textLabel.textColor = [GlobalMethods colorForIndex:textColorId];

    
    if (self.appDelegate.settingsNew.textColorIndex == textColorId) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 
        cell.backgroundColor = [UIColor lightGrayColor];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
     NSDictionary* textColorsDict = [self.colors objectAtIndex:indexPath.row];
    NSInteger textColorId = [[textColorsDict objectForKey:@"id"] integerValue];
    
    [self.appDelegate updateSettingsInteger:textColorId forProperty:@"textColorIndex"];

    [self refreshColors];

    [tableView reloadData];
    
    self.appDelegate.settingsChanged = YES;
     self.appDelegate.colorsChanged = YES;
}



@end

