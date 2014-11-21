//
//  NSLayoutConstraint+TXExtensions.m
//  GoMarket
//
//  Created by Anton Rayev on 10/6/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import "NSLayoutConstraint+IDPExtensions.h"

@implementation NSLayoutConstraint (IDPExtensions)

+ (NSLayoutConstraint *)topConstraintFrom:(UIView *)fromView
									   to:(UIView *)toView
									value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeTop
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeTop
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)leftConstraintFrom:(UIView *)fromView
										to:(UIView *)toView
									 value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeLeft
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeLeft
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)rightConstraintFrom:(UIView *)fromView
										 to:(UIView *)toView
									  value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeRight
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeRight
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)bottomConstraintFrom:(UIView *)fromView
										  to:(UIView *)toView
									   value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeBottom
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeBottom
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)horizontalSpacingFrom:(UIView *)fromView
										   to:(UIView *)toView
										value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeTrailing
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeLeading
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)verticalSpacingFrom:(UIView *)fromView
										 to:(UIView *)toView
									  value:(CGFloat)value
{
	return [NSLayoutConstraint constraintWithItem:fromView
										attribute:NSLayoutAttributeBottom
										relatedBy:NSLayoutRelationEqual
										   toItem:toView
										attribute:NSLayoutAttributeTop
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)widthConstraintFor:(UIView *)view value:(CGFloat)value {
	return [NSLayoutConstraint constraintWithItem:view
										attribute:NSLayoutAttributeWidth
										relatedBy:NSLayoutRelationEqual
										   toItem:nil
										attribute:NSLayoutAttributeWidth
									   multiplier:1.0f
										 constant:value];
}

+ (NSLayoutConstraint *)heightConstraintFor:(UIView *)view value:(CGFloat)value {
	return [NSLayoutConstraint constraintWithItem:view
										attribute:NSLayoutAttributeHeight
										relatedBy:NSLayoutRelationEqual
										   toItem:nil
										attribute:NSLayoutAttributeHeight
									   multiplier:1.0f
										 constant:value];
}

+ (NSArray *)equalWidthConstraintsFor:(NSArray *)views {
	NSUInteger viewCount = [views count];
	if (1 == [views count]) {
		return nil;
	}
	
	NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:[views count]];
	
	for (NSUInteger i = 1; i < viewCount; ++i) {
		NSLayoutConstraint *constraint = nil;
		constraint = [NSLayoutConstraint constraintWithItem:views[i]
												  attribute:NSLayoutAttributeWidth
												  relatedBy:NSLayoutRelationEqual
													 toItem:views[i-1]
												  attribute:NSLayoutAttributeWidth
												 multiplier:1.0f
												   constant:0.0f];
		[constraints addObject:constraint];
	}
	
	return constraints;
}

+ (NSArray *)equalHeightConstraintsFor:(NSArray *)views {
	NSUInteger viewCount = [views count];
	if (1 == [views count]) {
		return nil;
	}
	
	NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:[views count]];
	
	for (NSUInteger i = 1; i < viewCount; ++i) {
		NSLayoutConstraint *constraint = nil;
		constraint = [NSLayoutConstraint constraintWithItem:views[i]
												  attribute:NSLayoutAttributeHeight
												  relatedBy:NSLayoutRelationEqual
													 toItem:views[i-1]
												  attribute:NSLayoutAttributeHeight
												 multiplier:1.0f
												   constant:0.0f];
		[constraints addObject:constraint];
	}
	
	return constraints;
}

+ (NSLayoutConstraint *)horizontalCenterOf:(UIView *)ofView in:(UIView *)inView {
	return [NSLayoutConstraint constraintWithItem:ofView
										attribute:NSLayoutAttributeCenterX
										relatedBy:NSLayoutRelationEqual
										   toItem:inView
										attribute:NSLayoutAttributeCenterX
									   multiplier:1.0f
										 constant:0.0f];
}

+ (NSLayoutConstraint *)verticalCenterOf:(UIView *)ofView in:(UIView *)inView {
	return [NSLayoutConstraint constraintWithItem:ofView
										attribute:NSLayoutAttributeCenterY
										relatedBy:NSLayoutRelationEqual
										   toItem:inView
										attribute:NSLayoutAttributeCenterY
									   multiplier:1.0f
										 constant:0.0f];
}

@end
