//
//  UIView+Extension.m
//  AllCategory
//
//  Created by jingshi on 2017/2/2758.
//  Copyright © 2017年 zhongad. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

#pragma mark - 打印view的subviews的关系树
- (void)printSubviewsWithIndentation:(int)indentation {
    
    int index = 0;
    for (UIView *subview in self.subviews) {
        NSMutableString *currentViewDescription = [[NSMutableString alloc] init];
        
        for (int j = 0; j <= indentation; j++) {
            [currentViewDescription appendString:@"   "];
        }
        
        [currentViewDescription appendFormat:@"[%d]: class: '%@', frame=(%.1f, %.1f, %.1f, %.1f), opaque=%i, hidden=%i, userInterfaction=%i", index++, NSStringFromClass([subview class]), subview.frame.origin.x, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height, subview.opaque, subview.hidden, subview.userInteractionEnabled];
        
        fprintf(stderr,"%s\n", [currentViewDescription UTF8String]);
        
        [subview printSubviewsWithIndentation:indentation + 1];
    }
}

#pragma mark - 获取当前视图所在的控制器
- (UIViewController *)getCurrentVC {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - View的基本属性
- (void)set_x:(CGFloat)_x {
    CGRect frame = self.frame;
    frame.origin.x = _x;
    self.frame = frame;
}

- (CGFloat)_x {
    return self.frame.origin.x;
}

- (void)set_y:(CGFloat)_y {
    CGRect frame = self.frame;
    frame.origin.y = _y;
    self.frame = frame;
}

- (CGFloat)_y {
    return self.frame.origin.y;
}

- (void)set_width:(CGFloat)_width {
    CGRect frame = self.frame;
    frame.size.width = _width;
    self.frame = frame;
}

- (CGFloat)_width {
    return self.frame.size.width;
}

- (void)set_height:(CGFloat)_height {
    CGRect frame = self.frame;
    frame.size.height = _height;
    self.frame = frame;
}

- (void)set_centerX:(CGFloat)_centerX {
    CGPoint center = self.center;
    center.x = _centerX;
    self.center = center;
}

- (CGFloat)_centerX {
    return self.center.x;
}
- (void)set_centerY:(CGFloat)_centerY {
    CGPoint center = self.center;
    center.y = _centerY;
    self.center = center;
}

- (CGFloat)_centerY {
    return self.center.y;
}

- (CGFloat)_height {
    return self.frame.size.height;
}

- (void)set_size:(CGSize)_size {
    CGRect frame = self.frame;
    frame.size = _size;
    self.frame = frame;
}

- (CGSize)_size {
    return self.frame.size;
}


@end
