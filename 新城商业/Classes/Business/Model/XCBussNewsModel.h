//
//  XCBussNewsModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {				// 数据类型
	XCBusinessTypeNews		= 1,		// 新闻
	XCBusinessTypeVideo		= 2,		// 视频
	XCBusinessTypePic		= 3,		// 图库
} XCBusinessType;

@interface XCBussNewsModel : NSObject

@property (nonatomic, strong) NSString	*nvg_id;		// 信息ID
@property (nonatomic, strong) NSString	*title1;		// 主标题
@property (nonatomic, strong) NSString	*title2;		// 副标题
@property (nonatomic, strong) NSString	*in_id;			// 行业ID
@property (nonatomic, strong) NSString	*in_cn;			// 行业名称
@property (nonatomic, strong) NSString	*date;			// 发布时间
@property (nonatomic, strong) NSString	*nvg_t;			// 信息类型 (1为新闻、2为视频、3为图库)
@property (nonatomic, strong) NSString	*logo;			// 缩略图
@property (nonatomic, strong) NSString	*k_id;			// 关键词ID
@property (nonatomic, strong) NSString	*nvg_url;		// 链接


/// 新城商业首页 左侧视频数据
+ (void)loadWithURL:(NSString *)urlString
			success:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// 新城商业首页 右侧数据
+ (void)loadChannel:(NSString *)urlString
			success:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
