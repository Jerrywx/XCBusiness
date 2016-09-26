//
//  XCNewsDetialModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/26.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNewsDetialModel.h"

@implementation XCNewsDetialModel

+ (void)loadDataSuccess:(void (^)(NSMutableArray *models, id responseObject))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

	NSDictionary *param = @{@"k_id":@"14"};
	
	[[XCNetWorkManager shareManager] getWithURL:@"http://api.xincheng.tv/api/getnews3?k_id=14"
									 parameters:nil
										success:^(NSURLSessionDataTask * _Nullable task,
												  id  _Nullable responseObject) {
											
											NSLog(@"数据: %@", responseObject);
											if ([responseObject[@"errorcode"] integerValue] == 1000) {
												NSDictionary *dict = responseObject[@"data"][0];
												XCNewsDetialModel *model = [XCNewsDetialModel mj_objectWithKeyValues:dict];
												NSLog(@"%@", model);
												success(model, responseObject[@"data"]);
											}
											
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		
	}];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@ - %@", self.k_cn, self.k_en, self.k_city];
}

@end
