//
//  IDPPresentationControllerDelegate.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPObject.h"

@class IDPPresentationController;

@protocol IDPPresentationControllerDelegate <IDPObject>

@optional

-		  (void)presentationController:(IDPPresentationController *)presentationController
	willProceedToContentViewController:(id)contentViewController
					fromViewController:(id)oldViewController;

-		 (void)presentationController:(IDPPresentationController *)presentationController
	didProceedToContentViewController:(id)contentViewController
				   fromViewController:(id)newViewController;

- (void)presentationController:(IDPPresentationController *)presentationController
	 willPresentViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)presentationController:(IDPPresentationController *)presentationController
	  didPresentViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)presentationController:(IDPPresentationController *)presentationController
	 willDismissViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)presentationController:(IDPPresentationController *)presentationController
	  didDismissViewController:(id)viewController
					  animated:(BOOL)animated;

@end
