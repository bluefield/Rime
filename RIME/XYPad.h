//
//  XYPad.h
//  RIME
//
//  Created by Mike Jensen on 2015-03-26.
//  Copyright (c) 2015 David. All rights reserved.
//

#ifndef RIME_XYPad_h
#define RIME_XYPad_h

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface XYPad : UIButton 

@property NSString *property;
@property NSString *xyTitle;
@property int xPosition;
@property int yPosition;
@property int height;
@property int width;
@property int to;
@property int from;

@end

#endif
