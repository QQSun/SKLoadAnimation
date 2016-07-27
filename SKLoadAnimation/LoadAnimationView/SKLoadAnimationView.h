//
//  SKLoadAnimationView.h
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKLoadAnimationDelegate <NSObject>

- (void)loadAnimationCompletion;

@end

@interface SKLoadAnimationView : UIView

@property (nonatomic, weak) id <SKLoadAnimationDelegate> delegate;

@end
