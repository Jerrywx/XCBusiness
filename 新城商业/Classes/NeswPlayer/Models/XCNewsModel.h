//
//  XCNewsModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNewsModel : NSObject

/*
	logo = http://pic.xincheng.tv/n_logo/2016/0605/27541f04c1dca966020c44b8.jpg;
	title1 = 虚拟现实VR直播来了;
	nvg_t = 1;
	nvg_id = 5;
	title2 = 这家VR直播领域的全球老大，你必须了解！;
 */

@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title1;
@property (nonatomic, strong) NSString *nvg_t;
@property (nonatomic, strong) NSString *nvg_id;
@property (nonatomic, strong) NSString *title2;


+ (void)loadWithURL:(NSString *)urlString
			success:(nullable void (^)(NSMutableArray *models))success
			failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
