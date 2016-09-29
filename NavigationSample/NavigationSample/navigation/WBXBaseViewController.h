//
//  WBXBaseViewController.h
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WBXNavigationViewController;
@interface WBXBaseViewController : NSViewController
{
	WBXNavigationViewController *_navigationViewController;
	NSColor *_backgroundColor;
}
@property(nonatomic, retain)WBXNavigationViewController *navigationViewController;
@property(nonatomic, retain)NSColor *backgroundColor;

- (void)goBack:(id)sender;
- (void)goNext:(id)sender;
@end
