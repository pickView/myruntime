//
//  NSArray+safe.m
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/30.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import "NSArray+safe.h"

@implementation NSArray (safe)
-(id)objectAtIndexCheck:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end
