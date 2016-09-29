//
//  WBXBaseViewController.m
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "WBXBaseViewController.h"
#import "WBXView.h"
#import "WBXNavigationViewController.h"

@interface WBXBaseViewController() <WBXNavigationControllerDelegate>


@end

@implementation WBXBaseViewController
@synthesize navigationViewController = _navigationViewController;
@synthesize backgroundColor = _backgroundColor;
- (void)awakeFromNib
{
	[self renderBackgroundColor];
}

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
	_backgroundColor = backgroundColor;
}

- (void)renderBackgroundColor
{
	if(_backgroundColor)
	{
		[((WBXView *)self.view) setBackGroundColor:self.backgroundColor];
	}
}

- (void)navigationController:(WBXNavigationViewController *)navigationController didShowViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	
}

- (void)goBack:(id)sender
{
}

- (void)goNext:(id)sender
{
}

- (void)dealloc
{
	self.navigationViewController = nil;
	[super dealloc];
}
@end
