//
//  NavigationSampleTests.m
//  NavigationSampleTests
//
//  Created by foguo-mac-1 on 9/29/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WBXBaseViewController.h"
#import "WBXNavigationViewController.h"

@interface NavigationSampleTests : XCTestCase
{
	WBXNavigationViewController *navigationViewCtrl;
	WBXBaseViewController *rootViewCtrl;
}
@end

@implementation NavigationSampleTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	rootViewCtrl = [[WBXNavigationViewController alloc] initWithNibName:[WBXNavigationViewController className] bundle:[NSBundle bundleForClass:[self class]]];
	//	navigationViewCtrl = [[WBXNavigationViewController alloc] initWithRootViewController:rootViewCtrl];
	navigationViewCtrl = [[WBXNavigationViewController alloc] initWithRootViewController:rootViewCtrl];
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
	[rootViewCtrl release];
	[navigationViewCtrl release];
}

- (void)testRootViewController
{
	WBXBaseViewController *topViewController = [navigationViewCtrl valueForKey:@"rootViewContoller"];
	XCTAssertEqual(topViewController, rootViewCtrl);

}

- (void)testPushViewController
{
	WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	[navigationViewCtrl pushViewController:viewCtrl animated:YES];
	WBXBaseViewController *topViewController = navigationViewCtrl.topViewController;
	XCTAssertEqual(topViewController, viewCtrl);
}

- (void)testPopViewControllerAnimated
{
	WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	[navigationViewCtrl pushViewController:viewCtrl animated:YES];
	WBXBaseViewController *poppedViewCtrl = [navigationViewCtrl popViewControllerAnimated:YES];
	XCTAssertNotNil(poppedViewCtrl);
	XCTAssertEqual(poppedViewCtrl, viewCtrl);
}

- (void)testPopToRootViewControllerAnimated
{
	NSMutableArray *needPopViewCtrls = [NSMutableArray array];
	WBXBaseViewController *rootViewCtrl = nil;
	for(NSInteger i = 0; i < 8; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
		if(i > 0)
		{
			[needPopViewCtrls addObject:viewCtrl];
		}
		else
		{
			rootViewCtrl = viewCtrl;
		}
	}
	
	NSArray *poppedViewCtrls = [navigationViewCtrl popToRootViewControllerAnimated:YES];
	
	XCTAssertEqual(navigationViewCtrl.topViewController, rootViewCtrl);
	
	XCTAssertEqual([needPopViewCtrls count], [poppedViewCtrls count]);
	for(NSInteger i = 0; i < [poppedViewCtrls count]; i ++)
	{
		WBXBaseViewController *viewCtrl = [poppedViewCtrls objectAtIndex:i];
		XCTAssertTrue([needPopViewCtrls containsObject:viewCtrl]);
	}
}

- (void)testGetViewControllers
{
	NSMutableArray *pushedViewCtrls = [NSMutableArray array];
	for(NSInteger i = 0; i < 8; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
		[pushedViewCtrls addObject:viewCtrl];
	}
	NSArray *subViewCtrl = navigationViewCtrl.viewControllers;
	XCTAssertEqual([pushedViewCtrls count], [subViewCtrl count]);
	for(NSInteger i = 0; i < [subViewCtrl count]; i ++)
	{
		WBXBaseViewController *viewCtrl = [subViewCtrl objectAtIndex:i];
		XCTAssertTrue([pushedViewCtrls containsObject:viewCtrl]);
	}
}

- (void)testPushMultiViewControllers
{
	NSMutableArray *viewCtrls = [NSMutableArray array];
	for(NSInteger i = 0; i < 8; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
		[viewCtrls addObject:viewCtrl];
	}
	NSArray *subViewCtrls = navigationViewCtrl.viewControllers;
	XCTAssertEqual([subViewCtrls count], [viewCtrls count]);
	for(NSInteger i = 0; i < [viewCtrls count]; i ++)
	{
		WBXBaseViewController *viewCtrl = [viewCtrls objectAtIndex:i];
		XCTAssertTrue([subViewCtrls containsObject:viewCtrl]);
	}
}

- (void)testSetViewControllers
{
	NSMutableArray *viewCtrls = [NSMutableArray array];
	for(NSInteger i = 0; i < 8; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[viewCtrls addObject:viewCtrl];
	}
	[navigationViewCtrl setViewControllers:viewCtrls];
	NSArray *subViewCtrls = navigationViewCtrl.viewControllers;
	
	
	XCTAssertEqual([subViewCtrls count], [viewCtrls count]);
	for(NSInteger i = 0; i < [viewCtrls count]; i ++)
	{
		WBXBaseViewController *viewCtrl = [viewCtrls objectAtIndex:i];
		XCTAssertTrue([subViewCtrls containsObject:viewCtrl]);
	}
}

- (void)testPopToViewController
{
	for(NSInteger i = 0; i < 10; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
	}
	WBXBaseViewController *baseViewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	[navigationViewCtrl pushViewController:baseViewCtrl animated:YES];
	
	NSMutableArray *pushedViewCtrls = [NSMutableArray array];
	for(NSInteger i = 0; i < 8; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
		[pushedViewCtrls addObject:viewCtrl];
	}
	NSArray *poppedViewCtrls = [navigationViewCtrl popToViewController:baseViewCtrl animated:YES];
	XCTAssertEqual([pushedViewCtrls count], [poppedViewCtrls count]);
	for(NSInteger i = 0; i < [poppedViewCtrls count]; i ++)
	{
		WBXBaseViewController *viewCtrl = [poppedViewCtrls objectAtIndex:i];
		XCTAssertTrue([pushedViewCtrls containsObject:viewCtrl]);
	}
	
}

- (void)testDoesContainViewController
{
	WBXBaseViewController *baseViewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	[navigationViewCtrl pushViewController:baseViewCtrl animated:YES];
	BOOL doesContain = [navigationViewCtrl doesContainViewController:baseViewCtrl];
	XCTAssertTrue(doesContain);
}

- (void)testDoesnotContainViewController
{
	WBXBaseViewController *baseViewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
	//	[navigationViewCtrl pushViewController:baseViewCtrl animated:YES];
	BOOL doesContain = [navigationViewCtrl doesContainViewController:baseViewCtrl];
	XCTAssertFalse(doesContain);
}

- (void)testGoBack
{
	for(NSInteger i = 0; i < 10; i++)
	{
		WBXBaseViewController *viewCtrl = [[[WBXBaseViewController alloc] initWithNibName:[WBXBaseViewController className] bundle:[NSBundle bundleForClass:[self class]]] autorelease];
		[navigationViewCtrl pushViewController:viewCtrl animated:YES];
	}
	[navigationViewCtrl goBack:nil];
	NSArray *viewControllers = navigationViewCtrl.viewControllers;
	XCTAssertEqual([viewControllers count], 9);
	
}

- (void)testExample {
	// Use recording to get started writing UI tests.
	// Use XCTAssert and related functions to verify your tests produce the correct results.
}
@end
