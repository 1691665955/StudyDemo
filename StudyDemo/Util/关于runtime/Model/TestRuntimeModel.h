//
//  TestRuntimeModel.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/17.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRuntimeModel : NSObject
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *age;
@property (nonatomic ,copy)NSString *sex;
@property (nonatomic ,copy)NSString *phoneNumber;

//测试交换实例方法
- (void)gotoSchool;
- (void)goHome;

//测试交换类方法
+ (void)sleep;
+ (void)swimming;

//打印属性列表
- (void)propertyList;

//打印方法列表
- (void)methodList;

//打印成员变量方法
- (void)ivarList;

//打印协议列表
- (void)protocolList;


//字典转模型
- (instancetype)initWithDictionary:(NSDictionary *)dic;

//使用关联对象动态添加属性
/**
 设置属性名和属性值
 @param name 属性名
 @param value 属性值
 */
- (void)setExtraPropertyWithPropertyName:(NSString *)name perportyValue:(id)value;


/**
 通过属性名拿到属性值
 @param name 属性名
 @return 返回属性值
 */
- (id)getExtraPropertyWithPropertyName:(NSString *)name;

/**
 交换实例方法：交换后调用originMethod会执行currentMethod的方法，调用currentMethod会执行originMethod的方法
 */
- (void)swapInstanceMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

/**
 交换类方法：交换后调用originMethod会执行currentMethod的方法，调用currentMethod会执行originMethod的方法
 */
+ (void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;
@end
