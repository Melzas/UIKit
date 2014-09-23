//
//  UICollectionView+IDPCellLoading.m
//  Tixxit
//
//  Created by Anton on 23.06.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "UICollectionView+IDPCellLoading.h"

#import "UINib+IDPExtensions.h"

@implementation UICollectionView (IDPCellLoading)

- (void)registerCell:(Class)theClass {
	NSString *className = NSStringFromClass(theClass);
	UINib *nibForCell = [UINib nibWithNibName:className bundle:[NSBundle mainBundle]];
	
	[self registerNib:nibForCell forCellWithReuseIdentifier:className];
}

- (id)dequeueCell:(Class)theClass forIndexPath:(NSIndexPath *)indexPath {
	return [self dequeueCell:theClass forIndexPath:indexPath withOwner:nil];
}

- (id)dequeueCell:(Class)theClass forIndexPath:(NSIndexPath *)indexPath withOwner:(id)owner {
	NSString *reuseIdentifier = NSStringFromClass(theClass);
	
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:reuseIdentifier
																 forIndexPath:indexPath];
    if (nil == cell) {
        cell = [UINib loadClass:theClass withOwner:owner];
    }
    
    return cell;
}

@end
