//
//  XCURLConstantString.m
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCURLConstantString.h"

@implementation XCURLConstantString

/// url 基地址
NSString * const _kAPI_BaseUrl				=       @"http://api.xincheng.tv/";

/// 左侧菜单
NSString * const _kAPI_GetLeftMuen			=       @"api/getchannellist/";

/***************************************************************************************************/
/**												新城商业											  **/
/***************************************************************************************************/
/// 左侧 视频
NSString * const _kAPI_BusinessLeftVideo	=		@"api/getv_b/";

/// 右侧 数据
NSString * const _kAPI_BusinessRightData	=		@"api/getcontent/";

/***************************************************************************************************/
/**												频道												  **/
/***************************************************************************************************/
// 频道目录
NSString * const _kAPI_ChannelMenu			=		@"api/getchannellist1/";

/// 频道子目录
NSString * const _kAPI_ChannelSubMenu		=		@"api/getchannellist2/";

/***************************************************************************************************/
/**												行业矩阵											  **/
/***************************************************************************************************/

/// 行业矩阵目录页
NSString * const _kAPI_InduMenu				=		@"/api/getchannellist3/";

// 行业矩阵内容页面
NSString * const _kAPI_InduData				=		@"/api/getchannellist4/";

@end
