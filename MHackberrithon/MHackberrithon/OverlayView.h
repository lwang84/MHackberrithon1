//
//  OverlayView.h
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OverlayView;

@protocol MHOverlayViewDelegate
- (void) needTakePicture: (OverlayView *)overlay;
@end

@interface OverlayView : UIView {

}

- (void)scanButtonTouchUpInside;
- (void)clearLabel:(UILabel *)label;
@property (assign) id <MHOverlayViewDelegate> delegate;


@end
