//
//  LYDownloadTool.h
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYDownloadModel.h"

@protocol LYDownloadToolDelegate <NSObject>

//下载界面回调当前正在下载的model和下载进度
-(void)currentDownloadingModel:(LYDownloadModel *)model downloadProgress:(float)progress;

@end

@interface LYDownloadTool : NSObject


+(instancetype)shareManager;
/*!
 *  下载
 */
-(void)startDownloadFileWithModelList:(NSArray *)modelList;

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

@property (nonatomic,weak) id<LYDownloadToolDelegate> delegate;

@end
