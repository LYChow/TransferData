//
//  LYDownloadTool.m
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//



#import "LYDownloadTool.h"


#define kBaseUrl   @"http://localhost:8080/MJServer/"


@interface LYDownloadTool()<NSURLSessionDownloadDelegate>


@property(nonatomic,strong) NSMutableArray  *downloadList;

/*!
 *  存在列表model对应的下载链接,防止重复下载,删除model之后可以重新下载
 */
@property(nonatomic,strong) NSMutableDictionary  *modelInfo;

/*!
 *  执行下载任务的task
 */
@property(nonatomic,strong) NSURLSessionDownloadTask  *task;

/*!
 *  获取task的Session
 */
@property(nonatomic,strong) NSURLSession  *session;

/*!
 *  暂停后用于恢复下载task的data
 */
@property(nonatomic,strong) NSData  *resumeData;

/*!
 *  当前model数据已经下载数据长度
 */
@property(nonatomic,assign) int64_t hadWrittenLength;

@property(nonatomic,strong) LYDownloadModel  *downloadingModel ;
@end

@implementation LYDownloadTool

static LYDownloadTool *tool =nil;

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool =[[LYDownloadTool alloc] init];
    });
    return tool;
}


-(NSMutableArray *)downloadList
{
    if (!_downloadList) {
        self.downloadList = [NSMutableArray array];
    }
    return _downloadList;
}

-(NSMutableDictionary *)modelInfo
{
    if (!_modelInfo) {
        self.modelInfo =[NSMutableDictionary dictionary];
    }
    return _modelInfo;
}

-(NSURLSession *)session
{
    if (!_session) {
        // 获得session
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}


-(void)startDownloadFileWithModelList:(NSArray *)modelList
{
  
    for (LYDownloadModel *model in modelList)
    {
        if (![self.modelInfo objectForKey:model.url])
        {
            [self.modelInfo setObject:model forKey:[model.url lastPathComponent]];
            [self.downloadList addObject:model];
        }
        
        if (self.task ==nil)
        {
           //无正在下载任务的时候，执行一次下载操作
            [self downloadQueueWithDownloadList];
        }
    }
}

/*!
 * 执行下载操作的model
 */
-(void)downloadQueueWithDownloadList
{
    if (self.downloadList.count)
    {
    //下载待下载列表中的第一个元素
        self.downloadingModel = [self.downloadList firstObject];
        //开始多任务下载
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,self.downloadingModel.url]];
        self.task =[self.session downloadTaskWithURL:url];
        [self.task resume];
    }

}



-(void)resumetDownloadFileList:(NSArray *)modelList
{
  //根据resumeData恢复一个任务
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.task resume];
    self.resumeData=nil;
}

-(void)pauseDownloadFileList:(NSArray *)modelList
{
     //暂停当前任务
     __weak  typeof(self) vc =self;
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        vc.resumeData =resumeData;
        [vc.task cancel];
        vc.task =nil;
    }];
    
}

-(void)cancelDownloadFileList:(NSArray *)modelList
{

}


#pragma -mark NSURLSessionDownloadDelegate
//原理是NSURLSessionDownloadTask把下载的文件写在了tmp文件夹下,已实现了边下载边写入的功能

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //找到下载完成时对应的model,标示出来
   NSString *url = [downloadTask.response.URL lastPathComponent];
    
    if ([self.modelInfo objectForKey:url])
    {
        LYDownloadModel *model =[self.modelInfo objectForKey:url];
        model.isCompleted=YES;
        if ([self.downloadList containsObject:model])
        {
            [self.downloadList removeObject:model];
            //下载另一条数据
            [self downloadQueueWithDownloadList];
        }
    }
    self.task =nil;
    _hadWrittenLength =0;
    
    //下载完成时,移动文件到自定义文件夹
   NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"filePath--%@",filePath);
    NSFileManager *mgr =[NSFileManager defaultManager];
    [mgr moveItemAtPath:location.path toPath:filePath error:nil];
    //关闭一些资源
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{

    _hadWrittenLength+=bytesWritten;
    //显示下载进度
    if ([_delegate respondsToSelector:@selector(currentDownloadingModel:downloadProgress:)]) {
        [_delegate currentDownloadingModel:self.downloadingModel downloadProgress:((float)_hadWrittenLength)/totalBytesExpectedToWrite];
    }
    NSLog(@"下载的进度----%.2f",((float)_hadWrittenLength)/totalBytesExpectedToWrite);
    
}

@end
