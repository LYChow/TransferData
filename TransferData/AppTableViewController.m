//
//  AppTableViewController.m
//  networkTest
//
//  Created by lychow on 11/5/15.
//  Copyright © 2015 lychow. All rights reserved.
//


/**
 *function:
 */

#define MCImageCachePath(url)  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

#import "AppTableViewController.h"
#import "LYDownLoadRootVC.h"
#import "LYUploadVC.h"
@interface AppTableViewController ()
@property(nonatomic,strong) NSArray  *functionLists;
@end

@implementation AppTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializationData];
    [self createTableView];
    

}

-(void)initializationData
{
    self.functionLists =[NSArray arrayWithObjects:@"下载列表",@"本地上传",@"WIFI传输",nil];
}

-(void)createTableView
{
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId =@"cellIndentifier";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     //内存中存在Image
    cell.textLabel.text=[self.functionLists objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.functionLists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            LYDownLoadRootVC *rootVC =[[LYDownLoadRootVC alloc] init];
            [self.navigationController pushViewController:rootVC animated:YES];
            break;
        }
        case 1:
        {
            LYUploadVC *uploadVC = [[LYUploadVC alloc] init];
            [self.navigationController pushViewController:uploadVC animated:YES];
            break;
        }
        case 2:
            
            break;

        default:
            break;
    }
}





@end
