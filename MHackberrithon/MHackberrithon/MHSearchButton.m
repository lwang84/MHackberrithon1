//
//  MHSearchButton.m
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHSearchButton.h"
#import <QuartzCore/QuartzCore.h>
#import "MHFacebookSearchView.h"

@implementation MHSearchButton

@synthesize assignedSuperView;
- (id)initWithFrame:(CGRect)frame assignedSuper: (UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor blueColor];
        
        UIImageView *buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		buttonImage.image = [UIImage imageNamed:@"search.png"];
		
		[self addSubview:buttonImage];
        
        assignedSuperView = view;
        [self addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
        // Initialization code
    }
    return self;
}

- (void)tapped: (UIButton *) btn
{
    NSLog(@"facebook");
    MHFacebookSearchView * facebook = [[MHFacebookSearchView alloc] initWithFrame:CGRectMake(0, assignedSuperView.frame.size.height, assignedSuperView.frame.size.width, assignedSuperView.frame.size.height)];
    
    [assignedSuperView addSubview:facebook];
    
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut;
    [UIView animateWithDuration:0.3 delay:0.0 options:options animations:^{
        facebook.frame = CGRectMake(0, 0, assignedSuperView.frame.size.width, assignedSuperView.frame.size.height);
    } completion:nil];    
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
