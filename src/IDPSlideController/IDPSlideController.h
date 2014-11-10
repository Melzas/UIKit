//
//  IDPSlideController.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

// Usage with storyboard:
// 1) Drag new UIViewController to storyboard from the Object Library
// 2) Rename its class to IDPSlideController
// 3) Replace main UIView of IDPSlideController with Container View from the Object Library
// 4) Rename Container View class to IDPSlideView
// 5) Drag another UIViewController to storyboard
// 6) Create an embed segue from Container View to this UIViewController
// 7) Set the identifier of segue to "contentViewController"
// 8) Thats it. Now this UIViewController is content view controller of IDPSlideController.
//    You can setup datasource for IDPSlideController as usual

#import <UIKit/UIKit.h>

#import "IDPViewControllerChildMacros.h"

@protocol IDPSlideControllerDelegate;
@protocol IDPSlideControllerDataSource;

@class IDPSlideController;

@interface UIViewController (IDPSlideController)

- (IDPSlideController *)slideController;

@end

@interface IDPSlideController : UIViewController
// the main view controller, occupies the whole view and always on screen
@property (nonatomic, retain)	id							contentViewController;

// array of the modal view controllers
@property (nonatomic, readonly)	NSArray						*slideViewControllers;

// determines whether to disable user interaction during a transition
@property (nonatomic, assign, getter = isUserInteractionDuringTransitionEnabled)
	BOOL userInteractionDuringTransitionEnabled;

@property (nonatomic, assign)	id<IDPSlideControllerDelegate>	delegate;
@property (nonatomic, assign)	id<IDPSlideControllerDataSource>	dataSource;

// call this to present |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// slideViewControllersForSlideController:)
- (void)presentViewController:(id)viewController animated:(BOOL)animated;

// call this to dismiss |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// slideViewControllersForSlideController:)
- (void)dismissViewController:(id)viewController animated:(BOOL)animated;

// call this to present |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// slideViewControllersForSlideController:)
// |completionBlock| is called after transition ends
- (void)presentViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;

// call this to dismiss |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// slideViewControllersForSlideController:)
// |completionBlock| is called after transition ends
- (void)dismissViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;

@end
