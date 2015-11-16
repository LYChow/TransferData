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

static NSString *cellIndentifier =@"cellIndentifier";
static NSString *cellExtentionIndentifier =@"cellExtentionIndentifier";

@interface LYVideoDownloadVC()<UITableViewDataSource,UITableViewDelegate>
{

}

@property(nonatomic,strong) NSMutableArray  *modelList;
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
}

-(void)initialization
{
    [super initialization];
    
    NSURL *url =[NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYDownloadModel *model =[self.modelList objectAtIndex:indexPath.row];
    
    if (model.isExtentionStatus)
    {
       LYDownloadExtentionCell *cell =[tableView dequeueReusableCellWithIdentifier:cellExtentionIndentifier];
        cell.extentionModel =model;
        return cell;
    }
    else
    {
       LYDownloadCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        cell.model=model;
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

@end
