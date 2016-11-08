//
//  XCRefreshHeader.h
//  新城商业
//
//  Created by 王潇 on 16/11/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface XCRefreshHeader : MJRefreshNormalHeader

/**
 <#Description#>

 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
