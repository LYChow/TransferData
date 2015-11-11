//
//  LYUploadVC.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYUploadVC.h"
#import "LYUploadTool.h"
#import "LYConst.h"
@interface LYUploadVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation LYUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"文件上传";
}


- (IBAction)camera:(id)sender
{
    [self presentImageViewControllerWithCamera:YES];
}

- (IBAction)photo:(id)sender
{
    [self presentImageViewControllerWithCamera:NO];
}

-(void)presentImageViewControllerWithCamera:(BOOL)isCamera
{

    UIImagePickerController *ipc =[[UIImagePickerController alloc] init];
    ipc.delegate=self;
    if (isCamera)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        ipc.sourceType =UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        ipc.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    }
    


    [self.navigationController presentViewController:ipc animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"info--%@",info);
    UIImage *chooseImage = info[@"UIImagePickerControllerOriginalImage"];
    self.chooseImageView.image =chooseImage;
}



- (IBAction)archiver:(id)sender
{
    
}

- (IBAction)upload:(id)sender
{
    LYUploadTool *upload =[[LYUploadTool alloc] init];
    
    NSString *urlStr =[NSString stringWithFormat:@"%@%@",kBaseUrl,@"upload"];
    NSURL *url =[NSURL URLWithString:urlStr];
    NSData *fileData = UIImagePNGRepresentation(self.chooseImageView.image);
    
    //1.AFNetworking实现上传功能
    [upload uploadDataWithAFNetworkingUsesToUrl:urlStr parameters:nil fileData:fileData fileName:@"A.png" mimeType:@"image/png" uploadSuccess:^(id respond) {
        NSLog(@"上传成功---%@",respond);
    } uploadFailue:^(NSError *error) {
        NSLog(@"上传失败---%@",error);
    }];
    
    //2.上传本地绝对路径的文件
    NSString *filePath=@"";
    [upload uploadFileToUrl:url filePath:filePath params:nil uploadSuccess:^(id respond) {
        NSLog(@"上传成功---%@",respond);
    } uploadFailue:^(NSError *error) {
        NSLog(@"上传失败---%@",error);
    }];
}




@end
