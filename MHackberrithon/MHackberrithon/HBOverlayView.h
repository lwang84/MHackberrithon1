//
//  OverlayView.h
//  OverlayViewTester
//
//  Created by Jason Job on 09-12-10.
//  Copyright 2009 Jason Job. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HBOverlayView;

@protocol MHOverlayViewDelegate
- (void) needTakePicture: (HBOverlayView *)overlay;
@end

@interface HBOverlayView : UIView {

}

- (void)scanButtonTouchUpInside;
- (void)clearLabel:(UILabel *)label;
@property (assign) id <MHOverlayViewDelegate> delegate;


@end
