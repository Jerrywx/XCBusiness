//
//  XCInduService.h
//  新城商业
//
//  Created by 王潇 on 16/11/6.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCInduService : NSObject

+ (void)loadDataInduID:(NSString *)IndustryId
			  classify:(NSString *)classId
			   Success:(void (^)(NSArray *log, NSArray *sub, NSArray *log2, NSArray *sub2))success
			   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
