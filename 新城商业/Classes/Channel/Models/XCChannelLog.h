//
//  XCChannelLog.h
//  新城商业
//
//  Created by 王潇 on 16/7/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic, strong) NSString	*ptpe_id;
@property (nonatomic, strong) NSString	*ptpe_t;
@property (nonatomic, strong) NSString	*ptpe_cn;
@property (nonatomic, strong) NSString	*ptpe_url;

@end

@interface Industry : NSObject

@property (nonatomic, strong) NSString	*k_id;
@property (nonatomic, strong) NSString	*k_cn;
@property (nonatomic, strong) NSString	*ki_id;
@property (nonatomic, strong) NSArray	*ptpe;

@end

@interface XCChannelLog : NSObject

/*
 {
	kt_id = 10;
	in_cn = 火箭发射;
	keywords = (
 {
	ki_id = 14;
	k_id = 18;
	ptpe = ( );
 k_cn = 太空探索技术公司;
	}
 
 */

@property (nonatomic, strong) NSString	*kt_id;
@property (nonatomic, strong) NSString	*in_cn;
@property (nonatomic, strong) NSString	*channel_name;
@property (nonatomic, strong) NSArray	*keywords;

+ (void)loadDataSuccess:(void (^)(NSMutableArray *models))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
