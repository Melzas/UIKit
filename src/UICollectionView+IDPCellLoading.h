//
//  UICollectionView+IDPCellLoading.h
//  Tixxit
//
//  Created by Anton on 23.06.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (IDPCellLoading)

- (void)registerCell:(Class)theClass;

- (id)dequeueCell:(Class)theClass forIndexPath:(NSIndexPath *)indexPath;
- (id)dequeueCell:(Class)theClass forIndexPath:(NSIndexPath *)indexPath withOwner:(id)owner;

@end
