//
//  XCBaseViewController.h
//  新城商业
//
//  Created by 王潇 on 16/4/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCBaseViewController : UIViewController

@property (nonatomic, strong) UIView	*myNavigationBar;
@property (nonatomic, strong) UILabel	*tableLabel;							// tabBar tableView Title label
@property (nonatomic, strong) UILabel	*collectionLabel;						// tabBar collection Title Label
@property (nonatomic, strong) UILabel	*collectionClass;						// tabBar collection Class Label

@end
