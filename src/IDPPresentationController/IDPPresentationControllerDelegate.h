//
//  IDPPresentationControllerDelegate.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class IDPPresentationController;

@protocol IDPPresentationControllerDelegate <IDPObject>

@optional

-		  (void)presentationController:(IDPPresentationController *)presentationController
	willProceedToContentViewController:(UIViewController *)contentViewController
					fromViewController:(UIViewController *)oldViewController;

-		 (void)presentationController:(IDPPresentationController *)presentationController
	didProceedToContentViewController:(UIViewController *)contentViewController
				   fromViewController:(UIViewController *)newViewController;

- (void)presentationController:(IDPPresentationController *)presentationController
	 willPresentViewController:(UIViewController *)viewController;

- (void)presentationController:(IDPPresentationController *)presentationController
	  didPresentViewController:(UIViewController *)viewController;

- (void)presentationController:(IDPPresentationController *)presentationController
	 willDismissViewController:(UIViewController *)viewController;

- (void)presentationController:(IDPPresentationController *)presentationController
	  didDismissViewController:(UIViewController *)viewController;

@end
