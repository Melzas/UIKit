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
