//
//  NSLayoutConstraint+IDPExtensions.h
//  IDPKit
//
//  Created by Anton Rayev on 10/6/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (IDPExtensions)

+ (NSLayoutConstraint *)topConstraintFrom:(UIView *)fromView
									   to:(UIView *)toView
									value:(CGFloat)value;

+ (NSLayoutConstraint *)leftConstraintFrom:(UIView *)fromView
										to:(UIView *)toView
									 value:(CGFloat)value;

+ (NSLayoutConstraint *)rightConstraintFrom:(UIView *)fromView
										 to:(UIView *)toView
									  value:(CGFloat)value;

+ (NSLayoutConstraint *)bottomConstraintFrom:(UIView *)fromView
										  to:(UIView *)toView
									   value:(CGFloat)value;

+ (NSLayoutConstraint *)horizontalSpacingFrom:(UIView *)fromView
										   to:(UIView *)toView
										value:(CGFloat)value;

+ (NSLayoutConstraint *)verticalSpacingFrom:(UIView *)fromView
										 to:(UIView *)toView
									  value:(CGFloat)value;

+ (NSLayoutConstraint *)widthConstraintFor:(UIView *)view value:(CGFloat)value;
+ (NSLayoutConstraint *)heightConstraintFor:(UIView *)view value:(CGFloat)value;

+ (NSArray *)equalWidthConstraintsFor:(NSArray *)views;
+ (NSArray *)equalHeightConstraintsFor:(NSArray *)views;

+ (NSLayoutConstraint *)horizontalCenterOf:(UIView *)ofView in:(UIView *)inView;
+ (NSLayoutConstraint *)verticalCenterOf:(UIView *)ofView in:(UIView *)inView;

@end
