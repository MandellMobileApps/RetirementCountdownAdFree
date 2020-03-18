//
//  ColorsViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "ColorsViewController.h"


//@property (nonatomic, retain) NSArray *backgroundImages;
//@property (nonatomic, retain) NSArray *textColors;

//@property (nonatomic, assign) NSInteger currentDaySelected;
//@property (nonatomic, assign) NSInteger currentColorRowSelected;
//@property (nonatomic, assign) NSInteger currentImageRowSelected;

@implementation ColorsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

	
    self.textColors = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Colors WHERE basic = 1"];
    self.backgroundImages = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Images WHERE Type = 1"];

    self.currentColorIndexSelected = [self textColorIndexForDay:self.currentDaySelected];
    self.currentImageNameSelected = [self imageNameForDay:self.currentDaySelected];
    
    [self refreshColorsForSampleButton];
    

    
}

-(void)refreshColorsForSampleButton
{

    
    // refreshes the sample button on top of page
    self.dayLabel.text = @"25";
    self.dayLabel.textColor = [GlobalMethods colorForIndex:self.currentColorIndexSelected];

    NSString* imageFullName = [GlobalMethods fullImageNameFor:self.currentImageNameSelected];
    UIImage *buttonBackground = [UIImage imageNamed:imageFullName];
    [self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [self.dayButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
    
}

                                                              
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // go to selected item in background tableview
    NSUInteger backgroundIndex = [self.backgroundImages indexOfObjectPassingTest:
            ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
            {
                return [[dict objectForKey:@"imageName"] isEqual:self.currentImageNameSelected];
            }
    ];

    NSIndexPath *tempIndexPath1 = [NSIndexPath indexPathForRow:backgroundIndex inSection:0];
    [self.tableViewButton scrollToRowAtIndexPath:tempIndexPath1 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    // go to selected item in textColor tableview
    NSString* colorIndexString = [NSString stringWithFormat:@"%li",self.currentColorIndexSelected];
    NSUInteger colorIndex = [self.textColors indexOfObjectPassingTest:
            ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
            {
                return [[dict objectForKey:@"id"] isEqual:colorIndexString];
            }
    ];

    NSIndexPath *tempIndexPath2 = [NSIndexPath indexPathForRow:colorIndex inSection:0];
    [self.tableViewLabel scrollToRowAtIndexPath:tempIndexPath2 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    NSString* imageProperty = [self propertyImageNameForRow:self.currentDaySelected];
    [self.appDelegate updateSettingsString:self.currentImageNameSelected forProperty:imageProperty];
 
    NSString* textColorProperty = [self propertyTextColorForRow:self.currentDaySelected];
    [self.appDelegate updateSettingsInteger:self.currentColorIndexSelected forProperty:textColorProperty];
    
    
    
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = self.backgroundColor;
	if ([tableView tag] == 100) {
    return self.backgroundImages.count;
	} else {
	return self.textColors.count;
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if ([tableView tag] == 100) {
		static NSString *CellIdentifier = @"CustomCellForColors";		
		CustomCellForColors *cell = (CustomCellForColors*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *cellobjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCellForColors" owner:nil options:nil];
			for (id currentObject in cellobjects){
				if([currentObject isKindOfClass:[UITableViewCell class]]){
					cell = (CustomCellForColors *) currentObject;
				}
			}
		}

         NSDictionary* imageDict = [self.backgroundImages objectAtIndex:indexPath.row];
        NSString* imageName = [imageDict objectForKey:@"imageName"];
         NSString* imageFullName = [GlobalMethods fullImageNameFor:imageName];
        UIImage *buttonBackground = [UIImage imageNamed:imageFullName];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
		[cell.colorButton setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];
		cell.accessoryType = UITableViewCellAccessoryNone;
        

		if ([self.currentImageNameSelected isEqualToString:imageName]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}

    return cell;
	
	} else {

		static NSString *CellIdentifier = @"Cell2";
		UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell2 == nil) {
			cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.textLabel.text = @"25";
        NSDictionary* colorDict = [self.textColors objectAtIndex:indexPath.row];
        NSInteger colorIndex = [[colorDict objectForKey:@"id"] integerValue];
        cell2.textLabel.textColor = [GlobalMethods colorForIndex:colorIndex];
        
        NSInteger backgroundColorIndex = 1;
        if (colorIndex == 1)
        {
            backgroundColorIndex = 0;
        }
        cell2.textLabel.backgroundColor = [GlobalMethods colorForIndex:backgroundColorIndex];
        

        if (self.currentColorIndexSelected == colorIndex) {
			cell2.accessoryType = UITableViewCellAccessoryCheckmark;
		}


		return cell2;
	}	
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if ([tableView tag] == 100)
    {
        
        NSDictionary* imageDict = [self.backgroundImages objectAtIndex:indexPath.row];
        NSString* imageName = [imageDict objectForKey:@"imageName"];
        self.currentImageNameSelected = imageName;
	}
    else
    {
        NSDictionary* colorDict = [self.textColors objectAtIndex:indexPath.row];
        NSInteger colorIndex = [[colorDict objectForKey:@"id"]integerValue];
        self.currentColorIndexSelected = colorIndex;
	}
    self.appDelegate.colorsChanged = YES;
    [self refreshColorsForSampleButton];
	[tableView reloadData];
    self.appDelegate.settingsChanged = YES;
}


-(NSString*)imageNameForDay:(NSInteger)row
{
    NSString* name;
    switch (row) {
        case 0:
            name = self.appDelegate.settingsNew.imageNameToday;
        break;
        case 1:
            name = self.appDelegate.settingsNew.imageNameRetirement;
            break;
        case 2:
            name = self.appDelegate.settingsNew.imageNameWorkdays;
        break;
        case 3:
            name = self.appDelegate.settingsNew.imageNameNonWorkdays;
        break;
        case 4:
            name = self.appDelegate.settingsNew.imageNameHoliday;
        break;
        case 5:
            name = self.appDelegate.settingsNew.imageNameManualWorkdays;
        break;
        case 6:
            name = self.appDelegate.settingsNew.imageNameManualNonWorkdays;
        break;
            
        default:
            break;
    }
    return name;
    
    
    
}



              
-(NSInteger)textColorIndexForDay:(NSInteger)row
{
  NSInteger name;
  switch (row) {
      case 0:
          name = self.appDelegate.settingsNew.textColorIndexToday;
      break;
      case 1:
          name = self.appDelegate.settingsNew.textColorIndexRetirement;
          break;
      case 2:
          name = self.appDelegate.settingsNew.textColorIndexWorkdays;
      break;
      case 3:
          name = self.appDelegate.settingsNew.textColorIndexNonWorkdays;
      break;
      case 4:
          name = self.appDelegate.settingsNew.textColorIndexHoliday;
      break;
      case 5:
          name = self.appDelegate.settingsNew.textColorIndexManualWorkdays;
      break;
      case 6:
          name = self.appDelegate.settingsNew.textColorIndexManualNonWorkdays;
      break;
      default:
          name = 0;
          break;
  }
  return name;
  
  
  
}


-(UIColor*)textColorForDay:(NSInteger)row
{
    UIColor* name;
    switch (row) {
        case 0:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexToday];
        break;
        case 1:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexRetirement];
            break;
        case 2:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexWorkdays];
        break;
        case 3:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexNonWorkdays];
        break;
        case 4:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexHoliday];
        break;
        case 5:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexManualWorkdays];
        break;
        case 6:
            name = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndexManualNonWorkdays];
        break;
        default:

            break;
    }
    return name;
    
    
    
}

