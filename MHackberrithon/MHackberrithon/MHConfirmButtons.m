//
//  MHConfirmButtons.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHConfirmButtons.h"

@implementation MHConfirmButtons

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor blackColor];
        UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		buttonImage.image = [UIImage imageNamed:@"check"];
		
		[self addSubview:buttonImage];
        // Initialization code
        
        [self addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)tapped: (UIButton *) btn
{
    NSLog(@"%@", @"confirm");
    [self.superview endEditing:TRUE];
}

@end
