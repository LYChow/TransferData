//
//  LYDownloadCell.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadCell.h"
#import "LYConst.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LYUploadTool.h"
@interface LYDownloadCell ()

/*!
 *  图片距离父视图左侧的约束LeadingX
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeadingX;
@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeCellStatusBtn;

- (IBAction)changeEditStatus:(id)sender;

@end


@implementation LYDownloadCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LYDownloadModel *)model
{
    _model =model;
    
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,_model.image]];
    [self.videoCoverImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLabel.text= _model.name;
    self.videoLengthLabel.text=[NSString stringWithFormat:@"时长:%@秒",_model.length];

}


- (IBAction)changedExtentionStatus:(id)sender
{
    if ([_delegate respondsToSelector:@selector(changeToDownloadExtentionCellStatusWithCurrentModel:)])
    {
        [_delegate changeToDownloadExtentionCellStatusWithCurrentModel:_model];
    }
}


-(void)setIsEditingCell:(BOOL)isEditingCell
{
    
    self.circleButton.hidden=!isEditingCell;
    self.imageViewLeadingX.constant=isEditingCell?40:6;
    self.changeCellStatusBtn.hidden=isEditingCell;
    self.changeCellStatusSignBtn.hidden=isEditingCell;
}

- (IBAction)changeEditStatus:(id)sender
{
    _model.isSelected=!_model.isSelected;
    self.circleButton.selected=_model.isSelected;
}

- (IBAction)uploadCurrentVideo:(id)sender
{
    NSFileManager *fileManager =[NSFileManager defaultManager];
    
   NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self.model.url lastPathComponent]];

    if ([fileManager fileExistsAtPath:filePath])
    {
        LYUploadTool *upload =[[LYUploadTool alloc] init];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,@"upload"]];
        [upload uploadFileToUrl:url filePath:filePath params:nil uploadSuccess:^(id respond) {
            NSLog(@"上传成功---%@",respond);
        } uploadFailue:^(NSError *error) {
            NSLog(@"上传失败---%@",error);
        }];
    }
}

@end
