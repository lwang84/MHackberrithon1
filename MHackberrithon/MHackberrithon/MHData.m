//
//  MHData.m
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import "MHData.h"

@implementation MHData

- (id) initWithConfidence:(float)fi word:(const char*)w left: (int) l right: (int) r top: (int) t bottom: (int) b {
    self = [super init];
    if (self) {
        self.confidence = fi;
        self.symbol = w;
        self.left = l;
        self.right = r;
        self.bottom = b;
        self.top = t;
        
        self.box = CGRectMake(1.0*l, 1.0*t, 1.0*r - l, 1.0*b - t);
    }
    
    return self;
}
@end
