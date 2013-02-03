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
#import "MHSearchButton.h"


@class MHBox;

@protocol MHBoxDelegate

-(void)originalGotTapped: (MHBox *) original recognizedString: (NSString *) str;

@end


@interface MHBox : UIButton

@property NSString *word;

@property (retain) MHConfirmButtons * confirmView;
@property (retain) MHRecognizedTextView * textView;
@property (retain) MHSearchButton * searchBtn;

- (BOOL) checkREGEX: (NSString *) expression;
@property (assign) id<MHBoxDelegate>delegate;

@property BOOL isEmail;
@property BOOL isPhone;
@property BOOL isURL;


- (id)initWithFrame:(CGRect)frame
               word:(NSString *)w
            buttons:(MHConfirmButtons *)btns
           textview:(MHRecognizedTextView *)txtview
          searchBtn:(MHSearchButton *) search;

@end
