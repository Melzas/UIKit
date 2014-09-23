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

- (NSArray *)modalViewControllersForPresentationController:(IDPPresentationController *)controller;

- (IDPPresentingOptions)presentingOptionsForViewController:(UIViewController *)viewController;

@end
