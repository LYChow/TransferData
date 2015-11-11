//
//  LYDownLoadRootVC.m
//  TransferData
//
//  Created by lychow on 11/12/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYDownLoadRootVC.h"
#import "LYSliderView.h"
#import "LYConst.h"
#import "LYVideoDownloadVC.h"
#import "LYImageDownloadVC.h"

@interface LYDownLoadRootVC ()<LYSliderViewDelegate>
/*!
 *  sliderView标题
 */
@property(nonatomic,strong) NSArray  *topTitleArray;
/*!
 *  sliderView的图片
 */
@property(nonatomic,strong) NSArray  *topImageArray;
/*!
 *  装载控制器的数组
 */
@property(nonatomic,strong) NSMutableArray  *viewControllers;
/*!
 *  左侧的item
 */
@property(nonatomic,strong) UIBarButtonItem *leftItem;

/*!
 *  当前滑动到的VC
 */
@property(nonatomic,strong) UIViewController  *currentVC;

@property(nonatomic,strong) UIButton *editOrDoneButton;
@end

@implementation LYDownLoadRootVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationBarItem];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"网络列表";
    [self createSliderView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editStatusChange:) name:@"editStatusChange" object:nil];

}

-(void)setupNavigationBarItem
{
    _editOrDoneButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _editOrDoneButton.frame=CGRectMake(0, 0, 60, 30);
    [_editOrDoneButton setTitleColor:kColor(0,122,255,1) forState:UIControlStateNormal];
    [_editOrDoneButton setTitle:@"多选" forState:UIControlStateNormal];
    [_editOrDoneButton addTarget:self action:@selector(editStatusChange:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:_editOrDoneButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    UIButton *selectedButton =[UIButton buttonWithType:UIButtonTypeCustom];
    selectedButton.frame=CGRectMake(0, 0, 60, 30);
    [selectedButton setTitleColor:kColor(0,122,255,1) forState:UIControlStateNormal];
    [selectedButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(selectedAllStatusChange:) forControlEvents:UIControlEventTouchUpInside];
    _leftItem =[[UIBarButtonItem alloc] initWithCustomView:selectedButton];
    
    
}

/*!
 *  点击编辑状态
 */
-(void)editStatusChange:(UIButton *)btn
{
    static BOOL isEditStatus = YES;
    
    if (isEditStatus)
    {
        [_editOrDoneButton setTitle:@"取消" forState:UIControlStateNormal];
        self.title=@"选择文件";
        
        self.navigationItem.leftBarButtonItem=_leftItem;
    }
    else
    {
        [_editOrDoneButton setTitle:@"多选" forState:UIControlStateNormal];
        self.title=@"网络列表";
        
        self.navigationItem.leftBarButtonItem=nil;
        
        //非编辑状态时,取消所有选中的状态
        if ([self.currentVC isKindOfClass:[LYVideoDownloadVC class]])
        {
            LYVideoDownloadVC *videoVC =(LYVideoDownloadVC *)self.currentVC;
            videoVC.selectedAll=NO;
        }
        else if([self.currentVC isKindOfClass:[LYImageDownloadVC class]])
        {
            LYImageDownloadVC *imageVC =(LYImageDownloadVC *)self.currentVC;
            imageVC.selectedAll=NO;
        }
        
    }
    
    //编辑和非编辑状态cell的显示情况
    if ([self.currentVC isKindOfClass:[LYVideoDownloadVC class]])
    {
        LYVideoDownloadVC *videoVC =(LYVideoDownloadVC *)self.currentVC;
        videoVC.tableViewEditing=isEditStatus;
    }
    else if ([self.currentVC isKindOfClass:[LYImageDownloadVC class]])
    {
        LYImageDownloadVC *imageVC =(LYImageDownloadVC *)self.currentVC;
        imageVC.tableViewEditing=isEditStatus;
    }
    
    
    isEditStatus=!isEditStatus;
    

    
}
/*!
 *  点击全选/全不选 按钮
 */
-(void)selectedAllStatusChange:(UIButton *)btn
{
    static BOOL isSelectedAllStatus = YES;
    
    if (isSelectedAllStatus)
    {
        [btn setTitle:@"全选" forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"全不选" forState:UIControlStateNormal];
    }
    //编辑和非编辑状态cell的显示情况
    if ([self.currentVC isKindOfClass:[LYVideoDownloadVC class]])
    {
        LYVideoDownloadVC *videoVC =(LYVideoDownloadVC *)self.currentVC;
        videoVC.selectedAll=isSelectedAllStatus;
    }
    else if ([self.currentVC isKindOfClass:[LYImageDownloadVC class]])
    {
        LYImageDownloadVC *imageVC =(LYImageDownloadVC *)self.currentVC;
        imageVC.selectedAll=isSelectedAllStatus;
    }
    
    isSelectedAllStatus=!isSelectedAllStatus;
    
    //全选、全不选 状态的更改

}

-(NSArray *)topTitleArray
{
    if (!_topTitleArray) {
        self.topTitleArray =[NSArray arrayWithObjects:@"网络视频",@"已下载",nil];
    }
    return _topTitleArray;
}

-(NSArray *)topImageArray
{
    if (!_topImageArray) {
        self.topImageArray =[NSArray arrayWithObjects:@"icon_video",@"icon_video",nil];
    }
    return _topImageArray;
}

-(NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        self.viewControllers =[NSMutableArray array];
    }
    return _viewControllers;
}

-(void)createSliderView
{
    LYSliderView *sliderView =[[LYSliderView alloc] init];
    sliderView.frame=CGRectMake(0, 64, kScreenWeight, kScreenHeight-64);
    
    sliderView.topImagesArray = self.topImageArray.copy;
    sliderView.topTitlesArray = self.topTitleArray.copy;
    sliderView.topScrollType  = ItemByScreenWidthTopScrollViewType;
    sliderView.topScrollItemType =TextAndImageItemType;
    sliderView.delegate=self;
    
    [self.view addSubview:sliderView];

    LYVideoDownloadVC *videoVC = [[LYVideoDownloadVC alloc] init];
    
    LYImageDownloadVC *imageVC = [[LYImageDownloadVC alloc] init];
    
    
    [self.viewControllers addObject:videoVC];
    [self.viewControllers addObject:imageVC];
    
    [sliderView setUpScrollViewContent];
    

}


#pragma -mark LYSliderViewDelegate

-(UIViewController *)sliderView:(LYSliderView *)sliderView viewForViewControllerAtIndex:(NSInteger)index
{
   
    return [self.viewControllers objectAtIndex:index];
}

-(NSInteger)numberOfViewControllersInSliderView:(LYSliderView *)sliderView
{
    return self.viewControllers.count;
}

/**
 *  点击topScrollView上的按钮时,回调
 *
 *  @param sliderView
 *  @param index      被点击的item所在的index
 */
-(void)sliderView:(LYSliderView *)sliderView didScrollViewControllerAtIndex:(NSInteger)index
{
   self.currentVC =[self.viewControllers objectAtIndex:index];
}



@end
