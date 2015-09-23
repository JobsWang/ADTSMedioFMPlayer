//
//  NSArray+SO.m
//  Song1-iOS-v3
//
//  Created by FENGWANG on 15/7/1.
//  Copyright (c) 2015年 song1.com. All rights reserved.
//

#import "NSArray+SO.h"

@implementation NSArray(SO)
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length]>0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
-(NSString*)toJSONString{
     NSData *jsonData = [self toJSONData];
    //使用这个方法的返回，我们就可以得到想要的JSON串
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    if (jsonString.length>0) {
        return jsonString;
    }
    return nil;
}

@end
