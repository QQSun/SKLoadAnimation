//
//  ViewController.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "ViewController.h"
#import "SKLoadAnimationView.h"
@interface ViewController ()<SKLoadAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SKLoadAnimationView *loadView = [[SKLoadAnimationView alloc] initWithFrame:self.view.bounds];
    loadView.delegate = self;
    [self.view addSubview:loadView];
}

- (void)loadAnimationCompletion
{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
