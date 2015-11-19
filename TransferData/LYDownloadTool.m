//
//  LYDownloadTool.m
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadTool.h"
#import "LYDownloadModel.h"

#define kBaseUrl   @"http://localhost:8080/MJServer/"
#define kFilePath

@interface LYDownloadTool()

@end

@implementation LYDownloadTool

-(void)downloadFileWithModelList:(NSArray *)modelList
{
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    
}

-(void)resumetDownloadFileList:(NSArray *)modelList
{

}

-(void)pauseDownloadFileList:(NSArray *)modelList
{

}

-(void)cancelDownloadFileList:(NSArray *)modelList
{

}

@end
