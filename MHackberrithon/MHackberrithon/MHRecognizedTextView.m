//
//  MHRecognizedTextView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHRecognizedTextView.h"

@implementation MHRecognizedTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFont: [ UIFont systemFontOfSize: 23 ]];
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        //[self setTextColor:[UIColor blackColor]];

        // Initialization code
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

@end
