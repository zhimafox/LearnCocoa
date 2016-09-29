//
//  SampleWindowViewController.m
//  NavigationSample
//
//  Created by foguo-mac-1 on 9/29/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "SampleWindowViewController.h"
#import "NSColor+WBX.h"
#import "WBXNavigationViewController.h"
#import "WBXWelcomeViewController.h"
@interface SampleWindowViewController ()
@property(nonatomic, retain)WBXNavigationViewController *navigationViewController;


@end

@implementation SampleWindowViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	
	[self createNavigationViewController];
//	[self.navigationViewController pushViewController:[self getViewController] animated:YES];
}

- (void)createNavigationViewController
{
	WBXWelcomeViewController *rootViewController = [self getViewController];
	rootViewController.backgroundColor = [NSColor randomColor];
	
	self.navigationViewController = [[WBXNavigationViewController alloc] initWithRootViewController:rootViewController];
	[self.contentViewController.view addSubview:[self.navigationViewController view]];
	[[self.navigationViewController view] setFrame:[self.contentViewController.view frame]];
	[self.navigationViewController view].autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	[self.navigationViewController setTitle:@"Hello test"];
	
	[self.navigationViewController.view setWantsLayer:YES];
	self.navigationViewController.view.layer.borderWidth = 2;
}

- (WBXWelcomeViewController *)getViewController
{
	WBXWelcomeViewController *viewController = [[[WBXWelcomeViewController alloc] initWithNibName:[WBXWelcomeViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		viewController.backgroundColor = [NSColor blueColor];
	return viewController;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor grayColor] set];
	[[self.navigationViewController view] setFrame:[self.contentViewController.view frame]];
}
@end
