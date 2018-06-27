//
//  NSDictionary+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "NSDictionary+MZTool.h"

@implementation NSDictionary (MZTool)
- (NSDictionary *)dictionaryForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary *)value;
        }
    }
    return @{};
}

- (NSArray *)arrayForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            return (NSArray *)value;
        }
    }
    return @[];
}

- (NSString *)stringForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return (NSString *)value;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value stringValue];
        }
    }
    return @"";
}

- (BOOL)boolForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            if ([(NSString *)value integerValue] == 0) {
                return NO;
            }
            return YES;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            if ([(NSNumber *)value integerValue] == 0) {
                return NO;
            }
            return YES;
        }
    }
    return NO;
}

- (NSInteger)intForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value integerValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value integerValue];
        }
    }
    return 0;
}

- (double)doubleForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value doubleValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value doubleValue];
        }
    }
    return 0.00;
}

- (NSString *)RMBForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString *rmb = (NSString *)value;
            if ([rmb hasSuffix:@".00"]) {
                rmb = [rmb stringByReplacingOccurrencesOfString:@".00" withString:@""];
            }
            return [NSString stringWithFormat:@"%@元",rmb];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@元",[(NSNumber *)value stringValue]];
        }
    }
    return @"0元";
}
- (NSString *)RMBCodeForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString *rmb = (NSString *)value;
            if ([rmb hasSuffix:@".00"]) {
                rmb = [rmb stringByReplacingOccurrencesOfString:@".00" withString:@""];
            }
            return [NSString stringWithFormat:@"¥%@",rmb];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"¥%@",[(NSNumber *)value stringValue]];
        }
    }
    return @"¥0";
}
- (NSString *)dateForKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSTimeInterval timeString = [(NSString *)value doubleValue];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString];
            return [formatter stringFromDate:date];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            NSTimeInterval timeString = [(NSNumber *)value doubleValue];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString];
            return [formatter stringFromDate:date];
        }
    }
    return @"0000-00-00";
}
@end
