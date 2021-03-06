//
//  LYConst.h
//  TransferData
//
//  Created by lychow on 11/11/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>



#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define kScreenWeight  [[UIScreen mainScreen] bounds].size.width

#define kColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#if!(TARGET_IPHONE_SIMULATOR)
#define kBaseUrl @"http://192.168.147.209:8080/MJServer/"
#else
#define kBaseUrl @"http://localhost:8080/MJServer/"
#endif