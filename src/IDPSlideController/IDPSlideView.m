//
//  IDPSlideView.m
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPSlideView.h"

#import "CGGeometry+IDPExtensions.h"

#import "IDPSlideControllerDataSource.h"
#import "IDPSlideControllerDelegate.h"

@interface IDPSlideView ()

- (void)animatePresentingOfView:(UIView *)view
			  slideOptions:(IDPSlideOptions)slideOptions
					 completion:(void (^)(void))competionBlock;

@end

@implementation IDPSlideView

#pragma mark -
#pragma mark Public

- (CGRect)frameForModalView:(UIView *)modalView
		  slideOptions:(IDPSlideOptions)slideOptions
{
	CGRect frame = self.frame;
	CGPoint viewOrigin = frame.origin;
	CGSize viewSize = frame.size;
	
	CGRect modalViewFrame = modalView.frame;
	CGPoint modalViewOrigin = modalViewFrame.origin;
	CGSize modalViewSize = modalViewFrame.size;
	
	if (slideOptions.stretchingMask & IDPStretchingHorizontal) {
		modalViewSize = CGSizeMake(viewSize.width, modalViewSize.height);
	}
	if (slideOptions.stretchingMask & IDPStretchingVertical) {
		modalViewSize = CGSizeMake(modalViewSize.width, viewSize.height);
	}
	
	CGFloat ledge = slideOptions.ledge;
	
	switch (slideOptions.direction) {
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
  slideOptions:(IDPSlideOptions)slideOptions
		 completion:(void (^)(void))competionBlock
{
	[self animatePresentingOfView:view
				slideOptions:slideOptions
					   completion:competionBlock];
}

- (void)dismissView:(UIView *)view
  slideOptions:(IDPSlideOptions)slideOptions
		 completion:(void (^)(void))competionBlock
{
	slideOptions.distance = -slideOptions.distance;
	
	[self animatePresentingOfView:view
				slideOptions:slideOptions
					   completion:competionBlock];
}

#pragma mark -
#pragma mark Private

- (void)animatePresentingOfView:(UIView *)view
			  slideOptions:(IDPSlideOptions)slideOptions
					 completion:(void (^)(void))competionBlock
{
	CGPoint center = view.center;
	
	[UIView animateWithDuration:slideOptions.animationDuration
					 animations:^{
						 CGFloat distance = slideOptions.distance;
						 
						 switch (slideOptions.direction) {
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
