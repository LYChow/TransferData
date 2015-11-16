//
//  LYDownloadModel.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadModel.h"

@implementation LYDownloadModel

+(instancetype)initModelWithDictionary:(NSDictionary *)dict
{
    LYDownloadModel *model =[[LYDownloadModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
