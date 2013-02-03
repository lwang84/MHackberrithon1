//
//  MHSearchButton.h
//  MHackberrithon
//
//  Created by Haidong Tang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSearchButton : UIButton

- (id)initWithFrame:(CGRect)frame assignedSuper: (UIView *)view words: (NSString *)w;
@property (retain) UIView* assignedSuperView;
@property NSString *words;

@end
