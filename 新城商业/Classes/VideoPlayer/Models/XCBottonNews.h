//
//  XCBottonNews.h
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XCBottonNews : NSObject

@property (nonatomic, strong) NSString	*n_id;
@property (nonatomic, strong) NSString	*n_title2;
@property (nonatomic, strong) NSString	*n_title1;
@property (nonatomic, strong) NSString	*n_url;
@property (nonatomic, strong) NSString	*n_logo;


+ (void)loadSuccess:( void (^)(NSMutableArray *models))success
			failure:( void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
