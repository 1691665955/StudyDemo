//
//  TestRuntimeModel.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/17.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestRuntimeModel.h"
#import <objc/runtime.h>
@interface TestRuntimeModel()<NSCoding>
@property (nonatomic ,copy)NSString *innerText;
@end

@implementation TestRuntimeModel

//测试交换实例方法
- (void)gotoSchool {
    NSLog(@"上学啦");
}
- (void)goHome {
    NSLog(@"回家啦");
}

//测试交换类方法
+ (void)sleep {
    NSLog(@"睡觉啦");
}
+ (void)swimming {
    NSLog(@"游泳啦");
}

//打印属性列表
- (void)propertyList {
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property-->%@",[NSString stringWithUTF8String:propertyName]);
    }
    free(propertyList);
}

//打印方法列表
- (void)methodList {
    unsigned int count;
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method-->%@",NSStringFromSelector(method_getName(method)));
    }
    free(methodList);
}

//打印成员变量方法
- (void)ivarList {
    unsigned int count;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar-->%@",[NSString stringWithUTF8String:ivarName]);
    }
    free(ivarList);
}

//打印协议列表
- (void)protocolList {
    unsigned int count;
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Protocol *myProtocol = protocolList[i];
        const char *protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol-->%@",[NSString stringWithUTF8String:protocolName]);
    }
    free(protocolList);
}

//字典转模型
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.innerText = @"我是内部变量";
        NSMutableArray *keys = [NSMutableArray array];
        
        //获取类的属性名称
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        for (unsigned int i=0; i<count; i++) {
            objc_property_t property = propertyList[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            [keys addObject:propertyName];
            
            //获取属性的类型
            //            NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        }
        free(propertyList);
        
        //根据属性名称给属性赋值
        for (NSString *key in keys) {
            if (![dic valueForKey:key]) {
                continue;
            } else {
                [self setValue:[dic valueForKey:key] forKey:key];
            }
        }
    }
    return self;
}

/**
 设置属性名和属性值
 @param name 属性名
 @param value 属性值
 */
- (void)setExtraPropertyWithPropertyName:(NSString *)name perportyValue:(id)value {
    objc_setAssociatedObject(self, [name UTF8String], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 通过属性名拿到属性值
 @param name 属性名
 @return 返回属性值
 */
- (id)getExtraPropertyWithPropertyName:(NSString *)name {
    return objc_getAssociatedObject(self, [name UTF8String]);
}

/**
 交换实例方法：交换后调用originMethod会执行currentMethod的方法，调用currentMethod会执行originMethod的方法
 */
- (void)swapInstanceMethod:(SEL)originMethod currentMethod:(SEL)currentMethod {
    Method firstMethod = class_getInstanceMethod([self class], originMethod);
    Method secondMethod = class_getInstanceMethod([self class], currentMethod);
    method_exchangeImplementations(firstMethod, secondMethod);
}

/**
 交换类方法：交换后调用originMethod会执行currentMethod的方法，调用currentMethod会执行originMethod的方法
 */
+ (void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod {
    Method firstMethod = class_getClassMethod([TestRuntimeModel class], originMethod);
    Method secondMethod = class_getClassMethod([TestRuntimeModel class], currentMethod);
    method_exchangeImplementations(firstMethod, secondMethod);
}

//本地化存储时可用runtime来coder和decoder属性
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int outCount;
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}
@end
