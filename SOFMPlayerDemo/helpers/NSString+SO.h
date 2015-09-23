//
//  NSString+SO.h
//  Song1-iOS-v3
//
//  Created by xserver on 15/4/15.
//  Copyright (c) 2015年 song1.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SO)
- (NSURL *)toURL;
@end

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
@interface NSString (dict)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
-(NSDictionary *)JsonStringToDictionary;

@end



