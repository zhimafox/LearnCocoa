//
//  WBXWelcomeViewController.m
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "WBXWelcomeViewController.h"
#import "WBXView.h"
#import "WBXNavigationViewController.h"
#import "NSColor+WBX.h"


@implementation WBXWelcomeViewController
- (void)awakeFromNib
{
	[super awakeFromNib];
	self.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

- (void)viewDidAppear
{
	[super viewDidAppear];
	
	[self.navigationViewController setNavigationTitle:@"Test Navigation"];
	[self.navigationViewController displayRightButtonWithTitle:@"GoNext"];
	
	[self.view setFrameSize:self.view.superview.frame.size];
	self.view.layer.borderColor = [NSColor redColor].CGColor;
	[self.view setWantsLayer:YES];
	self.view.layer.borderWidth = 2;
	self.numbTextField.stringValue = [NSString stringWithFormat:@"%lu", self.navigationViewController.viewControllers.count];
}

- (void)navigationController:(WBXNavigationViewController *)navigationController didShowViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	
}

- (void)goNext:(id)sender
{
	WBXWelcomeViewController *viewController = [[[WBXWelcomeViewController alloc] initWithNibName:[WBXWelcomeViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	viewController.backgroundColor = [NSColor randomColor];
	[self.navigationViewController pushViewController:viewController animated:YES];
}
@end
