//
//  IDPSlideControllerDataSource.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPSlideOptions.h"

@class IDPSlideController;

@protocol IDPSlideControllerDataSource <NSObject>

// should return an array with modal view controllers for a given |controller|
- (NSArray *)slideViewControllersForSlideController:(IDPSlideController *)controller;

// should return presenting options for a given |viewController|
- (IDPSlideOptions)slideOptionsForViewController:(UIViewController *)viewController;

@end
