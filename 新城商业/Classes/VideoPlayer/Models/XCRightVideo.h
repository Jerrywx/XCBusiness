//
//  XCRightVideo.h
//  新城商业
//
//  Created by 王潇 on 16/7/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCRightVideo : NSObject

/*
 logo = http://pic.xincheng.tv/n_logo/2016/0605/27541f04c1dca966020c44b8.jpg;
	n_url = http://api.xincheng.tv/api/getnews2/?n_id=5;
	title1 = 虚拟现实VR直播来了;
	title2 = 这家VR直播领域的全球老大，你必须了解！;
	norv_id = 5;
	norv_type = 1;
 */

@property (nonatomic, strong) NSString	*logo;
@property (nonatomic, strong) NSString	*url;
@property (nonatomic, strong) NSString	*title1;
@property (nonatomic, strong) NSString	*title2;
@property (nonatomic, strong) NSString	*norv_id;
@property (nonatomic, strong) NSString	*norv_type;


+ (void)loadSuccess:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
