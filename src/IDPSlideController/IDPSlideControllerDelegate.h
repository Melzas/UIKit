//
//  IDPSlideControllerDelegate.h
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPObject.h"

@class IDPSlideController;

@protocol IDPSlideControllerDelegate <IDPObject>

@optional

-		  (void)slideController:(IDPSlideController *)slideController
	willProceedToContentViewController:(id)contentViewController
					fromViewController:(id)oldViewController;

-		 (void)slideController:(IDPSlideController *)slideController
	didProceedToContentViewController:(id)contentViewController
				   fromViewController:(id)newViewController;

- (void)slideController:(IDPSlideController *)slideController
	 willPresentViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)slideController:(IDPSlideController *)slideController
	  didPresentViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)slideController:(IDPSlideController *)slideController
	 willDismissViewController:(id)viewController
					  animated:(BOOL)animated;

- (void)slideController:(IDPSlideController *)slideController
	  didDismissViewController:(id)viewController
					  animated:(BOOL)animated;

@end
