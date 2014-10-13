//
//  IDPPresentationController.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

// Usage with storyboard:
// 1) Drag new UIViewController to storyboard from the Object Library
// 2) Rename its class to IDPPresentationController
// 3) Replace main UIView of IDPPresentationController with Container View from the Object Library
// 4) Rename Container View class to IDPPresentationView
// 5) Drag another UIViewController to storyboard
// 6) Create an embed segue from Container View to this UIViewController
// 7) Set the identifier of segue to "contentViewController"
// 8) Thats it. Now this UIViewController is content view controller of IDPPresentationController.
//    You can setup datasource for IDPPresentationController as usual

#import "IDPViewControllerChildMacros.h"

@protocol IDPPresentationControllerDelegate;
@protocol IDPPresentationControllerDataSource;

@class IDPPresentationController;

@interface UIViewController (IDPPresentationController)

- (IDPPresentationController *)presentationController;

@end

@interface IDPPresentationController : UIViewController
// the main view controller, occupies the whole view and always on screen
@property (nonatomic, retain)	id							contentViewController;

// array of the modal view controllers
@property (nonatomic, readonly)	NSArray						*modalViewControllers;

// determines whether to disable user interaction during a transition
@property (nonatomic, assign, getter = isUserInteractionDuringTransitionEnabled)
	BOOL userInteractionDuringTransitionEnabled;

@property (nonatomic, assign)	id<IDPPresentationControllerDelegate>	delegate;
@property (nonatomic, assign)	id<IDPPresentationControllerDataSource>	dataSource;

// call this to present |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// modalViewControllersForPresentationController:)
- (void)presentViewController:(id)viewController animated:(BOOL)animated;

// call this to dismiss |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// modalViewControllersForPresentationController:)
- (void)dismissViewController:(id)viewController animated:(BOOL)animated;

// call this to present |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// modalViewControllersForPresentationController:)
// |completionBlock| is called after transition ends
- (void)presentViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;

// call this to dismiss |viewController|
// |viewController| must be in the list of modal view controllers (must be provided by dataSource in
// modalViewControllersForPresentationController:)
// |completionBlock| is called after transition ends
- (void)dismissViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;

@end
