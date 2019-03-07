//
//  NSArray+safe.h
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/30.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (safe)
- (id)objectAtIndexCheck:(NSUInteger)index;
@end
