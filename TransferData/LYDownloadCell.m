//
//  LYDownloadCell.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define kBaseUrl  @"http://localhost:8080/MJServer/"
@interface LYDownloadCell ()

@property (weak, nonatomic) IBOutlet UIButton *circleButton;

@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;
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
    self.videoLengthLabel.text=[NSString stringWithFormat:@"%@",_model.length];

}


-(void)cellInfoWithModel:(LYDownloadModel *)model
{

}

- (IBAction)changedExtentionStatus:(id)sender
{
    
 
}
@end
