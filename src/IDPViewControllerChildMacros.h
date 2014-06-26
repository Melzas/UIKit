//
//  IDPViewControllerChildMacros.h
//  IDPKit
//
//  Created by Anton Rayev on 5/14/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#define IDPViewControllerAddChildViewControllerSynthesize(childController) \
	if (nil != childController) { \
		[self addChildViewController:childController]; \
		[self.view addSubview:[childController view]]; \
		[childController didMoveToParentViewController:self]; \
	}

#define IDPViewControllerAddChildViewControllerToViewSynthesize(childController, toView) \
	if (nil != childController) { \
		[self addChildViewController:childController]; \
		[toView addSubview:[childController view]]; \
		[childController didMoveToParentViewController:self]; \
	}

#define IDPViewControllerRemoveChildViewControllerSynthesize(childController) \
	[childController willMoveToParentViewController:nil]; \
	[[childController view] removeFromSuperview]; \
	[childController removeFromParentViewController];
