//
//  IDPPresentingOptions.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

typedef enum {
	IDPSlideDirectionUp,
	IDPSlideDirectionDown,
	IDPSlideDirectionLeft,
	IDPSlideDirectionRight
} IDPSlideDirection;

enum {
	IDPStretchingNone		= 0,
	IDPStretchingHorizontal = 1,
	IDPStretchingVertical	= 2
};
typedef NSUInteger IDPStretchingMask;

struct __IDPPresentingOptions {
	IDPSlideDirection direction;
	IDPStretchingMask stretchingMask;
	
	NSTimeInterval animationDuration;
	
	CGFloat ledge;
	CGFloat distance;
};
typedef struct __IDPPresentingOptions IDPPresentingOptions;
