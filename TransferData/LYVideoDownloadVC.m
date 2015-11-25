//
//  LYVideoDownloadVC.m
//  TransferData
//
//  Created by lychow on 11/12/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYVideoDownloadVC.h"
#import "LYConst.h"
#import "LYDownloadCell.h"
#import "LYDownloadExtentionCell.h"
#import "LYDownloadModel.h"
#import "LYBottomView.h"
#import "LYDownloadTool.h"

static NSString *cellIndentifier =@"cellIndentifier";
static NSString *cellExtentionIndentifier =@"cellExtentionIndentifier";

@interface LYVideoDownloadVC()<UITableViewDataSource,UITableViewDelegate,LYDownloadCellDelegate,LYDownloadExtentionCellDelegate,LYBottomViewDelegate>
/*!
 *  显示Models的数组
 */
@property(nonatomic,strong) NSMutableArray  *modelList;

@property(nonatomic,strong) LYDownloadModel  *selectedModel;

@property(nonatomic,strong) UIBarButtonItem *leftItem;

@property(nonatomic,strong) LYBottomView *bottomView;
@end

@implementation LYVideoDownloadVC

-(NSMutableArray *)modelList
{
    if (!_modelList) {
        self.modelList =[NSMutableArray array];
    }
    return _modelList;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initialization];
    [self createTableView];
    [self createBottomView];
}



-(void)initialization
{
    [super initialization];
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,@"video"]];

    NSLog(@"url---%@",url);
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
//    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
    NSOperationQueue *queue =[NSOperationQueue mainQueue
                              ];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
 
        

        if (connectionError)
        {
            NSLog(@"%@",connectionError);
        }
        else
        {
             NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *modelInfo in dict[@"videos"])
            {
                LYDownloadModel *model =[LYDownloadModel initModelWithDictionary:modelInfo];
                [self.modelList addObject:model];
            }
            
            [self.tableView reloadData];
        }
    }];
   
    
}

-(void)createTableView
{
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight-44-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYDownloadCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LYDownloadExtentionCell" bundle:nil] forCellReuseIdentifier:cellExtentionIndentifier];
}

-(void)createBottomView
{
    _bottomView =[[LYBottomView alloc] init];
    _bottomView.itemsImageArray =@[@"download",@"share",@"delete",@"more"];
    _bottomView.itemsTitleArray =@[@"下载",@"分享",@"删除",@"更多"];
    _bottomView.delegate=self;
    [self.view addSubview:_bottomView];

    [_bottomView setupItems];
}

/*!
 *  设置tableView的编辑状态
 */
-(void)setTableViewEditing:(BOOL)tableViewEditing
{
    _tableViewEditing =tableViewEditing;
    
    if (_tableViewEditing)
    {
        [_bottomView popBottomView];
        self.tableView.frame=CGRectMake(0, 0, kScreenWeight, kScreenHeight-44-64-bottomHeight);
    }
    else
    {
        [_bottomView hiddenBottomView];
        self.tableView.frame=CGRectMake(0, 0, kScreenWeight, kScreenHeight-44-64);
        
    }
    
    [self.tableView reloadData];
}

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYDownloadModel *model =[self.modelList objectAtIndex:indexPath.row];
    
    if (model.isExtentionStatus)
    {
       LYDownloadExtentionCell *cell =[tableView dequeueReusableCellWithIdentifier:cellExtentionIndentifier];
        cell.delegate=self;
        cell.extentionModel =model;
        return cell;
    }
    else
    {
       LYDownloadCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        cell.delegate=self;
        cell.model=model;
        cell.isEditingCell=_tableViewEditing;
        //全选、不全选
        cell.circleButton.selected=model.isSelected;
        
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.modelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYDownloadModel *model =[self.modelList objectAtIndex:indexPath.row];
    return model.isExtentionStatus?122:67;
}

#pragma -mark  LYDownloadCellDelegate

-(void)changeToDownloadExtentionCellStatusWithCurrentModel:(LYDownloadModel *)model
{
     //之前选中的cell状态改为收缩
    _selectedModel.isExtentionStatus=NO;
      //当前正在操作的cell状态改为展开
    model.isExtentionStatus=YES;
    
    _selectedModel=model;
    [self.tableView reloadData];
}


#pragma -matk  LYDownloadExtentionCellDelegate

//
-(void)changeToDownloadCellStatusWithCurrentModel:(LYDownloadModel *)model
{
    //之前选中的cell状态改为收缩
    _selectedModel.isExtentionStatus=NO;
    //当前正在操作的cell状态改为收缩
    model.isExtentionStatus=NO;
    
    _selectedModel =model;
    [self.tableView reloadData];
    
}

//下载当前model对应的视频文件
-(void)downloadVideoWithCurrentModel:(LYDownloadModel *)model
{

}

#pragma mark LYBottomDelegate  触发事件相应
-(void)bottomView:(LYBottomView *)bottomView tapItemIndex:(NSInteger)index
{
    NSMutableArray *selectedList =[NSMutableArray array];
    switch (index) {
        case 0:
            //下载
        {
            for (LYDownloadModel *model in self.modelList) {
                if (model.isSelected)
                {
                    [selectedList addObject:model];
                }
            }
            //下载选中的数据
            [[LYDownloadTool shareManager] startDownloadFileWithModelList:selectedList];
            
            //取消编辑状态
            [[NSNotificationCenter defaultCenter]postNotificationName:@"editStatusChange" object:nil];
            
            //把下载任务添加到下载列表中
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addDownloadTask" object:selectedList];
            
        }
            break;
        case 1:
            //分享
            break;
        case 2:
            //删除
            break;
        case 3:
            //更多
            
            break;
        default:
            break;
    }
}


@end
