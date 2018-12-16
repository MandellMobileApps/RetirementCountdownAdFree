//
//  CustomCellForColors.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/22/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "CustomCellForColors.h"


@implementation CustomCellForColors

@synthesize colorButton;

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
	[colorButton release];
	[super dealloc];
}


@end
