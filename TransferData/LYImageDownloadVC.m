
#import "LYImageDownloadVC.h"
#import "LYConst.h"
#import "LYDownloadCell.h"
#import "LYDownloadModel.h"
#import "LYDownloadTool.h"

static NSString *cellIndentifier =@"cellIndentifier";

@interface LYImageDownloadVC ()<UITableViewDataSource,UITableViewDelegate,LYDownloadToolDelegate>
@property(nonatomic,strong) NSMutableArray  *downloadList;

@end

@implementation LYImageDownloadVC



-(NSMutableArray *)downloadList
{
    if (!_downloadList) {
        self.downloadList =[NSMutableArray array];
    }
    return _downloadList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    
    
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSArray *files =  [fileManager contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] error:nil];
    
    NSMutableArray *videos =[NSMutableArray array];
    
    for (NSString *fileName in files)
    {
        if ([fileName containsString:@".mp4"]) {
          NSString *filePath =  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:fileName];
            
            NSLog(@"%@",filePath);
         NSDictionary *dict = [fileManager attributesOfItemAtPath:filePath error:nil];
            NSLog(@"fileInfo---%@",dict);
            [videos addObject:filePath];
        }
    }

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDownloadTask:) name:@"addDownloadTask" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.downloadList)
    {
        //内存中没有数据时——->加载沙盒里的数据---->沙盒没有数据显示下载列表为空
 
    }
}


-(void)refreshDownloadTask:(NSNotification *)noti
{
    if ([noti.object isKindOfClass:[NSMutableArray class]]) {
        self.downloadList = noti.object;
    }
    LYDownloadTool *tool = [LYDownloadTool shareManager];
    tool.delegate=self;
    [self.tableView reloadData];
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
    LYDownloadModel *model =[self.downloadList objectAtIndex:indexPath.row];
    
    LYDownloadCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.model=model;
    cell.changeCellStatusSignBtn.hidden=YES;
    
    cell.uploadButton.hidden=NO;
//    if (model.isCompleted) {
//       
//    }
    //全选、不全选
    cell.circleButton.selected=model.isSelected;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.downloadList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYDownloadModel *model =[self.downloadList objectAtIndex:indexPath.row];
    return model.isExtentionStatus?122:67;
}

#pragma -mark 回调当前model的下载进度
-(void)currentDownloadingModel:(LYDownloadModel *)model downloadProgress:(float)progress
{

    //获取对应的cell 刷进度
    if ([self.downloadList containsObject:model])
    {
        NSInteger index =[self.downloadList indexOfObject:model];
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:index inSection:0];
        LYDownloadCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"下载进度---%f",progress);
    }
   
}

@end

