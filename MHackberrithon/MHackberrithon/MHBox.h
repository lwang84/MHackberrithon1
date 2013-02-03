//
//  MHBox.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHBox : UIButton

@property NSString *word;

- (id)initWithFrame:(CGRect)frame word:(NSString *)w;

- (BOOL) checkREGEX: (NSString *) expression;

@end
