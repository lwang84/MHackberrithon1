//
//  MHFacebookSearchView.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHFacebookSearchView.h"

@implementation MHFacebookSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        dismiss.backgroundColor = [UIColor blueColor];
        [self addSubview:dismiss];
        [dismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        // Initialization code
    }
    return self;
}

- (void)dismiss: (UIButton *)btn
{
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut;
    [UIView animateWithDuration:0.3 delay:0.0 options:options animations:^{
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
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
