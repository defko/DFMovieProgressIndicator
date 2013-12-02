//
//  DFProgress.h
//  DefSpinner
//
//  Created by Kiss Tamas on 2013.06.17..
//  Copyright (c) 2013 defko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFProgressIndicator : UIView
{
    NSTimer *_progressTimer;
    
    // Angles
    CGFloat _angle;
    CGFloat _rotationAngle;
    
    int _currentNumber;
    BOOL _isCountDownDecreasedInThisLap;
}

@property (nonatomic,readonly,assign) BOOL isAnimating;

@property (nonatomic,assign) double animationSpeed;
@property (nonatomic,assign) double radius;
@property (nonatomic,assign) int startNumber;

@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic, strong) UIColor* tintColor;
@property (nonatomic, strong) UIColor* circleColor;
@property (nonatomic, strong) UIColor* labelColor;

@property (nonatomic, strong) UILabel* countDownLabel;

- (void) startAnimating;
- (void) stopAnimating;

@end
