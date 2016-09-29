//
//  WBXNavigationViewController.h
//  OSXNavigation
//
//  Created by foguo-mac-1 on 9/27/16.
//  Copyright © 2016 Fox Guo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WBXView.h"
#import "WBXBaseViewController.h"

@protocol WBXNavigationControllerDelegate;

@interface WBXNavigationViewController : WBXBaseViewController
{
}
@property(nonatomic,readonly,retain, getter=getTopViewController) WBXBaseViewController *topViewController;
@property(nonatomic,copy, getter=getViewControllers) NSArray *viewControllers;
@property(nonatomic, assign) id<WBXNavigationControllerDelegate> delegate;

- (instancetype)initWithRootViewController:(WBXBaseViewController *)rootViewController;
- (void)pushViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated;
- (WBXBaseViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray *)popToViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated; // Pops view controllers until the one specified is on top. Returns the popped controllers.
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated; // Pops until there's only a single view controller left on the stack. Returns the popped controllers.

- (BOOL)doesContainViewController:(WBXBaseViewController *)viewController;

- (void)setNavigationTitle:(NSString *)title;
- (void)displayLeftButtonWithTitle:(NSString *)title;
- (void)displayRightButtonWithTitle:(NSString *)title;
@end


@protocol WBXNavigationControllerDelegate <NSObject>

@optional

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(WBXNavigationViewController *)navigationController willShowViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(WBXNavigationViewController *)navigationController didShowViewController:(WBXBaseViewController *)viewController animated:(BOOL)animated;
@end
