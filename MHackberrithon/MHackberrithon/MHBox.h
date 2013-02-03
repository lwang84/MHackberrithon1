//
//  MHBox.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHConfirmButtons.h"
#import "MHRecognizedTextView.h"


@class MHBox;

@protocol MHBoxDelegate

-(void)originalGotTapped: (MHBox *) original;

@end


@interface MHBox : UIButton

@property NSString *word;

- (id)initWithFrame:(CGRect)frame word:(NSString *)w;

@property (retain) MHConfirmButtons * confirmView;
@property (retain) MHRecognizedTextView * textView;
- (BOOL) checkREGEX: (NSString *) expression;
@property (assign) id<MHBoxDelegate>delegate;


- (id)initWithFrame:(CGRect)frame
               word:(NSString *)w
            buttons:(MHConfirmButtons *)btns
           textview:(MHRecognizedTextView *)txtview;

@end
