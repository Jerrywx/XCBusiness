//
//  XCBussVideoModel.m
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussVideoModel.h"

@implementation XCBussVideoModel

+ (void)loadData {
//	http://api.xincheng.tv/api/getcontent/?cr_p=1
	NSDictionary *param = @{@"cr_p":@"1"};
	[[XCNetWorkManager shareManager] getWithURL:@"http://api.xincheng.tv/api/getcontent"
									 parameters:param
										success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
											NSLog(@"成功: %@", responseObject);
										} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
											NSLog(@"失败: %@", error);
										}];
	
//	[[XCNetWorkManager shareManager] postWithURL:@"http://api.xincheng.tv/api/getcontent" parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
//		NSLog(@"成功: %@", responseObject);
//	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//		NSLog(@"失败: %@", error);
//	}];
	
}

@end
