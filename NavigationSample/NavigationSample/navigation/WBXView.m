//
//  WBXView.m
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "WBXView.h"
#import "NSColor+Wbx.h"
@interface WBXView()
@property(nonatomic, retain)NSColor *backgroundColor;
@end
@implementation WBXView

- (void)setBackGroundColor:(NSColor *)color
{
	self.backgroundColor = color;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
	if(!self.backgroundColor)
		return;
	[self.backgroundColor set];
	NSRectFill([self bounds]);
	
}

- (BOOL)autoresizesSubviews
{
	return YES;
}

- (void)dealloc
{
	self.backgroundColor = nil;
	[super dealloc];
}

@end
