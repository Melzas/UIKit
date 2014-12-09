//
//  IDPLoadingImageView.m
//  IDPKit
//
//  Created by Anton Rayev on 5/21/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPLoadingImageView.h"

#import "UIView+IDPExtensions.h"

#import "IDPPropertyMacros.h"
#import "IDPImageModel.h"

@interface IDPLoadingImageView ()

- (void)fillFromModel:(IDPImageModel *)model;

@end

@implementation IDPLoadingImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.spinner = nil;
	self.imageView = nil;
	self.placeholder = nil;
	self.model = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPImageModel *)imageModel {
	[self setModel:imageModel loadLater:NO];
}

- (void)setModel:(IDPImageModel *)imageModel loadLater:(BOOL)loadLater {
	IDPImageModel *previousModel = _model;
	
	if (IDPModelFailed == previousModel.state) {
		if (nil != self.placeholder) {
			self.imageView.image = nil;
		} else {
			[self addSubview:self.imageView];
		}
	}
	
	if (_model != imageModel) {
		[_model removeObserver:self];
		[_model release];
		_model = [imageModel retain];
		
		// IDPLoadingImageView always a top-level observer
		[_model insertObserver:self atIndex:0];
	}
	
	if (IDPModelFinished == imageModel.state) {
		[self fillFromModel:imageModel];
		[self.spinner stopAnimating];
	} else {
		if (kIDPImageSourceFileURLUpdate != imageModel.imageSource) {
			self.imageView.image = nil;
		}
		
		if (!loadLater) {
			[self loadModel];
		}
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
	
	if (nil != self.placeholder) {
		self.imageView.image = self.placeholder;
	} else {
		[self.imageView removeFromSuperview];
	}
}

- (void)modelDidUnload:(id)model {
	if (![self isOnScreen]) {
		[self fillFromModel:model];
	}
}

@end
