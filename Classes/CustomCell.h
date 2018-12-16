//
//  CustomCell.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {

	IBOutlet	UILabel *mainLabel;
	IBOutlet	UIButton *colorButton;
	IBOutlet	UILabel *dayLabel;


}

@property (nonatomic, retain) IBOutlet UILabel *mainLabel;
@property (nonatomic, retain) IBOutlet UIButton *colorButton;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;





@end
