//
//  ScanButton.m
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import "MHTypeIndicator.h"


@implementation MHTypeIndicator

- (id)initWithFrame:(CGRect)frame imageName: (NSString *) img{
	if (self = [super initWithFrame:frame]) {
		// Set button image:
		UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		buttonImage.image = [UIImage imageNamed:img]; //@"scanbutton.png"];
		
		[self addSubview:buttonImage];
		
	}
	return self;
}

- (void)buttonPressed {
	// TODO: Could toggle a button state and/or image
}


@end
