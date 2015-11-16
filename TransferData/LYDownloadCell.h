//
//  LYDownloadCell.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYDownloadModel.h"

@interface LYDownloadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingX;

@property(nonatomic,strong) LYDownloadModel  *model ;



- (IBAction)changedExtentionStatus:(id)sender;

@end
