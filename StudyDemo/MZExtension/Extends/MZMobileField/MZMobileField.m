//
//  MZMobileField.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/9/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZMobileField.h"
#import "MZMobileFieldDelegte.h"
@interface MZMobileField()
@property (nonatomic, strong) MZMobileFieldDelegte *mzDelegate;
@end

@implementation MZMobileField
- (instancetype)init {
    self = [super init];
    if (self) {
        self.mzDelegate = [[MZMobileFieldDelegte alloc] init];
        self.delegate = self.mzDelegate;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)setOriginText:(NSString *)originText {
    self.text = [self parseString:originText];
}

- (NSString *)originText {
    return [self noneSpaseString:self.text];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mzDelegate = [[MZMobileFieldDelegte alloc] init];
        self.delegate = self.mzDelegate;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.mzDelegate = [[MZMobileFieldDelegte alloc] init];
        self.delegate = self.mzDelegate;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

-(NSString*)noneSpaseString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)parseString:(NSString*)string {
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if (mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
        
    }
    return  mStr;
}
@end
