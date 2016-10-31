//
//  XCInduDetialModel.m
//  新城商业
//
//  Created by 王潇 on 16/10/30.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduDetialModel.h"

@implementation XCDetialModel

// 设置行首标题
- (void)setTitle:(NSString *)title {
	_title = title;
	if (title.length > 0) {
		self.isFirst = YES;
	} else {
		self.isFirst = NO;
	}
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.sc_title, self.title];
}

@end

@implementation XCInduDetialModel

+ (void)loadInduSuccess:(void (^)(NSArray *log, NSArray *sub))success
				failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	
	NSDictionary *param = @{@"kt_id" : @"10",
							@"in_id" : @"49"};

	[[XCNetWorkManager shareManager] postWithURL:_kAPI_InduData parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		NSLog(@"==== %@", responseObject);
		XCResponse *response = [XCResponse initWithJson:responseObject];
		if (response.errorcode == XCNetWorkSuccess) {
			NSMutableArray *oneArray = [NSMutableArray array];
			NSMutableArray *twoArray = [NSMutableArray array];
			
			for (NSDictionary *dict in response.data) {
				XCInduDetialModel *model = [XCInduDetialModel mj_objectWithKeyValues:dict];
				if ([model.products isKindOfClass:[NSArray class]]) {
					[oneArray addObject:model];
					NSArray *array = [XCDetialModel mj_objectArrayWithKeyValuesArray:model.products];
					[self operateModels:array];
					[twoArray addObject:array];
				}
			}
			success(oneArray, twoArray);
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		NSLog(@"==== %@", error);
	}];
}

+ (void)operateModels:(NSArray *)models {
	
	NSDictionary *titles = @{@"4": @"产品",
						@"5": @"科技",
						@"6": @"项目"};
	NSArray *keys = [titles allKeys];
	
	
	XCDetialModel *model = models.firstObject;
	NSString *type = model.sc_type;
	
	if ([keys containsObject:type]) {
		model.title = titles[type];
		model.height = 80;
	} else {
		model.title = @"";
		model.height = 60;
	}

	for (int i=1; i<models.count; i++) {
		XCDetialModel *mo = models[i];
		
		if (![mo.sc_type isEqualToString:type]) {
			if ([keys containsObject:mo.sc_type]) {
				mo.title = titles[mo.sc_type];
				mo.height = 80;
			} else {
				mo.title = @"";
				mo.height = 60;
			}
		} else {
			mo.title = @"";
			mo.height = 60;
		}
		type = mo.sc_type;
	}
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %@", self.k_cn, self.kinfo_one];
}

@end
