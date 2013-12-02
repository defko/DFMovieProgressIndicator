//
//  DFProgress.m
//  DefSpinner
//
//  Created by Kiss Tamas on 2013.06.17..
//  Copyright (c) 2013 defko. All rights reserved.
//

#import "DFProgressIndicator.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation DFProgressIndicator

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;

}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit
{
    self.hidden = YES;
    _startNumber = 10;
    _startAngle = 270;
    _circleColor = [UIColor lightGrayColor];
    _tintColor = [UIColor lightGrayColor];
    _labelColor = [UIColor colorWithRed:(83.f/255.f) green:(83.f/255.f) blue:(83.f/255.f) alpha:1.0f];
    [self addCountDownLabel];
}

- (void) addCountDownLabel
{
    _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                self.frame.size.width,
                                                                self.frame.size.width)];
    _countDownLabel.text = [NSString stringWithFormat:@"%i",_startNumber];
    _countDownLabel.textColor = _labelColor;
    int fontSize = self.frame.size.width * 0.8;
    _countDownLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    _countDownLabel.textAlignment = NSTextAlignmentCenter;
    _countDownLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_countDownLabel];
}

- (void)stopAnimating
{
   self.hidden = YES;
    _isAnimating = NO;
    _countDownLabel.text = [NSString stringWithFormat:@"%i",_startNumber];
    _currentNumber = _startNumber;
    [_progressTimer invalidate];
    _progressTimer = nil;
    _angle = _startAngle;
    [self setNeedsDisplay];
}

- (void) startAnimating
{
    if (_isAnimating) {
        return;
    }
    self.hidden = NO;
    _currentNumber = _startNumber + 1;
    _angle = _startAngle;
    _countDownLabel.textColor = _labelColor;
    _isAnimating = YES;
    _rotationAngle = 5.f;
    
    if (_radius == 0) {
        _radius = self.frame.size.width - 5;
    }
    _animationSpeed = 1/(250.f/_rotationAngle);
    
    [_progressTimer invalidate];
    _progressTimer = [NSTimer timerWithTimeInterval:_animationSpeed
                                             target:self
                                           selector:@selector(moveAnimation:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_progressTimer forMode:NSDefaultRunLoopMode ];
}

- (void) moveAnimation:(NSTimer *)timer
{
    _angle = _angle + _rotationAngle;
    if (_angle > 360.f)
    {
        _isCountDownDecreasedInThisLap = NO;
        _angle = 0.0f;
    }
    [self setNeedsDisplay];
    [self countDown];
}

- (void)countDown
{
    if (_angle > 270.f && !_isCountDownDecreasedInThisLap) {
        _isCountDownDecreasedInThisLap = YES;
        if (_currentNumber <= 1) {
            _currentNumber = _startNumber + 1;
        }
        _currentNumber--;
        _countDownLabel.text = [NSString stringWithFormat:@"%i",_currentNumber];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, _circleColor.CGColor);
    CGContextSetLineWidth(context, 1.f);
    CGRect rectangle = CGRectMake(centerPoint.x - _radius/2,centerPoint.y - _radius/2,_radius,_radius);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);

    CGFloat currentAngle = _angle;
    CGFloat newAlphaValue = .25f;

    if (!_isAnimating) {
        return;
    }
    
    CGFloat arcEndAngle  = currentAngle - (currentAngle - _startAngle);
    CGFloat arStartAngle = currentAngle;
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, _radius/4.f, DEGREES_TO_RADIANS(arStartAngle), DEGREES_TO_RADIANS(arcEndAngle), 0);
    CGContextSetLineWidth(context, _radius/2.f);
    
    UIColor *newColor = nil;
    CGColorRef colorRef = CGColorCreateCopyWithAlpha(_tintColor.CGColor, newAlphaValue);
    newColor = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    
    
    CGContextSetStrokeColorWithColor(context,newColor.CGColor);
    CGContextStrokePath(context);
    
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, _circleColor.CGColor);
    CGContextMoveToPoint(context, self.frame.size.width/2, 0);
    CGContextAddLineToPoint(context, self.frame.size.width/2, self.frame.size.height);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, _circleColor.CGColor);
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2);
    CGContextStrokePath(context);
}

- (CGPoint) getPointWithAngle:(CGFloat) angle andRadius:(double) radius andCenterPoint:(CGPoint) centerPoint
{
    CGFloat sinAlfa = sinf(DEGREES_TO_RADIANS(angle));
    CGFloat c = sinAlfa * radius;
    CGFloat cosAlfa = cosf(DEGREES_TO_RADIANS(angle));
    CGFloat a = cosAlfa * radius;
    
    CGFloat x = centerPoint.x + a;
    CGFloat y = centerPoint.y + c;
    return CGPointMake(x,y);
}

@end
