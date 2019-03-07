//
//  Person.h
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/23.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *sex;
- (NSString *)sayName;
- (NSString *)saySex;

@end
