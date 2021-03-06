//
//  XCURLConstantString.h
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCURLConstantString : NSObject

/**
 *  新城网络接口 API
 */

/// 获取右滑侧边栏菜单数据
extern NSString * const _kAPI_GetLeftMuen;
/// 新城商业基地址
extern NSString * const _kAPI_BaseUrl;


/***************************************************************************************************/
/**												新城商业											  **/
/***************************************************************************************************/
/// 左侧 视频
extern NSString * const _kAPI_BusinessLeftVideo;

/// 右侧 数据
extern NSString * const _kAPI_BusinessRightData;


/***************************************************************************************************/
/**												频道												  **/
/***************************************************************************************************/
// 频道目录
extern NSString * const _kAPI_ChannelMenu;

/// 频道子目录
extern NSString * const _kAPI_ChannelSubMenu;


/***************************************************************************************************/
/**												行业矩阵											  **/
/***************************************************************************************************/

/// 行业矩阵目录页
extern NSString * const _kAPI_InduMenu;

// 行业矩阵内容页面
extern NSString * const _kAPI_InduData;

@end
