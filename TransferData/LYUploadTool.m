//
//  LYUploadTool.m
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYUploadTool.h"
#import <SSZipArchive.h>
#import <AFHTTPSessionManager.h>

#define boundaryWithSpecisChar   [@"zhouluyao" dataUsingEncoding:NSUTF8StringEncoding]
#define breakLine                [@"\n\r" dataUsingEncoding:NSUTF8StringEncoding]
#define dataEncodingWithString(var) [var dataUsingEncoding:NSUTF8StringEncoding]

#define kServerParamName   @"file"
@interface LYUploadTool()

@end

@implementation LYUploadTool
-(instancetype)init
{
    if (self =[super init]) {
        
    }
    return  self;
}
//照片或者拍照获取数据上传
-(void)uploadDatatoUrl:(NSURL *)url imageData:(NSData *)imageData fileName:(NSString *)fileName  params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue
{
    //1.设置请求方式
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //2.设置请求体
    NSMutableData *body = [NSMutableData data];
    //2.1开始标记
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:boundaryWithSpecisChar];
    [body appendData:breakLine];
    //2.2设置文件参数
    NSString *disposition =[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\";filename =\"%@\"" ,fileName];
    [body appendData:dataEncodingWithString(disposition)];
    [body appendData:breakLine];
    
    
    //根据传入的文件扩展名设置mimeType
    NSString *mimeType =@"";
    NSString *extention = [[fileName componentsSeparatedByString:@"."] lastObject];
    if ([extention isEqualToString:@"png"])
    {
        mimeType=@"image/png";
    }
    else if ([extention isEqualToString:@"jpg"])
    {
        mimeType=@"image/jpeg";
    }
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@" ,mimeType];
    [body appendData:dataEncodingWithString(type)];
    [body appendData:breakLine];
    
     [body appendData:breakLine];
    [body appendData:imageData];
     [body appendData:breakLine];
    
    //2.3设置非文件参数
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        [body appendData:dataEncodingWithString(@"--")];
        [body appendData:boundaryWithSpecisChar];
        [body appendData:breakLine];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
        [body appendData:dataEncodingWithString(disposition)];
        [body appendData:breakLine];
        
        [body appendData:breakLine];
        [body appendData:dataEncodingWithString([obj description])];
        [body appendData:breakLine];
    }];
    //2.4结束标记
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:boundaryWithSpecisChar];
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:breakLine];
    
    request.HTTPBody = body;
    //3.设置请求头
    NSString *contentType =[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryWithSpecisChar];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    //4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        id obj =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dict---%@",dict);
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
         NSArray *array =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"array--%@",array);
        }
    }];
}

//上传本地的文件
-(void)uploadFileToUrl:(NSURL *)url  filePath:(NSString *)filePath params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue
{
    //1.设置请求方式
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //2.设置请求体
    NSMutableData *body =[NSMutableData data];
    //2.1开始标记
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:boundaryWithSpecisChar];
    [body appendData:breakLine];
    //2.2设置文件参数
    
    
    NSString *fileName =[filePath lastPathComponent];
    NSString *fileDisposition =[NSString stringWithFormat:@"content-Disposition :form-data; name=\"file\"; filename = \"%@\"",fileName];
    [body appendData:dataEncodingWithString(fileDisposition)];
    [body appendData:breakLine];
    
    NSString *mimeType =[self mimeTypeWithFilePath:filePath];
    NSString *contentType =[NSString stringWithFormat:@"content-Type:\"%@\"",mimeType];
    [body appendData:dataEncodingWithString(contentType)];
    [body appendData:breakLine];
    
    [body appendData:breakLine];
    NSData *fileData =[NSData dataWithContentsOfFile:filePath];
    [body appendData:fileData];
    [body appendData:breakLine];
    
    //2.3设置非文件参数
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [body appendData:dataEncodingWithString(@"--")];
        [body appendData:boundaryWithSpecisChar];
        [body appendData:breakLine];
        NSString *disposition =[NSString stringWithFormat:@"content-Disposition: formdata ;name=\"%@\"",key];
        [body appendData:dataEncodingWithString(disposition)];
        [body appendData:breakLine];
        
        [body appendData:breakLine];
        [body appendData:dataEncodingWithString(obj)];
        [body appendData:breakLine];

    }];
    
    
    //2.4结束标记
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:boundaryWithSpecisChar];
    [body appendData:dataEncodingWithString(@"--")];
    [body appendData:breakLine];
    //3.设置请求头
    NSString *requestHeader =@"mutipart/formdata ;boundary = \"%@\"";
    [request setValue:requestHeader forHTTPHeaderField:@"content-Type"];
    //4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
    }];
}

//AFNetworking 实现文件的上传
-(void)uploadDataWithAFNetworkingUsesToUrl:(NSString *)url parameters:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName mimeType:(NSString *)mimeType uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue
{
    AFHTTPSessionManager *mgr =[AFHTTPSessionManager manager];

    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    [formData appendPartWithFileData:fileData name:kServerParamName fileName:fileName mimeType:mimeType];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failue(error);
    }];
    
}

//多路径多参数
-(void)uploadToUrl:(NSURL *)url   fileAtDirectory:(NSArray *)filesPath params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue
{

}
//多文件多参数
-(void)uploadDataToUrl:(NSURL *)url  filesData:(NSArray *)filesData filesName:(NSArray *)filesName params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue
{

}

//根据文件的路径获取file 的MimeType
-(NSString *)mimeTypeWithFilePath:(NSString *)filePath
{
    NSURL *url =[[NSBundle mainBundle] URLForResource:filePath withExtension:nil];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLResponse *response =nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

#pragma -mark archiveFile or unarchiveFile
//压缩文件夹下
-(BOOL)archiveDirectoryAtPath:(NSString *)directory  toDestationPath:(NSString *)destationPath
{
    BOOL isArchive =  [SSZipArchive createZipFileAtPath:destationPath withContentsOfDirectory:directory];
    return isArchive;
}

//压缩几个文件
-(BOOL)archiveFiles:(NSArray *)files toDestationPath:(NSString *)destationPath
{
    BOOL isArchive = [SSZipArchive createZipFileAtPath:destationPath withFilesAtPaths:files];
    return isArchive;
}
//解压缩文件
-(BOOL)unarchiveFile:(NSString *)filePath toDestationFolder:(NSString *)destationPath
{
   BOOL isArchive = [SSZipArchive unzipFileAtPath:filePath toDestination:destationPath];
    return isArchive;
}

@end
