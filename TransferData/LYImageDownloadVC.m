//
//  LYImageDownloadVC.m
//  TransferData
//
//  Created by lychow on 11/12/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYImageDownloadVC.h"
#import "LYDownloadModel.h"

@interface LYImageDownloadVC ()
@property(nonatomic,strong) NSMutableArray  *modelList;
@end

@implementation LYImageDownloadVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
}

/*!
 *  设置tableView的编辑状态
 */
-(void)setTableViewEditing:(BOOL)tableViewEditing
{
    _tableViewEditing=tableViewEditing;
    
}

/*!
 *  设置全选、全不选状态
 */
/*!
 *  设置全选、全不选状态
 */
-(void)setSelectedAll:(BOOL)selectedAll
{
    _selectedAll=selectedAll;
    for (LYDownloadModel *model in self.modelList)
    {
        model.isSelected=_selectedAll;
    }
    
    [self.tableView reloadData];
}
@end
