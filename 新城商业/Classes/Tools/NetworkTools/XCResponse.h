//
//  XCResponse.h
//  新城商业
//
//  Created by 王潇 on 16/10/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
	XCNetWorkSuccess	=	1000,
	XCNetWorkError,
} XCNetWorkErrorCode;

@interface XCResponse : NSObject

//data =     ();
//errorcode = 1000;
//status = 1;

/// 数据内容
@property (nonatomic, strong) id		data;
/// 状态
@property (nonatomic, assign) NSInteger status;
/// 错误码 1000 成功
@property (nonatomic, assign) XCNetWorkErrorCode errorcode;

/**
 使用 json 初始化  json 为字典类型
 @param json json 字典
 @return 返回 XCResponse对象
 */
+ (instancetype)initWithJson:(id)json;

@end
