//
//  MHData.h
//  MHackberrithon
//
//  Created by Lingyong Wang on 2/2/13.
//  Copyright (c) 2013 Hackberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHData : NSObject

@property int top, bottom, right, left;
@property float confidence;
@property const char *symbol;
@property CGRect box;

- (id) initWithConfidence:(float)fi word:(const char*)w left: (int) l right: (int) r top: (int) t bottom: (int) b;

@end