-(NSString*)propertyImageNameForRow:(NSInteger)row
{
    NSString* name;
    switch (row) {
        case 0:
            name = @"imageNameToday";
        break;
        case 1:
            name = @"imageNameRetirement";
            break;
        case 2:
            name = @"imageNameWorkdays";
        break;
        case 3:
            name = @"imageNameNonWorkdays";
        break;
        case 4:
            name = @"imageNameHoliday";
        break;
        case 5:
            name = @"imageNameManualWorkdays";
        break;
        case 6:
            name = @"imageNameManualNonWorkdays";
        break;
            
        default:
            break;
    }
    return name;
    
    
    
}

-(NSString*)propertyTextColorForRow:(NSInteger)row
{
    NSString* name;
    switch (row) {
        case 0:
            name = @"textColorIndexToday";
        break;
        case 1:
            name = @"textColorIndexRetirement";
            break;
        case 2:
            name = @"textColorIndexWorkdays";
        break;
        case 3:
            name = @"textColorIndexNonWorkdays";
        break;
        case 4:
            name =@"textColorIndexHoliday";
        break;
        case 5:
            name =@"textColorIndexManualWorkdays";
        break;
        case 6:
            name = @"textColorIndexManualNonWorkdays";
        break;
            
        default:
            break;
    }
    return name;
    
    
    
}
@end

