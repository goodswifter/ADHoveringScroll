//  文件名:UIView+Extension.h
//  项目名:AllCategory
//  描述:
//
//  作者: jingshi
//  日期: 2017/2/2758.
//  版权:  Copyright © 2017年 zhongad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/** View的基本属性 */
@property (nonatomic, assign) CGFloat _x;
@property (nonatomic, assign) CGFloat _y;
@property (nonatomic, assign) CGFloat _width;
@property (nonatomic, assign) CGFloat _height;
@property (nonatomic, assign) CGSize _size;
@property (nonatomic, assign) CGFloat _centerX;
@property (nonatomic, assign) CGFloat _centerY;

/** 打印view的subviews的关系树 */
- (void)printSubviewsWithIndentation:(int)indentation;

/** 获取当前的控制器 */
- (UIViewController *)getCurrentVC;

@end
