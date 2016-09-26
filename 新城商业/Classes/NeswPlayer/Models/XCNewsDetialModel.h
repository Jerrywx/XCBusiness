//
//  XCNewsDetialModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/26.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNewsDetialModel : NSObject

@property (nonatomic, strong) NSString	*k_logo;
@property (nonatomic, strong) NSString	*k_city;
@property (nonatomic, strong) NSString	*k_cn;
@property (nonatomic, strong) NSString	*k_en;
@property (nonatomic, strong) NSString	*parent_name;
@property (nonatomic, strong) NSString	*parent_info_des;
@property (nonatomic, strong) NSString	*k_id;
@property (nonatomic, strong) NSString	*info_birth;
@property (nonatomic, strong) NSArray	*son;
@property (nonatomic, strong) NSArray	*invest;
@property (nonatomic, strong) NSArray	*founder;

+ (void)loadDataSuccess:(void (^)(NSMutableArray *models, id responseObject))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end




//(
//	{
//		k_logo = ;
//		k_city = 美国加利福尼亚州山景市;
//		son = (
//			   {
//				   son_kinfo_des = 是一家美国的跨国科技企业，致力于互联网搜索、云计算、广告技术等领域;
//				   son_name = 谷歌;
//			   }
//			   ,
//			   {
//				   son_kinfo_des = 智能家居产品公司;
//				   son_name = NEST;
//			   }
//			   ,
//			   );
//		k_cn = 谷歌;
//		invest = (
//				  {
//					  invest_name = 拉里·佩奇;
//					  invest_kinfo_des = 佩奇是Google公司的创始人之一;
//				  }
//				  ,
//				  {
//					  invest_name = Alphabet;
//					  invest_kinfo_des = 谷歌母公司;
//				  }
//				  ,
//				  );
//		k_en = Google;
//		parent_name = Alphabet;
//		parent_info_des = 谷歌母公司;
//		k_id = 14;
//		info_birth = 1998/09/04;
//		founder = (
//				   {
//					   founder_name = 拉里·佩奇;
//					   founder_kinfo_des = 佩奇是Google公司的创始人之一;
//				   }
//				   ,
//				   {
//					   founder_name = 谢尔盖·布林;
//					   founder_kinfo_des = 佩奇是Google公司的创始人之一;
//				   }
//				   ,
//				   );
//	}
// ,
// )
