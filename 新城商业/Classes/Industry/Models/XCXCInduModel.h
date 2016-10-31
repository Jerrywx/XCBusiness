//
//  XCXCInduModel.h
//  新城商业
//
//  Created by 王潇 on 16/10/28.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCXCInduModel : NSObject

/*
	in_id = 22;
	in_cn = 人工智能;
	second = (
 */

@property (nonatomic, strong) NSString	*in_id;
@property (nonatomic, strong) NSString	*in_cn;
@property (nonatomic, strong) NSArray	*second;

+ (void)loadInduSuccess:(void (^)(NSArray *log, NSArray *sub))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
