//
//  XCInduDetialModel.m
//  新城商业
//
//  Created by 王潇 on 16/10/30.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduDetialModel.h"

@implementation XCDetialModel

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.sc_title, self.n_url];
}

@end

@implementation XCInduDetialModel

+ (void)loadInduSuccess:(void (^)(NSArray *log, NSArray *sub))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"kt_id" : @"10",
							@"in_id" : @"46"};

	[[XCNetWorkManager shareManager] postWithURL:_kAPI_InduData parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		NSLog(@"==== %@", responseObject);
		XCResponse *response = [XCResponse initWithJson:responseObject];
		
		if (response.errorcode == XCNetWorkSuccess) {
			NSMutableArray *oneArray = [NSMutableArray array];
			NSMutableArray *twoArray = [NSMutableArray array];
			
			for (NSDictionary *dict in response.data) {
				XCInduDetialModel *model = [XCInduDetialModel mj_objectWithKeyValues:dict];
				if ([model.products55 isKindOfClass:[NSArray class]]) {
					[oneArray addObject:model];
					NSArray *array = [XCDetialModel mj_objectArrayWithKeyValuesArray:model.products55];
					[twoArray addObject:array];
				}
			}
			success(oneArray, twoArray);
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		NSLog(@"==== %@", error);
	}];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.k_cn, self.kinfo_one];
}

@end
