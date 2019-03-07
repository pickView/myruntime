//
//  OneViewController.m
//  runtimeStudy
//
//  Created by 邹瑞 on 2017/8/23.
//  Copyright © 2017年 Changxu Chou. All rights reserved.
//

#import "OneViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "Tool.h"

@interface OneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (strong, nonatomic) Person *p;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _p = [[Person alloc] init];
    _p.name = @"Changxu";
    _oneLab.text = _p.name;
}

- (IBAction)btnClick:(id)sender {    //修改属性值

//    [self sayName];
//    [self printProperty];
//    [self printIvar];
    [self printMethod];
}

- (void)sayName{
    unsigned int countNum = 0;
    Ivar *propertyList = class_copyIvarList([Person class], &countNum);
    
    for (int i=0; i<countNum; i++) {
        const char *varName = ivar_getName(propertyList[i]);
        NSString *pName = [NSString stringWithUTF8String:varName];
        if ([pName isEqualToString:@"_name"]) {
            object_setIvar(self.p, propertyList[i], @"Changxu Chou");
        }
    }
    _oneLab.text = _p.name;
}

- (IBAction)addBtnClick:(id)sender {
    //添加方法
    [self sayFrom];
    
}

- (void)sayFrom{
    class_addMethod([self.p class], @selector(addressFrom), (IMP)personAncestralHome, "v@:");
    if ([self.p respondsToSelector:@selector(addressFrom)]) {
        [self.p performSelector:@selector(addressFrom)];
    }
    _oneLab.text = @"i am from NanTong";
}

- (void)addressFrom{
    
};

void personAncestralHome(id self,SEL _cmd){
    NSLog(@"i am from NanTong");
}

- (IBAction)exchangeMethod:(id)sender {
    Method m1 = class_getInstanceMethod([Person class], @selector(sayName));
    Method m2 = class_getInstanceMethod([Person class], @selector(saySex));
    
    method_exchangeImplementations(m1, m2);
    
    _oneLab.text = [_p saySex];
}

- (IBAction)headOff:(id)sender {
    Method m1 = class_getInstanceMethod([Person class], @selector(sayName));
    Method m2 = class_getInstanceMethod([Tool class], @selector(changeMethod));
    
    method_exchangeImplementations(m1, m2);
    _oneLab.text = [_p sayName];
}

/**
 打印所有属性
 */
- (void)printProperty{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    for (unsigned int i =0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);

        NSLog(@"property--------%@",[NSString stringWithUTF8String:propertyName]);
    }
}

/**
 打印成员变量
 */
- (void)printIvar{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (unsigned i=0; i<count; i++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSLog(@"ivar---------%@",[NSString stringWithUTF8String:ivarName]);
    }
}

/**
 打印方法
 */
- (void)printMethod{
    unsigned int count;
    Method *methodList = class_copyMethodList([Person class], &count);
    for (unsigned int i=0; i<count; i++) {
        NSLog(@"methodName-------%@",NSStringFromSelector(method_getName(methodList[i])));
    }
}


@end
