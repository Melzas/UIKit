//
//  IDPPresentationController.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPViewControllerChildMacros.h"

@protocol IDPPresentationControllerDelegate;
@protocol IDPPresentationControllerDataSource;

@class IDPPresentationController;

@interface UIViewController (IDPPresentationController)

- (IDPPresentationController *)presentationController;

@end

@interface IDPPresentationController : UIViewController
@property (nonatomic, retain)	id					contentViewController;
@property (nonatomic, readonly)	NSArray				*modalViewControllers;

@property (nonatomic, assign, getter = isUserInteractionDuringTransitionEnabled)
	BOOL userInteractionDuringTransitionEnabled;

@property (nonatomic, assign)	id<IDPPresentationControllerDelegate>	delegate;
@property (nonatomic, assign)	id<IDPPresentationControllerDataSource>	dataSource;

- (void)presentViewController:(id)viewController animated:(BOOL)animated;
- (void)dismissViewController:(id)viewController animated:(BOOL)animated;

- (void)presentViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;
- (void)dismissViewController:(id)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock;

@end
