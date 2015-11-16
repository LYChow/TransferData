//
//  LYDownloadExtentionCell.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadExtentionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kBaseUrl  @"http://localhost:8080/MJServer/"

@interface LYDownloadExtentionCell()
@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;
@end

@implementation LYDownloadExtentionCell

//67  -55
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setExtentionModle:(LYDownloadModel *)extentionModel
{
    _extentionModel = extentionModel;
    
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,_extentionModel.image]];
    [self.videoCoverImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLabel.text= _extentionModel.name;
    self.videoLengthLabel.text=[NSString stringWithFormat:@"%@",_extentionModel.length];
    
}

- (IBAction)changedNormalStatus:(id)sender {
}

- (IBAction)download:(id)sender {
}

- (IBAction)share:(id)sender {
}

- (IBAction)deleteCurrentModel:(id)sender {
}

- (IBAction)more:(id)sender
{
    
}
@end
