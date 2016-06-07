//
//  XCTestViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/28.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCTestViewController.h"

@interface XCTestViewController ()

@end

@implementation XCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
