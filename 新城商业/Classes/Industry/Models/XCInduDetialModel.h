//
//  XCInduDetialModel.h
//  新城商业
//
//  Created by 王潇 on 16/10/30.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDetialModel : NSObject

/*
 n_logo = ;
 n_id = 0;
 n_url = http://api.xincheng.tv/api/getnews2/?n_id=0;
 n_summary = ;
 sc_id = 11;
 sc_title = Google Cardboard;
 */
@property (nonatomic, strong) NSString	*n_logo;
@property (nonatomic, strong) NSString	*n_id;
@property (nonatomic, strong) NSString	*n_url;
@property (nonatomic, strong) NSString	*n_summary;
@property (nonatomic, strong) NSString	*sc_id;
@property (nonatomic, strong) NSString	*sc_title;

@end


@interface XCInduDetialModel : NSObject

/*
	k_logo = http://pic.xincheng.tv/xincheng/2016/0828/731cd7bfa88b9060a5575b31.jpg;
	product_count = 1;
	ce_count = 0;
	k_cn = 索尼;
	products =
	project_count = 0;
	k_id = 26;
	tech_count = 0;
	kinfo_one = 全球知名的大型综合性跨国企业集团;
	kinfo_country = ;
*/

@property (nonatomic, strong) NSString	*k_logo;
@property (nonatomic, strong) NSString	*product_count;
@property (nonatomic, strong) NSString	*ce_count;
@property (nonatomic, strong) NSString	*k_cn;
@property (nonatomic, strong) NSArray	*products55;
@property (nonatomic, strong) NSString	*project_count;
@property (nonatomic, strong) NSString	*k_id;
@property (nonatomic, strong) NSString	*tech_count;
@property (nonatomic, strong) NSString	*kinfo_one;
@property (nonatomic, strong) NSString	*kinfo_country;


+ (void)loadInduSuccess:(void (^)(NSArray *log, NSArray *sub))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
