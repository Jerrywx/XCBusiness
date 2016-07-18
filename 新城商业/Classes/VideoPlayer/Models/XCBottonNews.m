//
//  XCBottonNews.m
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBottonNews.h"

@implementation XCBottonNews

+ (void)loadSuccess:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"v_id" : @"7"};
	
	[[XCNetWorkManager shareManager] postWithURL:@"api/getvideo2/"
									  parameters:param
										 success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
										
											 NSInteger errorCode = [responseObject[@"errorcode"] integerValue];
											 
											 if (errorCode == 1000) {
												 NSArray *data = responseObject[@"data"];
												 
												 NSMutableArray *models = [XCBottonNews mj_objectArrayWithKeyValuesArray:data];
												 success(models);
											 }
											 failure(task, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		failure(task, error);
	}];
}

@end
