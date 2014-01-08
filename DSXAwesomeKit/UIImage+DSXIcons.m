//
//  UIImage+DSXIcons.m
//  DSXAwesomeKit
//
//  Created by David Schukin on 1/7/14.
//

#import "UIImage+DSXIcons.h"

@implementation UIImage (DSXIcons)

+ (UIImage *)dsx_imageForBackButton
{
    CGSize size = CGSizeMake(12, 20.5);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(9.75, 0)];
    [bezierPath addLineToPoint: CGPointMake(11.5, 1.75)];
    [bezierPath addLineToPoint: CGPointMake(3.5, 10)];
    [bezierPath addLineToPoint: CGPointMake(11.5, 18.25)];
    [bezierPath addLineToPoint: CGPointMake(9.75, 20)];
    [bezierPath addLineToPoint: CGPointMake(0, 10)];
    
    [bezierPath closePath];
    [[UIColor grayColor] setFill];
    [bezierPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
