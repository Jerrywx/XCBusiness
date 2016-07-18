//
//  XCRightVideo.m
//  新城商业
//
//  Created by 王潇 on 16/7/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCRightVideo.h"

@implementation XCRightVideo

+ (void)loadSuccess:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"v_id" : @"7",
							@"v_t"  : @"2"};
	
	[[XCNetWorkManager shareManager] postWithURL:@"api/getvideo3/"
									  parameters:param
										 success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
											 
											 NSLog(@"RR数据: %@", responseObject);
											 
											 NSInteger errorCode = [responseObject[@"errorcode"] integerValue];
											 if (errorCode == 1000) {
												 NSArray *data = responseObject[@"data"];
												 
												 NSMutableArray *models = [XCRightVideo mj_objectArrayWithKeyValuesArray:data];
												 success(models);
											 }
											 failure(task, nil);
										 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
											 failure(task, error);
										 }];
}

@end
