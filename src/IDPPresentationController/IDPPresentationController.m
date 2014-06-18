//
//  IDPPresentationController.m
//  IDPKit
//
//  Created by Anton Rayev on 5/13/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPPresentationController.h"

#import "IDPPresentationControllerDelegate.h"
#import "IDPPresentationControllerDataSource.h"

#import "IDPPresentationView.h"

#define kIDPWillReplaceSelector @selector(presentationController: \
							  willProceedToContentViewController: \
											  fromViewController:)
#define kIDPDidReplaceSelector	@selector(presentationController: \
							   didProceedToContentViewController: \
											  fromViewController:)

#define kIDPWillPresentSelector @selector(presentationController:willPresentViewController:)
#define kIDPDidPresentSelector	@selector(presentationController:didPresentViewController:)
#define kIDPWillDismissSelector @selector(presentationController:willDismissViewController:)
#define kIDPDidDismissSelector	@selector(presentationController:didDismissViewController:)

@implementation UIViewController (IDPPresentationController)

- (IDPPresentationController *)presentationController {
	UIViewController *parentController = self.parentViewController;
	
	if (![parentController isKindOfClass:[IDPPresentationController class]]) {
		return nil;
	}
	
	return (IDPPresentationController *)parentController;
}

@end

@interface IDPPresentationController ()
@property (nonatomic, retain)	NSMutableArray	*mutableModalViewControllers;

- (void)addModalViewController:(UIViewController *)viewController;
- (void)removeModalViewController:(UIViewController *)viewController;

@end


@implementation IDPPresentationController

@dynamic modalViewControllers;

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

IDPViewControllerViewOfClassGetterSynthesize(IDPPresentationView, presentationView);

- (void)setContentViewController:(UIViewController *)contentViewController {
	UIViewController *oldContentViewController = _contentViewController;
	if (contentViewController == oldContentViewController) {
		return;
	}
	
	self.view.userInteractionEnabled = YES;
	
	contentViewController.view.frame = self.view.frame;
	
	id<IDPPresentationControllerDelegate> delegate = self.delegate;
	[delegate performSelector:kIDPWillReplaceSelector
				  withObjects:self, contentViewController, contentViewController, nil];
	
	IDPViewControllerRemoveChildViewControllerSynthesize(_contentViewController);
	IDPNonatomicRetainPropertySynthesize(_contentViewController, contentViewController);
	[self addChildViewController:contentViewController];
	[self.view insertSubview:contentViewController.view atIndex:0];
	[contentViewController didMoveToParentViewController:self];
	
	[delegate performSelector:kIDPDidReplaceSelector
				  withObjects:self, contentViewController, oldContentViewController, nil];
}

- (void)setDataSource:(id<IDPPresentationControllerDataSource>)dataSource {
	self.view.userInteractionEnabled = YES;
	
	IDPNonatomicAssignPropertySynthesize(_dataSource, dataSource);
	
	NSMutableArray *mutableModalViewControllers = self.mutableModalViewControllers;
	
	for (NSUInteger i = [mutableModalViewControllers count]; i != 0; --i) {
		[self removeModalViewController:mutableModalViewControllers[0]];
	}
	
	NSArray *modalViewControllers = [dataSource modalViewControllers];
	NSUInteger modalViewControllerCount = [modalViewControllers count];
	self.mutableModalViewControllers = [NSMutableArray arrayWithCapacity:modalViewControllerCount];
	
	for (UIViewController *viewController in modalViewControllers) {
		[self addModalViewController:viewController];
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
	id<IDPPresentationControllerDataSource> dataSource = self.dataSource;
	
	IDPPresentingOptions options = [dataSource presentingOptionsForViewController:viewController];
	if (!animated) {
		options.animationDuration = 0;
	}
	
	id<IDPPresentationControllerDelegate> delegate = self.delegate;
	[delegate performSelector:kIDPWillPresentSelector withObjects:self, viewController, nil];
	
	UIView *view = self.view;
	view.userInteractionEnabled = self.userInteractionDuringTransitionEnabled;
	
	[self.presentationView presentView:viewController.view
					 presentingOptions:options
							completion:^{
								view.userInteractionEnabled = YES;
								
								[delegate performSelector:kIDPDidPresentSelector
											  withObjects:self, viewController, nil];
								
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
	id<IDPPresentationControllerDataSource> dataSource = self.dataSource;
	
	IDPPresentingOptions options = [dataSource presentingOptionsForViewController:viewController];
	if (!animated) {
		options.animationDuration = 0;
	}
	
	id<IDPPresentationControllerDelegate> delegate = self.delegate;
	[delegate performSelector:kIDPWillDismissSelector withObjects:self, viewController, nil];
	
	UIView *view = self.view;
	view.userInteractionEnabled = self.userInteractionDuringTransitionEnabled;
	
	[self.presentationView dismissView:viewController.view
					 presentingOptions:options
							completion:^{
								view.userInteractionEnabled = YES;
								
								[delegate performSelector:kIDPDidDismissSelector
											  withObjects:self, viewController, nil];
								
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
	
	id<IDPPresentationControllerDataSource> dataSource = self.dataSource;
	IDPPresentingOptions options = [dataSource presentingOptionsForViewController:viewController];
	
	CGRect frame = [self.presentationView frameForModalView:viewController.view
										  presentingOptions:options];
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
	UIView *view = [IDPPresentationView object];
	view.frame = [[UIScreen mainScreen] bounds];
	
	self.view = view;
}

@end
