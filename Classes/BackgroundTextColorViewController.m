//
//  BackgroundTextColorViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "BackgroundTextColorViewController.h"


@implementation BackgroundTextColorViewController

@synthesize backgroundColorName;
@synthesize backgroundTextColorName;
@synthesize backgroundColorIndex;
@synthesize backgroundTextColorIndex;
@synthesize currentObject;
@synthesize upperLine;
@synthesize lowerLine;
@synthesize backgroundTextColorTable;
@synthesize currentRow;
@synthesize currentIndexPathRow;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
 self.backgroundColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Background"] intValue];
 self.backgroundTextColorIndex = [[self.appDelegate.colorSettings objectForKey:@"Text"] intValue];
 self.backgroundColorName = [self.appDelegate.backgroundColors objectAtIndex:7];
 self.backgroundTextColorName = [self.appDelegate.textColors objectAtIndex:7];
 self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
 self.upperLine.text = self.backgroundTextColorName;
 self.lowerLine.text = [@"on " stringByAppendingString:self.backgroundColorName];
 self.upperLine.textColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundTextColorName)];
 self.lowerLine.textColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundTextColorName)];
 self.upperLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundColorName)];
 self.lowerLine.backgroundColor = [ColorsClass performSelector:NSSelectorFromString(self.backgroundColorName)];
 
 	self.upperLine.font = [UIFont boldSystemFontOfSize:24];
	self.lowerLine.font = [UIFont boldSystemFontOfSize:24];
 
 [self.backgroundTextColorTable reloadData];
 
 // go to selected item in background tableview
 NSIndexPath *tempIndexPath1 = [NSIndexPath indexPathForRow:self.backgroundTextColorIndex inSection:0];
 [self.backgroundTextColorTable scrollToRowAtIndexPath:tempIndexPath1 atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

 
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
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return [ColorsClass getCountForPredefinedColorNames]-1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
//	if (self.currentRow > indexPath.row) {
//		 self.currentRow = indexPath.row;
//	}
   
	self.currentIndexPathRow = indexPath.row;
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18]; 
		cell.textLabel.adjustsFontSizeToFitWidth = YES; 
		cell.textLabel.minimumFontSize=10;
	}
    NSString *tempLabelText = [[NSString alloc] initWithString:[ColorsClass getPredefinedColorNameFor:indexPath.row + 1]];
	UIColor *tempLabelColor = [ColorsClass performSelector:NSSelectorFromString(tempLabelText)]; 
	cell.textLabel.text = tempLabelText; 
	cell.textLabel.textColor = tempLabelColor;
	if (indexPath.row < 200) {
		cell.textLabel.shadowColor = [UIColor blackColor];
	} else {
		cell.textLabel.shadowColor = nil;
	}

	cell.accessoryType = UITableViewCellAccessoryNone;
	if ([self.backgroundTextColorName isEqualToString:tempLabelText]) {
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
	NSString *tempTextColorName = [ColorsClass getPredefinedColorNameFor:indexPath.row+1];
	[self.appDelegate.textColors replaceObjectAtIndex:7 withObject:tempTextColorName];
	[self.appDelegate.colorSettings setObject:[NSNumber numberWithInt:indexPath.row+1] forKey:@"Text"];
	self.upperLine.textColor = [ColorsClass performSelector:NSSelectorFromString(tempTextColorName)];
	self.lowerLine.textColor = [ColorsClass performSelector:NSSelectorFromString(tempTextColorName)];
	self.upperLine.text = tempTextColorName;
	self.backgroundTextColorName = tempTextColorName;
	[tableView reloadData];
	self.appDelegate.colorsChanged = YES;
}

- (void)dealloc {

	[backgroundColorName release];
	[backgroundTextColorName release];
	[currentObject release];
	[upperLine release];
	[lowerLine release];
	[backgroundTextColorTable release];
	[timer release];

    [super dealloc];
}


@end

