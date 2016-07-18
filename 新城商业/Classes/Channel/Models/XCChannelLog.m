//
//  XCChannelLog.m
//  新城商业
//
//  Created by 王潇 on 16/7/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCChannelLog.h"

@implementation XCChannelLog

+ (void)loadDataSuccess:(void (^)(NSMutableArray *models))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"in_id" : @"23",
							@"kt_id" : @"10"};
	
	[[XCNetWorkManager shareManager] postWithURL:@"api/getchannellist2/" parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {

		NSInteger code = [responseObject[@"errorcode"] integerValue];
		if (code == 1000) {
			
			// 1. XCChannelLog 字典转模型
			NSMutableArray *models = [self mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
			
			// 2. Industry 字典转模型
			for (XCChannelLog *model in models) {
				
				// 2.1
				NSMutableArray *industry = [Industry mj_objectArrayWithKeyValuesArray:model.keywords];
				model.keywords = industry.copy;
				
				// 2.2 Company 字典转模型
				for (Industry *indus in model.keywords) {
					NSMutableArray *company = [Company mj_objectArrayWithKeyValuesArray:indus.ptpe];
					indus.ptpe = company.copy;
				}
			}
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		
	}];
	
}

- (NSString *)description {
	
	return [NSString stringWithFormat:@"%@ - %@ - %@ = %@", self.kt_id, self.in_cn, self.channel_name, self.keywords];
}


@end


@implementation Company

- (NSString *)description {
	
	return [NSString stringWithFormat:@"%@ - %@", self.ptpe_cn, self.ptpe_url];
}

@end



@implementation Industry

- (NSString *)description {
	
	return [NSString stringWithFormat:@"%@ - %@ - %@", self.k_id, self.k_cn, self.ptpe];
}

@end


