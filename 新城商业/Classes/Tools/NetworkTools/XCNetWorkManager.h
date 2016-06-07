//
//  XCNetWorkManager.h
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNetWorkManager : NSObject

/**
 *  创建网络管理单粒
 *
 *  @return 返回网络管理单粒
 */
+ (_Nullable instancetype)shareManager;


#pragma mark -
#pragma mark - GET Methond

- (void)getWithURL:(NSString *_Nullable)url
		parameters:(NSDictionary *_Nullable)parameters
		   success:(nullable void (^)(NSURLSessionDataTask *_Nullable task, id _Nullable responseObject))success
		   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)getWithURL:(NSString *_Nullable)url
		parameters:(NSDictionary *_Nullable)parameters
		  progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
		   success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
		   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

#pragma mark - POST Methond
- (void)postWithURL:(NSString *_Nullable)url
		 parameters:(NSDictionary *_Nullable)parameters
			success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
			failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


- (void)postWithURL:(NSString *_Nullable)url
		 parameters:(NSDictionary *_Nullable)parameters
		   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
			success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
			failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;



@end
