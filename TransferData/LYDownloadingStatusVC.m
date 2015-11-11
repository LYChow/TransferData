//
//  LYDownloadingStatusVC.m
//  TransferData
//
//  Created by lychow on 11/20/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownloadingStatusVC.h"
#import "LYConst.h"
#import "LYDownloadCell.h"
#import "LYDownloadModel.h"

static NSString *cellIndentifier =@"cellIndentifier";

@interface LYDownloadingStatusVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView  *tableView;
@property(nonatomic,strong) NSMutableArray  *modelList;
@end

@implementation LYDownloadingStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}

-(void)createTableView
{
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight-44-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYDownloadCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYDownloadModel *model =[self.modelList objectAtIndex:indexPath.row];
    
        LYDownloadCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        cell.model=model;
        //全选、不全选
        cell.circleButton.selected=model.isSelected;
        return cell;
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


@end
