//
//  LYDownloadExtentionCell.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYDownloadModel.h"

@interface LYDownloadExtentionCell : UITableViewCell

@property(nonatomic,strong) LYDownloadModel  *extentionModel;

- (IBAction)changedNormalStatus:(id)sender;

- (IBAction)download:(id)sender;

- (IBAction)share:(id)sender;

- (IBAction)deleteCurrentModel:(id)sender;

- (IBAction)more:(id)sender;


@end
