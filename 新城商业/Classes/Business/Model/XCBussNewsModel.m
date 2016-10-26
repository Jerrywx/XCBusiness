//
//  XCBussNewsModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussNewsModel.h"

@implementation XCBussNewsModel

+ (void)loadWithURL:(NSString *)urlString
			success:(nullable void (^)(NSMutableArray *models))success
			failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"cr_p":@"2"};
	[[XCNetWorkManager shareManager] postWithURL:_kAPI_BusinessLeftVideo parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		
		XCResponse *response = [XCResponse initWithJson:responseObject];
		if (response.errorcode == XCNetWorkSuccess) {
			
			NSArray *datas = response.data;
			NSMutableArray *models = [NSMutableArray arrayWithCapacity:datas.count];
			for (NSDictionary *dict in datas) {
				XCBussNewsModel *model = [XCBussNewsModel mj_objectWithKeyValues:dict];
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


+ (void)loadChannel:(NSString *)urlString
			success:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"cr_p"	:@"2",
							@"in_id":@"23"};
	
	[[XCNetWorkManager shareManager] postWithURL:@"api/getchannellist1/" parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		
		NSInteger code = [responseObject[@"errorcode"] integerValue];

		if (code == 1000) {
			NSArray *datas = responseObject[@"data"];
			NSMutableArray *models = [NSMutableArray arrayWithCapacity:datas.count];
			
			for (NSDictionary *dict in datas) {
				XCBussNewsModel *model = [XCBussNewsModel mj_objectWithKeyValues:dict];
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
	return [NSString stringWithFormat:@"%@ - %@", self.title1, self.title2];
}

@end
