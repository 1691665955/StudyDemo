//
//  UIWebView_JSExport.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSTestDelegate <JSExport>
//打开关闭手电筒
- (void)lightOperate:(JSValue *)value;

//发送警告
- (void)showAlert:(JSValue *)value;
@end

@interface UIWebView_JSExport : UIViewController<JSTestDelegate>
@property (nonatomic ,strong)JSContext *jsContext;
@end
