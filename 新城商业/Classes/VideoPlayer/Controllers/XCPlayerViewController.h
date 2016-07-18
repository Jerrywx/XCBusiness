//
//  XCPlayerViewController.h
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCBussVideoModel;
@class XCBussNewsModel;
@interface XCPlayerViewController : UIViewController

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) XCBussVideoModel	*model;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) XCBussNewsModel	*newsModel;

@end
