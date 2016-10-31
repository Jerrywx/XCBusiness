//
//  XCInduHeaderView.h
//  新城商业
//
//  Created by 王潇 on 16/10/31.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCInduDetialModel;

@protocol XCInduHeaderViewDelegate <NSObject>
@optional

- (void)induHeaderViewDidSelected:(XCInduDetialModel *)model;

@end

@interface XCInduHeaderView : UIView

/// 
@property (nonatomic, strong) XCInduDetialModel *model;

@property (nonatomic, weak) id<XCInduHeaderViewDelegate> delegate;


@end
