//
//  XCNewsModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNewsModel.h"

@implementation XCNewsModel

+ (void)loadWithURL:(NSString *)urlString
			success:(nullable void (^)(NSMutableArray *models))success
			failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"k_id":@"8"};
	
	[[XCNetWorkManager shareManager] postWithURL:@"http://api.xincheng.tv/api/getnews1/" parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		
		NSInteger code = [responseObject[@"errorcode"] integerValue];
		
		if (code == 1000) {
			NSArray *datas = responseObject[@"data"];
			NSMutableArray *models = [NSMutableArray arrayWithCapacity:datas.count];
			
			for (NSDictionary *dict in datas) {
				XCNewsModel *model = [XCNewsModel mj_objectWithKeyValues:dict];
				[models addObject:model];
			}
			
			success(models);
		} else {
			failure(task, nil);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task,
				NSError * _Nullable error) {
		failure(task, nil);
	}];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.title1, self.logo];
}



@end
