//
//  UIBarButtonItem+Extention.h
//  TransferData
//
//  Created by lychow on 11/11/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
