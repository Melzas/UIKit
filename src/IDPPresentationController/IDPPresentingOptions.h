//
//  IDPPresentingOptions.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

typedef enum {
	// slide up from the bottom of the screen
	IDPSlideDirectionUp,
	
	// slide down from the top of the screen
	IDPSlideDirectionDown,
	
	// slide left from the right side of the screen
	IDPSlideDirectionLeft,
	
	// slide right from the left side of the screen
	IDPSlideDirectionRight
} IDPSlideDirection;

enum {
	// leave unchanged the size of the modal view controller's view
	IDPStretchingNone		= 0,
	
	// horizontally stretch or shrink the view of the modal view controller
	// to the size of the content view controller's view
	IDPStretchingHorizontal = 1,
	
	// vertically stretch or shrink the view of the modal view controller
	// to the size of the content view controller's view
	IDPStretchingVertical	= 2
};
typedef NSUInteger IDPStretchingMask;

struct __IDPPresentingOptions {
	// direction of sliding
	IDPSlideDirection direction;
	
	// determines whether to stretch/shrink the view of the modal view controller
	IDPStretchingMask stretchingMask;
	
	// duration of the sliding
	NSTimeInterval animationDuration;
	
	// ledge of the modal view controller's view
	// use this, if your modal view controller has to be partially visible in dismissed state
	CGFloat ledge;
	
	// the distance to slide
	CGFloat distance;
};
typedef struct __IDPPresentingOptions IDPPresentingOptions;
