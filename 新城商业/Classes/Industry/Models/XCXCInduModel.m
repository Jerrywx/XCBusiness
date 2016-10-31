//
//  XCXCInduModel.m
//  新城商业
//
//  Created by 王潇 on 16/10/28.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCXCInduModel.h"

@implementation XCXCInduModel

+ (void)loadInduSuccess:(void (^)(NSArray *log, NSArray *sub))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"In_p" : @"25"};
	
	[[XCNetWorkManager shareManager] postWithURL:_kAPI_InduMenu parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		
		XCResponse *response = [XCResponse initWithJson:responseObject];
		
		NSMutableArray *logArray = [NSMutableArray array];
		NSMutableArray *subArray = [NSMutableArray array];
		for (NSDictionary *dict in response.data) {
			XCXCInduModel *model = [XCXCInduModel mj_objectWithKeyValues:dict];
			if ([model.second isKindOfClass:[NSArray class]]) {
				[logArray addObject:model];
				NSArray *array = [XCXCInduModel mj_objectArrayWithKeyValuesArray:model.second];
				[subArray addObject:array];
			}
		}
		success(logArray, subArray);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
	}];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.in_id, self.in_cn];
}


@end
