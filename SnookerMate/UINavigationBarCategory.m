//
//  UINavigationBarCategory.m
//  SnookerMate
//
//  Created by Ryan Bibby and Mark Dessain on 22/01/2012.
//

#import "UINavigationBarCategory.h"

@implementation UINavigationBar (UINavigationBarCategory)

// Sets the background of the navigation bar to the Navigation image
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor brownColor];
    self.tintColor = color;
    UIImage *img  = [UIImage imageNamed: @"Navigation.png"];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
