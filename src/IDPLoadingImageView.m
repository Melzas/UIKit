//
//  IDPLoadingImageView.m
//  IDPKit
//
//  Created by Anton Rayev on 5/21/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPLoadingImageView.h"

#import "IDPImageModel.h"

@interface IDPLoadingImageView ()

- (void)loadModel;
- (void)fillFromModel:(IDPImageModel *)model;

@end

@implementation IDPLoadingImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.spinner = nil;
	self.imageView = nil;
	self.model = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPImageModel *)imageModel {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_model, imageModel);
	
	if (IDPModelFinished == imageModel.state) {
		[self fillFromModel:imageModel];
	} else {
		self.imageView.image = nil;
		[self loadModel];
	}
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
	[self.spinner startAnimating];
	
	[self.model load];
}

- (void)fillFromModel:(IDPImageModel *)model {
	self.imageView.image = model.image;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
	
	[self.spinner stopAnimating];
	[self setNeedsDisplay];
}

- (void)modelDidFailToLoad:(id)theModel {
	[self.spinner stopAnimating];
	[self.imageView removeFromSuperview];
}

@end
