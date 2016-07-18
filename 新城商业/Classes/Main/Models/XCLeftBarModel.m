//
//  XCLeftBarModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCLeftBarModel.h"


NSString * const kChannelKey = @"channelKey";
@implementation XCLeftBarModel

+ (void)loadModelsuccess:(void (^)(NSArray *models))success
				 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"In_p" : @(0)};
	
	[[XCNetWorkManager shareManager] postWithURL:@"http://api.xincheng.tv/api/getchannellist/" parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		NSInteger code = [responseObject[@"errorcode"] integerValue];
		if (code == 1000) {
			[self storeChannel:responseObject[@"data"]];
			success(responseObject[@"data"]);
		} else {
			success([self getChannel]);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		NSArray *array = [self getChannel];
		if (array) {
			success(array);
		} else {
			failure(task, error);
		}
		NSLog(@"数据BAR - 失败");
	}];
}

+ (void)storeChannel:(NSArray *)channels{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:channels forKey:kChannelKey];
	[defaults synchronize];
}

+ (NSArray *)getChannel {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return (NSArray *)[defaults objectForKey:kChannelKey];
}

@end
