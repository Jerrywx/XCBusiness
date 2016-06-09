//
//  XCBussVideoModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCBussVideoModel : NSObject

//vb_link = <iframe height=1080 width=1920 src='http://player.youku.com/embed/XMTI2NTEyODEyNA==' frameborder=0 allowfullscreen></iframe>;
//vb_logo = http://pic.xincheng.tv/vb_logo/2016/0605/b46b54c6bc026a6ec41c2800.jpg;
//vb_id = 2;
//vb_title = 谷歌用风筝发电脑洞大开;

@property (nonatomic, strong) NSString	*vb_link;
@property (nonatomic, strong) NSString	*vb_logo;
@property (nonatomic, strong) NSString	*vb_id;
@property (nonatomic, strong) NSString	*vb_title;
@property (nonatomic, strong) NSString	*vb_num;

+ (void)loadWithURL:(NSString *)urlString
			success:(void (^)(NSMutableArray *models))success
			failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
