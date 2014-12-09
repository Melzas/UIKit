//
//  IDPLoadingImageView.h
//  IDPKit
//
//  Created by Anton Rayev on 5/21/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

@class IDPImageModel;

IB_DESIGNABLE
@interface IDPLoadingImageView : UIView <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;
@property (nonatomic, retain)	IBOutlet UIImageView				*imageView;
@property (nonatomic, retain)	IBInspectable UIImage				*placeholder;

@property (nonatomic, retain)	IDPImageModel	*model;

- (void)setModel:(IDPImageModel *)imageModel loadLater:(BOOL)loadLater;
- (void)loadModel;

@end
