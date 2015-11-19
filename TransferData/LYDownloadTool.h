//
//  LYDownloadTool.h
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYDownloadTool : NSObject

/*!
 *  下载
 */
-(void)downloadFileWithModelList:(NSArray *)modelList;

/*!
 * 恢复下载
 */
-(void)resumetDownloadFileList:(NSArray *)modelList;

/*!
 *暂停下载
 */
-(void)pauseDownloadFileList:(NSArray *)modelList;

/*!
 *  取消下载
 */
-(void)cancelDownloadFileList:(NSArray *)modelList;


@end
