//
//  IDPLoadingImageView.h
//  IDPKit
//
//  Created by Anton Rayev on 5/21/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class IDPImageModel;

@interface IDPLoadingImageView : UIView <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;
@property (nonatomic, retain)	IBOutlet UIImageView				*imageView;

@property (nonatomic, retain)	IDPImageModel	*model;

- (void)loadModel;

@end
