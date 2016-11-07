//
//  XCInduService.m
//  新城商业
//
//  Created by 王潇 on 16/11/6.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduService.h"
#import "XCXCInduModel.h"
#import "XCInduDetialModel.h"

@implementation XCInduService

+ (void)loadDataInduID:(NSString *)IndustryId
			  classify:(NSString *)classId
			   Success:(void (^)(NSArray *log, NSArray *sub, NSArray *log2, NSArray *sub2))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

	[XCXCInduModel loadInduSuccess:^(NSArray *log, NSArray *sub) {
		NSLog(@"数据: %@", log);
		NSLog(@"数据: %@", sub);
		
		if (sub.count > 0) {
			NSString *IndustryId = [[[sub firstObject]firstObject] in_id];
			
			[XCInduDetialModel loadInduID:IndustryId classify:classId Success:^(NSArray *logd, NSArray *subd) {
				success(log, sub, logd, subd);
				NSLog(@"数据: %@", logd);
				NSLog(@"数据: %@", subd);
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				failure(task, error);
			}];
		}
		
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		failure(task, error);
	}];
}


@end
