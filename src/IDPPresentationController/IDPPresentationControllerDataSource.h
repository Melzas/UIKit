//
//  IDPPresentationControllerDataSource.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPPresentingOptions.h"

@protocol IDPPresentationControllerDataSource <NSObject>

- (NSArray *)modalViewControllers;

- (IDPPresentingOptions)presentingOptionsForViewController:(UIViewController *)viewController;

@end
