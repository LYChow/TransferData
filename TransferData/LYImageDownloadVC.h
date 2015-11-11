//
//  LYImageDownloadVC.h
//  TransferData
//
//  Created by lychow on 11/12/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYViewController.h"


@interface LYImageDownloadVC : LYViewController



/*!
 *  设置tableView的编辑状态
 */
@property(nonatomic,assign) BOOL tableViewEditing;


/*!
 *  设置全选、全不选状态
 */
@property(nonatomic,assign) BOOL selectedAll;

@end
