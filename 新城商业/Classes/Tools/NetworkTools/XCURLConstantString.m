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
//NSString * const _kAPI_GetLeftMuen			=       @"http://api.xincheng.tv/api/getchannellist/";
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

@end
