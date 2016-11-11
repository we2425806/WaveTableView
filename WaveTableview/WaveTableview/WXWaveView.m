//
//  WXWaveView.m
//  WaveTableview
//
//  Created by apple on 14/11/7.
//  Copyright © 2014年 itheima. All rights reserved.
//

#import "WXWaveView.h"

@interface WXWaveView ()

@property(assign,nonatomic) CGFloat offsetX;
@property(strong,nonatomic) CADisplayLink *waveDisplayLink;
@property(strong,nonatomic) CAShapeLayer *waveShapeLayer;

@end

@implementation WXWaveView

+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame {
    WXWaveView *waveView = [[self alloc] initWithFrame:frame];
    [view addSubview:waveView];
    return waveView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self basicSetup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self basicSetup];
    }
    return self;
}

- (void)basicSetup {
    _angularSpeed = 2.0;
    _waveTime = 1.5;
    _waveColor = [UIColor whiteColor];
    _waveSpeed = 9.0;
}

- (BOOL)wave {
    if (self.waveShapeLayer.path) {
        return NO;
    }
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    if (self.waveTime < 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stop];
        });
    }
    return YES;
}

-(void)currentWave {
    self.offsetX -= (self.waveSpeed * self.superview.frame.size.width/320);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height/2);
    CGFloat y = 0.f;
    for (CGFloat x= 0.f; x <= width; x++) {
        y = height * cos(0.01 * (self.angularSpeed * x + self.offsetX));
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.waveShapeLayer.path = path;
    CGPathRelease(path);
}

- (void)stop {
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveDisplayLink = nil;
        self.waveShapeLayer.path = nil;
        self.alpha = 1.0;
    }];
}

@end
