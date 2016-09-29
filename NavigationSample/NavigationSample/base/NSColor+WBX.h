//
//  NSColor+WBX.h
//  NavigationSample
//
//  Created by foguo-mac-1 on 9/29/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (WBX)
+ (NSColor*)colorWithRGB:(uint32)rgb alpha:(CGFloat)alpha;
+(CGColorRef)cgcolorWithRGB:(uint32)rgb alpha:(CGFloat)alpha;
-(CGColorRef)CGColor;
+ (NSColor *)randomColor;
@end
