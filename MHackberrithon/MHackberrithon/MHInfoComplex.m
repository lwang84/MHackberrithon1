//
//  MHInfoComplex.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHInfoComplex.h"

@implementation MHInfoComplex

@synthesize original;

- (id)initWithFrame:(CGRect)frame MHBox: (MHBox *) box
{
    self = [super initWithFrame:frame];
    if (self) {
        original = box;
        [self addSubview:original];
        
        [original addTarget:self action:@selector(originalTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        //self.userInteractionEnabled = NO;

        // Initialization code
    }
    return self;
}

- (void) originalTapped: (UIButton *)original
{
    NSLog(@"original tapped");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
