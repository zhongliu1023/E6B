//
//  TMLineGraph.m
//  GraphDemo
//
//  Created by inextsol on 11/9/16.
//  Copyright © 2016 inextsol. All rights reserved.
//

#import "TMLineGraph.h"
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

@implementation TMLineGraph
@synthesize levelY;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth=1.0;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor=[UIColor blackColor].CGColor;
    }
    return self;
}

-(void)addHorizontalLabel:(NSArray*)array {
    self.xArray = array;
    _xValueMax = 150;
    _xValueMin = 136;
    float level = (_xValueMax-_xValueMin) /7.0;
    CGFloat chartCavanHeight = self.frame.size.width;// - 10*2;
    CGFloat levelHeight = chartCavanHeight /7.0;
    
    for (int i=0; i<8; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(chartCavanHeight-i*levelHeight-15,245, 30, 10)];
        label.font=[UIFont systemFontOfSize:8];
        label.text = [NSString stringWithFormat:@"%d-",(int)(_xValueMax - level * i)];
        [self addSubview:label];
        label.transform		= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90));
    }
    
    
    for (int i=0; i<7; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(40+i*40,0)];
        [path addLineToPoint:CGPointMake(40+i*40,self.frame.size.height-2)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
    }
    
}

-(void)addVerticalLabel:(NSArray*)array {
    self.yArray = array;
        _yValueMax = [[array lastObject]floatValue];
        _yValueMin = [[array firstObject]floatValue];
    levelY = (_yValueMax-_yValueMin) /(array.count -1);
    CGFloat chartCavanHeight = self.frame.size.height;// - 10*2;
    CGFloat levelHeight = chartCavanHeight /(array.count -1);
    
    for (int i=0; i<array.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(-35.0,chartCavanHeight-i*levelHeight-5, 30, 10)];
        label.font=[UIFont systemFontOfSize:8];
        label.text = [NSString stringWithFormat:@"%d-",(int)(levelY * i+_yValueMin)];
        [self addSubview:label];
    }
    
    
    
    
    for (int i=0; i<9; i++) {
        
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0.0,0.0+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
    }
    
    
    
    
//    [self drawGraph];
}

-(void)drawGraph:(NSArray*)points color:(UIColor *)colorValue shapeLayer:(CAShapeLayer *)shapeLayerGraph {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float rangeY = 200/(240/((_yValueMax-_yValueMin)/200));
    float rangeX = 2.0/40.0;
    float startY = 2100.0;
    float startX = 136.0;
    
    for (int i=0; i<points.count-1; i++) {
        NSString *coordinates=points[i];
        float x,y;

        x=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:1] doubleValue]-startX)/rangeX;
        y=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:0] doubleValue]-startY)/rangeY;
        [path moveToPoint:CGPointMake(x, (UULabelHeight - y))];
        NSLog(@"points:%f %f",x,(UULabelHeight - y));
        float pointX,pointY;
        coordinates=points[i+1];
        pointX=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:1] doubleValue]-startX)/rangeX;
        pointY=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:0] doubleValue]-startY)/rangeY;
        NSLog(@"point:::::%f %f",pointX,(UULabelHeight - pointY));
        [path addLineToPoint:CGPointMake(pointX, (UULabelHeight - pointY))];
    }
    
    shapeLayerGraph.path = path.CGPath;
    shapeLayerGraph.strokeColor = [[colorValue colorWithAlphaComponent:1.0] CGColor];
    shapeLayerGraph.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayerGraph.lineWidth = 1;
    [self.layer addSublayer:shapeLayerGraph];
    
}


-(void)drawGraphArm:(NSArray*)points {
    
    CAShapeLayer *shapeLayerArm = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float rangeY = 200/(240/((_yValueMax-_yValueMin)/200));
    float rangeX = 2.0/40.0;
    float startY = 2100.0;
    float startX = 136.0;
    
    for (int i=0; i<points.count; i++) {
        NSString *coordinates=points[i];
        float x,y;
        
        NSString *xValue=[[coordinates componentsSeparatedByString:@":"] objectAtIndex:1];
        x=([[[xValue componentsSeparatedByString:@","] objectAtIndex:0] doubleValue]-startX)/rangeX;
        y=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:0] doubleValue]-startY)/rangeY;
        [path moveToPoint:CGPointMake(x, (UULabelHeight - y))];
        float pointX,pointY;
        pointX=([[[xValue componentsSeparatedByString:@","] objectAtIndex:1] doubleValue]-startX)/rangeX;
        pointY=([[[coordinates componentsSeparatedByString:@":"] objectAtIndex:0] doubleValue]-startY)/rangeY;
        [path addLineToPoint:CGPointMake(pointX, (UULabelHeight - pointY))];
    }
    
    //[path closePath];
    shapeLayerArm.path = path.CGPath;
    shapeLayerArm.strokeColor = [[[UIColor redColor] colorWithAlphaComponent:1.0] CGColor];
    shapeLayerArm.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayerArm.lineWidth = 1;
    [self.layer addSublayer:shapeLayerArm];
    
}

@end
