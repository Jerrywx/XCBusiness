//
//  XCLeftBarModel.h
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCLeftBarModel : NSObject

+ (void)loadModelsuccess:(void (^)(NSArray *models))success
				 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
