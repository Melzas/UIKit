//
//  IDPPresentationControllerDataSource.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPPresentingOptions.h"

@class IDPPresentationController;

@protocol IDPPresentationControllerDataSource <NSObject>

// should return an array with modal view controllers for a given |controller|
- (NSArray *)modalViewControllersForPresentationController:(IDPPresentationController *)controller;

// should return presenting options for a given |viewController|
- (IDPPresentingOptions)presentingOptionsForViewController:(UIViewController *)viewController;

@end
