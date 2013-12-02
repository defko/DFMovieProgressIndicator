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
    
    BOOL _isAnimating;
    
    int _currentNumber;
    BOOL _isCountDownDecreasedInThisLap;
}

@property (nonatomic) double animationSpeed;
@property (nonatomic) double radius;
@property (nonatomic) int startNumber;

@property (nonatomic) CGFloat startAngle;
@property (nonatomic, strong) UIColor* tintColor;
@property (nonatomic, strong) UIColor* circleColor;
@property (nonatomic, strong) UIColor* labelColor;

@property (nonatomic, strong) UILabel* countDownLabel;

- (void) startAnimating;
- (void) stopAnimating;

@end
