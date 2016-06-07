//
//  XCNetWorkManager.m
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNetWorkManager.h"


@interface XCNetWorkManager ()
/// 网络管理对象
@property (nonatomic, strong) AFHTTPSessionManager	*sharedSessionManager;
@end


@implementation XCNetWorkManager

+ (instancetype)shareManager {
	// 利用(once)创建单例
	static XCNetWorkManager *shareInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		shareInstance = [[XCNetWorkManager alloc] init];
	});
	return shareInstance;
}

- (instancetype)init {
	
	if (self = [super init]) {
		// 1. 网络请求配置
		NSURLSessionConfiguration *defConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
		// 2. 创建网络管理对象
		_sharedSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:defConfig];
		// 3. 设置网络请求超时时长 20s
		[[_sharedSessionManager requestSerializer] setTimeoutInterval:20];
		// 4. 设置网络请求数据格式
		_sharedSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
															   @"application/json",
															   @"text/json",
															   @"text/javascript",
															   @"text/plain",
															   @"text/html", nil];
	}
	return self;
}

#pragma mark - 
#pragma mark - GET Methond
- (void)getWithURL:(NSString *)url
		parameters:(NSDictionary *)parameters
		   success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
		   failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
	
	[self.sharedSessionManager GET:url
						parameters:parameters
						  progress:nil
						   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
							   success(task, responseObject);
						   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
							   failure(task, error);
						   }];
}

- (void)getWithURL:(NSString *)url
		parameters:(NSDictionary *)parameters
		  progress:(void (^)(NSProgress * _Nonnull))downloadProgress
		   success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
		   failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
	
	[self.sharedSessionManager GET:url 
						parameters:parameters 
						  progress:^(NSProgress * _Nonnull progress) {
							  downloadProgress(progress);
						  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
							  success(task, responseObject);
						  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
							  failure(task, error);
						  }];
}

#pragma mark - POST Methond
- (void)postWithURL:(NSString *)url
		 parameters:(NSDictionary *)parameters
			success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
			failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
	
	[self.sharedSessionManager POST:url
						 parameters:parameters
						   progress:nil 
							success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
								success(task, responseObject);
							} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
								failure(task, error);
							}];
}


- (void)postWithURL:(NSString *)url
		 parameters:(NSDictionary *)parameters
		   progress:(void (^)(NSProgress * _Nonnull))uploadProgress
			success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
			failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
	
	[self.sharedSessionManager POST:url
						 parameters:parameters
						   progress:^(NSProgress * _Nonnull progress) {
							   uploadProgress(progress);
						   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
							   success(task, responseObject);
						   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
							   failure(task, error);
						   }];
}

#pragma mark -



@end















