//
//  IDPSlideView.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPSlideOptions.h"

@protocol IDPSlideControllerDataSource;
@protocol IDPSlideControllerDelegate;

// This class is internal
// If your IDPSlideController is in nib/storyboard, you need to set the class
// of its main view to IDPSlideView
@interface IDPSlideView : UIView

- (CGRect)frameForModalView:(UIView *)modalView
		  slideOptions:(IDPSlideOptions)slideOptions;

- (void)presentView:(UIView *)view
  slideOptions:(IDPSlideOptions)slideOptions
		 completion:(void (^)(void))competionBlock;

- (void)dismissView:(UIView *)view
  slideOptions:(IDPSlideOptions)slideOptions
		 completion:(void (^)(void))competionBlock;

@end
