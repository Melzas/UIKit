//
//  IDPSlideController.m
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPSlideController.h"

#import "NSObject+IDPExtensions.h"
#import "UIViewController+IDPExtensions.h"
#import "IDPPropertyMacros.h"

#import "IDPSlideControllerDelegate.h"
#import "IDPSlideControllerDataSource.h"

#import "IDPSlideView.h"

#define kIDPWillReplaceSelector @selector(slideController: \
							  willProceedToContentViewController: \
											  fromViewController:)
#define kIDPDidReplaceSelector	@selector(slideController: \
							   didProceedToContentViewController: \
											  fromViewController:)

#define kIDPWillPresentSelector @selector(slideController:willPresentViewController:animated:)
#define kIDPDidPresentSelector	@selector(slideController:didPresentViewController:animated:)
#define kIDPWillDismissSelector @selector(slideController:willDismissViewController:animated:)
#define kIDPDidDismissSelector	@selector(slideController:didDismissViewController:animated:)

@implementation UIViewController (IDPSlideController)

- (IDPSlideController *)slideController {
	id controller = self;
	
	do {
		controller = [controller parentViewController];
		if ([controller isKindOfClass:[IDPSlideController class]]) {
			return controller;
		}
	} while (nil != controller);
	
	return nil;
}

@end

@interface IDPSlideController ()
@property (nonatomic, retain)	NSMutableArray	*mutableModalViewControllers;

- (void)addModalViewController:(UIViewController *)viewController;
- (void)removeModalViewController:(UIViewController *)viewController;

@end


@implementation IDPSlideController

@dynamic slideViewControllers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.contentViewController = nil;
	self.mutableModalViewControllers = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
	self = [super initWithNibName:nibName bundle:nibBundle];
	
	if (self) {
		self.userInteractionDuringTransitionEnabled = NO;
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(IDPSlideView, slideView);

- (void)setContentViewController:(UIViewController *)contentViewController {
	UIViewController *oldContentViewController = _contentViewController;
	if (contentViewController == oldContentViewController) {
		return;
	}
	
	self.view.userInteractionEnabled = YES;
	
	contentViewController.view.frame = self.view.frame;
	
	id<IDPSlideControllerDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:kIDPWillReplaceSelector]) {
		[delegate slideController:self
	  willProceedToContentViewController:contentViewController
					  fromViewController:oldContentViewController];
	}
	
	if (nil == self.storyboard) {
		IDPViewControllerRemoveChildViewControllerSynthesize(_contentViewController);
	}
	
	IDPNonatomicRetainPropertySynthesize(_contentViewController, contentViewController);
	
	if (nil == self.storyboard) {
		if (nil != contentViewController) {
			[self addChildViewController:contentViewController];
			[self.view insertSubview:contentViewController.view atIndex:0];
			[contentViewController didMoveToParentViewController:self];
		}
	}
	
	if ([delegate respondsToSelector:kIDPDidReplaceSelector]) {
		[delegate slideController:self
	   didProceedToContentViewController:contentViewController
					  fromViewController:oldContentViewController];
	}
}

- (void)setDataSource:(id<IDPSlideControllerDataSource>)dataSource {
	self.view.userInteractionEnabled = YES;
	
	IDPNonatomicAssignPropertySynthesize(_dataSource, dataSource);
	
	NSMutableArray *mutableModalViewControllers = self.mutableModalViewControllers;
	
	for (NSUInteger i = [mutableModalViewControllers count]; i != 0; --i) {
		[self removeModalViewController:mutableModalViewControllers[0]];
	}
	
	NSArray *slideViewControllers = [dataSource slideViewControllersForSlideController:self];
	NSUInteger modalViewControllerCount = [slideViewControllers count];
	self.mutableModalViewControllers = [NSMutableArray arrayWithCapacity:modalViewControllerCount];
	
	for (UIViewController *viewController in slideViewControllers) {
		[self addModalViewController:viewController];
	}
}

#pragma mark -
#pragma mark Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:NSStringFromSelector(@selector(contentViewController))]) {
		self.contentViewController = segue.destinationViewController;
	}
}

#pragma mark -
#pragma mark Public

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[self presentViewController:viewController animated:animated completion:nil];
}

- (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[self dismissViewController:viewController animated:animated completion:nil];
}

- (void)presentViewController:(UIViewController *)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock
{
	id<IDPSlideControllerDataSource> dataSource = self.dataSource;
	
	IDPSlideOptions options = [dataSource slideOptionsForViewController:viewController];
	if (!animated) {
		options.animationDuration = 0;
	}
	
	id<IDPSlideControllerDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:kIDPWillPresentSelector]) {
		[delegate slideController:self
			   willPresentViewController:viewController
								animated:animated];
	}
	
	UIView *view = self.view;
	view.userInteractionEnabled = self.userInteractionDuringTransitionEnabled;
	
	[self.slideView presentView:viewController.view
					 slideOptions:options
							completion:^{
								view.userInteractionEnabled = YES;
								
								if ([delegate respondsToSelector:kIDPDidPresentSelector]) {
									[delegate slideController:self
											didPresentViewController:viewController
															animated:animated];
								}
								
								if (completionBLock) {
									completionBLock();
								}
							}
	 ];
}

- (void)dismissViewController:(UIViewController *)viewController
					 animated:(BOOL)animated
				   completion:(void(^)())completionBLock
{
	id<IDPSlideControllerDataSource> dataSource = self.dataSource;
	
	IDPSlideOptions options = [dataSource slideOptionsForViewController:viewController];
	if (!animated) {
		options.animationDuration = 0;
	}
	
	id<IDPSlideControllerDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:kIDPWillDismissSelector]) {
		[delegate slideController:self
			   willDismissViewController:viewController
								animated:animated];
	}
	
	UIView *view = self.view;
	view.userInteractionEnabled = self.userInteractionDuringTransitionEnabled;
	
	[self.slideView dismissView:viewController.view
					 slideOptions:options
							completion:^{
								view.userInteractionEnabled = YES;
								
								if ([delegate respondsToSelector:kIDPDidDismissSelector]) {
									[delegate slideController:self
											didDismissViewController:viewController
															animated:animated];
								}
								
								if (completionBLock) {
									completionBLock();
								}
							}
	 ];
}

#pragma mark -
#pragma mark Private

- (void)addModalViewController:(UIViewController *)viewController {
	NSMutableArray *mutableModalViewControllers = self.mutableModalViewControllers;
	
	[mutableModalViewControllers addObject:viewController];
	
	id<IDPSlideControllerDataSource> dataSource = self.dataSource;
	IDPSlideOptions options = [dataSource slideOptionsForViewController:viewController];
	
	CGRect frame = [self.slideView frameForModalView:viewController.view
										  slideOptions:options];
	viewController.view.frame = frame;
	
	IDPViewControllerAddChildViewControllerSynthesize(viewController);
}

- (void)removeModalViewController:(UIViewController *)viewController {
	NSMutableArray *mutableModalViewControllers = self.mutableModalViewControllers;
	
	if (![mutableModalViewControllers containsObject:viewController]) {
		return;
	}
	
	IDPViewControllerRemoveChildViewControllerSynthesize(viewController);
	
	[mutableModalViewControllers removeObject:viewController];
}

- (void)loadView {
	if (nil == self.storyboard) {
		UIView *view = [IDPSlideView object];
		view.frame = [[UIScreen mainScreen] bounds];
		
		self.view = view;
	} else {
		[super loadView];
	}
}

@end
