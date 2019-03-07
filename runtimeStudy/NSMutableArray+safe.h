//
//  NSMutableArray+safe.h
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/30.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (safe)

- (id)objectAtIndexCheck:(NSUInteger)index;

- (void)addObjectCheck:(id)anObject;

- (void)insertObjectCheck:(id)anObject atIndex:(NSUInteger)index;

- (void)removeObjectAtIndexCheck:(NSUInteger)index;

- (void)replaceObjectAtIndexCheck:(NSUInteger)index withObject:(id)anObject;


@end
