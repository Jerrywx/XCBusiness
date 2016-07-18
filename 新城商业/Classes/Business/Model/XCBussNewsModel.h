//
//  XCBussNewsModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCBussNewsModel : NSObject

//nvg_id = 5;
//title1 = 虚拟现实VR直播来了;
//title2 = 这家VR直播领域的全球老大，你必须了解！;
//in_id = 44;
//in_cn = 虚拟现实直播;
//date = 2016/6/5 11:30:22;
//nvg_t = 1;
//logo = http://pic.xincheng.tv/n_logo/2016/0605/27541f04c1dca966020c44b8.jpg;
//nvg_url = http://api.xincheng.tv/api/getnews2/?n_id=5;
//k_id = 8;

@property (nonatomic, strong) NSString	*nvg_id;
@property (nonatomic, strong) NSString	*title1;
@property (nonatomic, strong) NSString	*title2;
@property (nonatomic, strong) NSString	*in_id;
@property (nonatomic, strong) NSString	*in_cn;
@property (nonatomic, strong) NSString	*date;
@property (nonatomic, strong) NSString	*nvg_t;
@property (nonatomic, strong) NSString	*logo;
@property (nonatomic, strong) NSString	*k_id;
@property (nonatomic, strong) NSString	*nvg_url;


+ (void)loadWithURL:(NSString *)urlString
			success:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)loadChannel:(NSString *)urlString
			success:(nullable void (^)(NSMutableArray *models))success
			failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
