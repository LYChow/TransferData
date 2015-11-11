//
//  LYUploadTool.h
//  TransferData
//
//  Created by lychow on 11/19/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^uploadSuccessBlock)(id respond);
typedef void(^uploafFailueBlock)(NSError *error);

@interface LYUploadTool : NSObject


/*!
*  上传本地绝对路径下得文件
*
*  @param url      接收数据的url
*  @param filePath 文件路径
*  @param params   参数列表
 *  @param success  上传成功回调
 *  @param failue   上传失败回调
*/
-(void)uploadFileToUrl:(NSURL *)url  filePath:(NSString *)filePath params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue;

/*!
 *  上传多个文件到服务器
 *
 *  @param url       接收数据的url
 *  @param filesPath 文件路径数组
 *  @param params    参数列表
 *  @param success  上传成功回调
 *  @param failue   上传失败回调
 */
-(void)uploadToUrl:(NSURL *)url   fileAtDirectory:(NSArray *)filesPath params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue;

/*!
 *  上传获取的动态数据(如拍照获取的数据、从相册获取的图片数据)
 *
 *  @param url       接收数据的url
 *  @param imageData 通过UIImageJPEGRepresentation()获取的data
 *  @param fileName  设置到上传到服务器的fileName
 *  @param params    参数列表
 *  @param success  上传成功回调
 *  @param failue   上传失败回调
 */
-(void)uploadDatatoUrl:(NSURL *)url imageData:(NSData *)imageData fileName:(NSString *)fileName  params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue;

/*!
 *  上传多张图片
 *
 *  @param url       接收数据的url
 *  @param filesData 多个文件组合
 *  @param filesName 上传到服务器的名字列表
 *  @param params    参数列表
 *  @param success  上传成功回调
 *  @param failue   上传失败回调
 */
-(void)uploadDataToUrl:(NSURL *)url  filesData:(NSArray *)filesData filesName:(NSArray *)filesName params:(NSDictionary *)params uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue;

/*!
 *  使用AFNetworking上传一个文件
 *
 *  @param url      接收数据的url
 *  @param params   params
 *  @param fileData 上传的文件数据
 *  @param fileName 文件在服务器的名字
 *  @param mimeType 文件的mineType
 *  @param success  上传成功回调
 *  @param failue   上传失败回调
 */
-(void)uploadDataWithAFNetworkingUsesToUrl:(NSString *)url parameters:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName mimeType:(NSString *)mimeType uploadSuccess:(uploadSuccessBlock)success uploadFailue:(uploafFailueBlock)failue;
@end
