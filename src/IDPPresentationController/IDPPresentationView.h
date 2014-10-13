//
//  IDPPresentationView.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPPresentingOptions.h"

@protocol IDPPresentationControllerDataSource;
@protocol IDPPresentationControllerDelegate;

// This class is internal
// If your IDPPresentationController is in nib/storyboard, you need to set the class
// of its main view to IDPPresentationView
@interface IDPPresentationView : UIView

- (CGRect)frameForModalView:(UIView *)modalView
		  presentingOptions:(IDPPresentingOptions)presentingOptions;

- (void)presentView:(UIView *)view
  presentingOptions:(IDPPresentingOptions)presentingOptions
		 completion:(void (^)(void))competionBlock;

- (void)dismissView:(UIView *)view
  presentingOptions:(IDPPresentingOptions)presentingOptions
		 completion:(void (^)(void))competionBlock;

@end
