//
//  WXWaveView.h
//  WaveTableview
//
//  Created by apple on 14/11/7.
//  Copyright © 2014年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXWaveView : UIView

@property (assign, nonatomic) CGFloat angularSpeed;
@property (assign, nonatomic) CGFloat waveSpeed;
@property (assign, nonatomic) NSTimeInterval waveTime;
@property (strong, nonatomic) UIColor *waveColor;

+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;

-(BOOL)wave;
-(void)stop;

@end
