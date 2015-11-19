//
//  LYDownloadCell.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "LYDownloadModel.h"


@protocol LYDownloadCellDelegate <NSObject>

-(void)changeToDownloadExtentionCellStatusWithCurrentModel:(LYDownloadModel *)model;


@end

@interface LYDownloadCell : UITableViewCell



/*!
 *  全选、全不选 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *circleButton;


@property(nonatomic,strong) LYDownloadModel  *model ;

@property(nonatomic,weak) id <LYDownloadCellDelegate> delegate;

- (IBAction)changedExtentionStatus:(id)sender;

/*!
 *  cell是否处于编辑状态
 */
@property(nonatomic,assign) BOOL isEditingCell;

@end
