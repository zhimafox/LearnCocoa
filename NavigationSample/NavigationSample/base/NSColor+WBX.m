//
//  NSColor+WBX.m
//  NavigationSample
//
//  Created by foguo-mac-1 on 9/29/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "NSColor+WBX.h"

@implementation NSColor (WBX)
+ (NSColor*)colorWithRGB:(uint32)rgb alpha:(CGFloat)alpha
{
	CGFloat r = ((rgb>>16)&0xFF)/255.0;
	CGFloat g = ((rgb>>8)&0xFF)/255.0;
	CGFloat b = (rgb&0xFF)/255.0;
	return [NSColor colorWithDeviceRed:r green:g blue:b alpha:alpha];
}

+(CGColorRef)cgcolorWithRGB:(uint32)rgb alpha:(CGFloat)alpha
{
	NSColor* nsColor = [NSColor colorWithRGB:rgb alpha:alpha];
	return [nsColor CGColor];
}

-(CGColorRef)CGColor
{
	
	const NSInteger numberOfComponents = [self numberOfComponents];
	CGFloat components[numberOfComponents];
	CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];
	
	[self getComponents:(CGFloat *)&components];
	
	return (CGColorRef)[(id)CGColorCreate(colorSpace, components) autorelease];
}

+ (NSColor *)randomColor
{
	int red = rand() % 255;
	int green = rand() % 255;
	int blue = rand() % 255;
	return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
@end
