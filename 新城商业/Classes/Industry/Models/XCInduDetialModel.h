//
//  XCInduDetialModel.h
//  新城商业
//
//  Created by 王潇 on 16/10/30.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XCDetialModel : NSObject

@property (nonatomic, strong) NSString	*n_logo;
@property (nonatomic, strong) NSString	*n_id;
@property (nonatomic, strong) NSString	*n_url;
@property (nonatomic, strong) NSString	*n_summary;
@property (nonatomic, strong) NSString	*sc_id;
@property (nonatomic, strong) NSString	*sc_title;
@property (nonatomic, strong) NSString	*sc_type;

@property (nonatomic, strong) NSString	*title;
@property (nonatomic, assign) BOOL		isFirst;
@property (nonatomic, assign) CGFloat	height;

@end


@interface XCInduDetialModel : NSObject

@property (nonatomic, strong) NSString	*k_logo;
@property (nonatomic, strong) NSString	*product_count;
@property (nonatomic, strong) NSString	*ce_count;
@property (nonatomic, strong) NSString	*k_cn;
@property (nonatomic, strong) NSArray	*products;
@property (nonatomic, strong) NSString	*project_count;
@property (nonatomic, strong) NSString	*k_id;
@property (nonatomic, strong) NSString	*tech_count;
@property (nonatomic, strong) NSString	*kinfo_one;
@property (nonatomic, strong) NSString	*kinfo_country;
@property (nonatomic, assign) BOOL		isOpen;

/**
 加载行业矩阵行业

 @param IndustryId 行业ID
 @param classId 类别ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loadInduID:(NSString *)IndustryId
		  classify:(NSString *)classId
		   Success:(void (^)(NSArray *logd, NSArray *subd))success
		   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 加载行业矩阵行业
 
 @param IndustryId 行业ID
 @param classId 类别ID
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loadDataID:(NSString *)IndustryId
		  classify:(NSString *)classId
		   Success:(void (^)(NSArray *logd, NSArray *subd, NSString * Id))success
		   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
