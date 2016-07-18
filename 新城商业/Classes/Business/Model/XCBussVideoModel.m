//
//  XCBussVideoModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussVideoModel.h"

@implementation XCBussVideoModel

+ (void)loadWithURL:(NSString *)urlString
			success:(nullable void (^)(NSMutableArray *models))success
			failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	[[XCNetWorkManager shareManager] postWithURL:@"http://api.xincheng.tv/api/getv_b/" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {

		NSInteger code = [responseObject[@"errorcode"] integerValue];
		 if (code == 1000) {
			 NSArray *datas = responseObject[@"data"];
			 NSMutableArray *models = [NSMutableArray arrayWithCapacity:datas.count];
			 
			 for (NSDictionary *dict in datas) {
				 XCBussVideoModel *model = [XCBussVideoModel mj_objectWithKeyValues:dict];
				 [models addObject:model];
			 }
			 
			 success(models);
		 } else {
			 failure(task, nil);
		 }
		
	 } failure:^(NSURLSessionDataTask * _Nullable task, 
				 NSError * _Nullable error) {
		failure(task, error);
	 }];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.vb_title, self.vb_logo];
}


@end
