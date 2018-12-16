//
//  CustomCell.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize mainLabel, colorButton, dayLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)dealloc {
	[mainLabel release];
	[colorButton release];
	[dayLabel release];
	[super dealloc];
}


@end
