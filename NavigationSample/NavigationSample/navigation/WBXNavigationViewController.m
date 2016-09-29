//
//  WBXNavigationViewController.m
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import "WBXNavigationViewController.h"

@interface WBXNavigationViewController()
{
	IBOutlet NSButton *previousButton;
	IBOutlet NSButton *nextButton;
	IBOutlet NSTextField *titleTextField;
	IBOutlet NSView *targetView;
}
@property (nonatomic, retain)WBXBaseViewController *rootViewContoller;
@property(nonatomic,retain) NSMutableArray *viewControllersStack;

@end

@implementation WBXNavigationViewController
@synthesize viewControllers;
- (instancetype)initWithRootViewController:(WBXBaseViewController *)rootViewController
{
	self = [super initWithNibName:[self className] bundle:[NSBundle bundleForClass:[self class]]];
	if(self)
	{
		self.rootViewContoller = rootViewController;
		self.rootViewContoller.navigationViewController = self;
		self.viewControllersStack = [[[NSMutableArray alloc] init] autorelease];
	}
	return self;
}

- (void)awakeFromNib
{
	[self addViewController:self.rootViewContoller animated:YES];
}

- (void)checkPreviousButtonStatus
{
	if([self.viewControllersStack count] <= 1)
	{
		previousButton.hidden = YES;
	}
	else
	{
		previousButton.hidden = NO;
	}
	
}

/*
 * Get the top of current navigation view controller.
 *
 * @parameter viewController the viewController that will be push into WBXNavigationViewController.
 * @parameter animated is need animation effect when push.
 *
 */
- (WBXBaseViewController *)getTopViewController
{
	return [self.viewControllersStack lastObject];;
}

/*
 * Push a WBXBaseViewController into WBXNavigationViewController.
 *
 * @parameter viewController the viewController that will be push into WBXNavigationViewController.
 * @parameter animated is need animation effect when push.
 *
 */
- (void)pushViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	if([self doesContainViewController:viewController])
	{
		NSString *classInfo = [NSString stringWithFormat:@"%@(%p)", [viewController className], viewController];
		NSException *exception = [NSException
								  exceptionWithName: @"doesContainViewController"
								  reason: [NSString stringWithFormat:@"%@%@", @"Pushing the same view controller instance more than once is not supported", classInfo]
								  userInfo: nil];
		@throw exception;
		return;
	}
	
	[self addTopViewController:viewController animated:animated];
}

/*
 * Pop a WBXBaseViewController from WBXNavigationViewController if exist.
 *
 * @parameter animated is need animation effect when push.
 * @return WBXBaseViewController which popped.
 *
 */
- (WBXBaseViewController *)popViewControllerAnimated:(BOOL)animated
{
	return [self removeTopViewController];
}


/*
 * Pop WBXBaseViewController to viewController.
 *
 * @parameter viewController displayed viewController after popped.
 * @return all of WBXBaseViewController which popped.
 *
 */
- (NSArray *)popToViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	if(viewController == nil)
		viewController = self.rootViewContoller;
	NSMutableArray *removedViewControllers  = [[[NSMutableArray alloc] init] autorelease];
	NSArray* copyViewControllers = [NSArray arrayWithArray:self.viewControllersStack];
	for(NSInteger i = ([copyViewControllers count] - 1); i >= 0; i --)
	{
		WBXBaseViewController *existViewController = [copyViewControllers objectAtIndex:i];
		if(existViewController != viewController)
		{
			[removedViewControllers addObject:existViewController];
			[self removeViewController:existViewController];
		}
		else
		{
			break;
		}
	}
	return removedViewControllers;
}

/*
 * Pop WBXBaseViewController to rootViewController.
 *
 * @parameter animated is need animation effect when push.
 * @return all of WBXBaseViewController which popped.
 *
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
	if([self.viewControllersStack count] == 0)
		return [NSArray array];
	return [self popToViewController:[self.viewControllersStack firstObject] animated:animated];
}



/*
 * Get all of subViewController from current naviagtion view controller
 *
 * @parameter viewControllers set new WBXBaseViewController into this navigationViewController.
 *
 */
