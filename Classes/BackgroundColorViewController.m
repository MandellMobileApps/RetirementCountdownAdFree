//
//  BackgroundColorViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/11/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "BackgroundColorViewController.h"

@implementation BackgroundColorViewController
@synthesize backgroundColorName;
@synthesize backgroundTextColorName;
@synthesize backgroundColorIndex;
@synthesize backgroundTextColorIndex;
@synthesize currentObject;
@synthesize upperLine;
@synthesize lowerLine;
@synthesize backgroundColorTable;
@synthesize currentRow;
@synthesize currentIndexPathRow;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
 self.backgroundColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Background"] intValue];
 self.backgroundTextColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Text"] intValue];
 self.backgroundColorName = [self.appDelegate.backgroundColors objectAtIndex:7];
 self.backgroundTextColorName = [self.appDelegate.textColors objectAtIndex:7];
 
 self.upperLine.text = self.backgroundTextColorName;
 self.lowerLine.text = [@"on " stringByAppendingString:self.backgroundColorName];
 self.upperLine.textColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundTextColorName)];
 self.lowerLine.textColor = self.upperLine.textColor;
 self.upperLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundColorName)];
 self.lowerLine.backgroundColor = self.upperLine.backgroundColor;

	self.upperLine.font = [UIFont boldSystemFontOfSize:24];
	self.lowerLine.font = [UIFont boldSystemFontOfSize:24];

	[self.backgroundColorTable reloadData];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	// go to selected item in background tableview
	NSIndexPath *tempIndexPath1 = [NSIndexPath indexPathForRow:self.backgroundColorIndex inSection:0];
	[self.backgroundColorTable scrollToRowAtIndexPath:tempIndexPath1 atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

	 
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
	[self.backgroundColorTable scrollToRowAtIndexPath:tempIndexPathUp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


-(IBAction) startFastScrollDown {
	self.currentRow = self.currentIndexPathRow;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scrollDown) userInfo:nil repeats:YES];
}

-(IBAction) stopFastScrollDown {
	[self.timer invalidate];
}

-(void) scrollDown {
	if (self.currentRow <  ([ColorsClass getCountForPredefinedColorNames]-1)) {
		self.currentRow = self.currentRow+1;
	} else {
		self.currentRow = [ColorsClass getCountForPredefinedColorNames]-1;
	}
	NSIndexPath *tempIndexPathUp = [NSIndexPath indexPathForRow:self.currentRow inSection:0];
	[self.backgroundColorTable scrollToRowAtIndexPath:tempIndexPathUp atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return [ColorsClass getCountForPredefinedColorNames];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPathRow = indexPath.row;
	
    static NSString *CellIdentifier = @"Cell";
    UILabel *mainLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		mainLabel = [[[UILabel alloc] initWithFrame:CGRectMake(2.0, 2.0, 260.0, 40.0)] autorelease];
		mainLabel.adjustsFontSizeToFitWidth = YES; 
		mainLabel.minimumFontSize=10;
		mainLabel.opaque = YES;
		mainLabel.tag = 1; 
		mainLabel.font = [UIFont boldSystemFontOfSize:18]; 
		mainLabel.textAlignment = UITextAlignmentCenter; 
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		mainLabel.font = [UIFont boldSystemFontOfSize:18]; 
		mainLabel.adjustsFontSizeToFitWidth = YES; 
		mainLabel.minimumFontSize=10;
		[cell.contentView addSubview:mainLabel]; 
    } else {
		mainLabel = (UILabel *)[cell.contentView viewWithTag:1]; 
	}
    
	NSString *tempLabelText = [[NSString alloc] initWithString:[ColorsClass getPredefinedColorNameFor:indexPath.row]];
	UIColor *tempLabelColor = [ColorsClass performSelector:NSSelectorFromString(tempLabelText)]; 
	mainLabel.backgroundColor = tempLabelColor;
	mainLabel.text = tempLabelText; 
	
	if (indexPath.row < 350) {
		mainLabel.textColor = [UIColor blackColor];
	} else {
		mainLabel.textColor = [UIColor whiteColor];
	}
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	if ([self.backgroundColorName isEqualToString:tempLabelText]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}	
	
	[tempLabelText release];
	
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];

	NSString *tempBackgroundColorName = [ColorsClass getPredefinedColorNameFor:indexPath.row];
	[self.appDelegate.backgroundColors replaceObjectAtIndex:7 withObject:tempBackgroundColorName];
	[self.appDelegate.colorSettings setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"Background"];
	self.lowerLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(tempBackgroundColorName)];
	self.upperLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(tempBackgroundColorName)];
	self.lowerLine.text = [@"on " stringByAppendingString:tempBackgroundColorName];
	self.backgroundColorName = tempBackgroundColorName;
	[tableView reloadData];
	self.appDelegate.colorsChanged = YES;
}


- (void)dealloc {
	[backgroundColorName release];
	[backgroundTextColorName release];
	[currentObject release];
	[upperLine release];
	[lowerLine release];
	[backgroundColorTable release];
    [super dealloc];
}


@end

