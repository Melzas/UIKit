//
//  IDPPresentationView.m
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPPresentationView.h"

#import "IDPPresentationControllerDataSource.h"
#import "IDPPresentationControllerDelegate.h"

@interface IDPPresentationView ()

- (void)animatePresentingOfView:(UIView *)view
			  presentingOptions:(IDPPresentingOptions)presentingOptions
					 completion:(void (^)(void))competionBlock;

@end

@implementation IDPPresentationView

#pragma mark -
#pragma mark Public

- (CGRect)frameForModalView:(UIView *)modalView
		  presentingOptions:(IDPPresentingOptions)presentingOptions
{
	CGRect frame = self.frame;
	CGPoint viewOrigin = frame.origin;
	CGSize viewSize = frame.size;
	
	CGRect modalViewFrame = modalView.frame;
	CGPoint modalViewOrigin = modalViewFrame.origin;
	CGSize modalViewSize = modalViewFrame.size;
	
	if (presentingOptions.stretchingMask & IDPStretchingHorizontal) {
		modalViewSize = CGSizeMake(viewSize.width, modalViewSize.height);
	}
	if (presentingOptions.stretchingMask & IDPStretchingVertical) {
		modalViewSize = CGSizeMake(modalViewSize.width, viewSize.height);
	}
	
	CGFloat ledge = presentingOptions.ledge;
	
	switch (presentingOptions.direction) {
		case IDPSlideDirectionUp:
			modalViewOrigin = CGPointMake(modalViewOrigin.x, viewOrigin.y + viewSize.height - ledge);
			break;
			
		case IDPSlideDirectionDown:
			modalViewOrigin = CGPointMake(modalViewOrigin.x, -CGHeight(modalViewFrame) + ledge);
			break;
			
		case IDPSlideDirectionLeft:
			modalViewOrigin = CGPointMake(viewOrigin.x + viewSize.width - ledge, modalViewOrigin.y);
			break;
			
		case IDPSlideDirectionRight:
			modalViewOrigin = CGPointMake(-CGWidth(modalViewFrame) + ledge, modalViewOrigin.y);
			break;
	}
	
	return (CGRect){modalViewOrigin, modalViewSize};
}

- (void)presentView:(UIView *)view
  presentingOptions:(IDPPresentingOptions)presentingOptions
		 completion:(void (^)(void))competionBlock
{
	[self animatePresentingOfView:view
				presentingOptions:presentingOptions
					   completion:competionBlock];
}

- (void)dismissView:(UIView *)view
  presentingOptions:(IDPPresentingOptions)presentingOptions
		 completion:(void (^)(void))competionBlock
{
	presentingOptions.distance = -presentingOptions.distance;
	
	[self animatePresentingOfView:view
				presentingOptions:presentingOptions
					   completion:competionBlock];
}

#pragma mark -
#pragma mark Private

- (void)animatePresentingOfView:(UIView *)view
			  presentingOptions:(IDPPresentingOptions)presentingOptions
					 completion:(void (^)(void))competionBlock
{
	CGPoint center = view.center;
	
	[UIView animateWithDuration:presentingOptions.animationDuration
					 animations:^{
						 CGFloat distance = presentingOptions.distance;
						 
						 switch (presentingOptions.direction) {
							 case IDPSlideDirectionUp:
								 distance = -distance;
								 // no break
								 
							 case IDPSlideDirectionDown:
								 view.center = CGPointMake(center.x, center.y + distance);
								 break;
								 
							 case IDPSlideDirectionLeft:
								 distance = -distance;
								 // no break
								 
							 case IDPSlideDirectionRight:
								 view.center = CGPointMake(center.x + distance, center.y);
								 break;
						 }
					 }
					 completion:^(BOOL finished) {
						 if (competionBlock) {
							 competionBlock();
						 }
					 }
	 ];
}

@end