- (NSArray *)getViewControllers
{
	return [NSArray arrayWithArray:self.viewControllersStack];
}


/*
 * Reset all of viewControllers into current navigationViewController.
 *
 * @parameter viewControllers set new WBXBaseViewController into this navigationViewController.
 *
 */
- (void)setViewControllers:(NSArray *)viewCtrls
{
	[self.viewControllersStack removeAllObjects];
	for(NSInteger i = 0; i < [viewCtrls count]; i ++)
	{
		WBXBaseViewController *viewController = [viewCtrls objectAtIndex:i];
		[self pushViewController:viewController animated:NO];
	}
}


/*
 * Add a top WBXBaseViewController into current navigationViewController.
 *
 * @parameter viewController the new top of WBXBaseViewController.
 * @parameter animated is need animation effect when push.
 *
 */
- (void)addTopViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	
	[self addViewController:viewController animated:animated];
}

/*
 * Add a WBXBaseViewController into current navigationViewController.
 *
 * @parameter viewController the new of WBXBaseViewController need add into current navigation view controller.
 * @parameter animated is need animation effect when push.
 *
 */
- (void)addViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated
{
	if([self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
	{
		[self.delegate navigationController:self willShowViewController:viewController animated:animated];
	}
	[self.viewControllersStack addObject:viewController];
	viewController.navigationViewController = self;
	
	[self checkPreviousButtonStatus];
	[targetView addSubview:[viewController view]];
	
	if([self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
	{
		[self.delegate navigationController:self didShowViewController:viewController animated:animated];
	}
}

/*
 * Remove a top WBXBaseViewController from current navigationViewController.
 *
 * @return popped top WBXBaseViewController
 *
 */
- (WBXBaseViewController *)removeTopViewController
{
	WBXBaseViewController *removedViewController = nil;
	if([self.viewControllersStack count] > 0)
	{
		removedViewController = [[self.viewControllersStack lastObject] retain];
		[self removeViewController:removedViewController];
		return [removedViewController autorelease];
	}
	return nil;
}

/*
 * Remove a WBXBaseViewController from current navigationViewController.
 *
 * @parameter viewController removed WBXBaseViewController.
 *
 */
- (void)removeViewController:(WBXBaseViewController *)viewController
{
	viewController.navigationViewController = nil;
	[self.viewControllersStack removeObject:viewController];
	[[viewController view] removeFromSuperview];
}



/*
 * Check this viewController does contained in current navigationViewController or not.
 *
 * @parameter viewController WBXBaseViewController which need check.
 *
 * @return YES if contained.
 *
 */
- (BOOL)doesContainViewController:(WBXBaseViewController *)viewController
{
//	if(viewController.navigationViewController)
//	{
//		NSString *classInfo = [NSString stringWithFormat:@"%@(%p)", [viewController className], viewController];
//		NSException *exception = [NSException
//								  exceptionWithName: @"doesContainViewController"
//								  reason: [NSString stringWithFormat:@"%@%@", @"Pushing the view controller instance into multi-WBXNavigationViewController is not supported", classInfo]
//								  userInfo: nil];
//		@throw exception;
//	}
	if([self.viewControllersStack containsObject:viewController])
	{
		return YES;
	}
	return NO;
}


- (void)setNavigationTitle:(NSString *)title
{
	titleTextField.stringValue = title;
}

- (void)displayLeftButtonWithTitle:(NSString *)title
{
	previousButton.hidden = NO;
	[previousButton setTitle:title];
}

- (void)displayRightButtonWithTitle:(NSString *)title
{
	nextButton.hidden = NO;
	[nextButton setTitle:title];
}

- (IBAction)goBack:(id)sender
{
	[self popViewControllerAnimated:YES];
	[self checkPreviousButtonStatus];
}

- (IBAction)goNext:(id)sender
{
	if(self.topViewController)
	{
		[self.topViewController goNext:sender];
	}
}

- (void)dealloc
{
	self.rootViewContoller.navigationViewController = nil;
	self.rootViewContoller = nil;
	[self.viewControllersStack removeAllObjects];
	self.viewControllersStack = nil;
	[super dealloc];
}
@end
