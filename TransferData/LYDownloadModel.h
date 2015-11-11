//
//  LYDownloadModel.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYDownloadModel;

typedef void(^downloadCompleteBlock)(LYDownloadModel *model);

@interface LYDownloadModel : NSObject


/*!
 *  视频的id
 */
@property(nonatomic,strong) NSNumber  *id;
/*!
 *  视频的封面图
 */
@property(nonatomic, copy) NSString *image;

/*!
 *  视频名
 */
@property(nonatomic, copy) NSString *name;
/*!
 *  视频的时长
 */
@property(nonatomic, copy) NSNumber *length;
/*!
 *  视频的url
 */
@property(nonatomic, copy) NSString *url;

/*!
 *  当前model是否处于编辑的选中状态
 */
@property(nonatomic, assign) BOOL isSelected;

/*!
 *  当前model是否展开状态
 */
@property(nonatomic, assign) BOOL isExtentionStatus;

/*!
 *  开始、暂停
 */
@property(nonatomic, assign) BOOL isStart;

/*!
 *  下载完成、下载未完成
 */
@property(nonatomic, assign) BOOL isCompleted;

@property(nonatomic, weak) downloadCompleteBlock completeBlock;

+(instancetype)initModelWithDictionary:(NSDictionary *)dict;
@end
