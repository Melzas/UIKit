//
//  IDPLoadingView.h
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPLoadingView : UIView
@property (nonatomic, readonly) UIActivityIndicatorView   *activityIndicator;
@property (nonatomic, readonly) UILabel                   *label;

+ (id)loadingViewInView:(UIView *)view;
+ (id)loadingViewInView:(UIView *)view withMessage:(NSString *)message;

@end
