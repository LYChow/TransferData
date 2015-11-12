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
@property(nonatomic,strong) NSArray  *topTitleArray;
@property(nonatomic,strong) NSArray  *topImageArray;
@property(nonatomic,strong) NSMutableArray  *viewControllers;
@end

@implementation LYDownLoadRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"网络列表";
    [self createSliderView];
}



-(NSArray *)topTitleArray
{
    if (!_topTitleArray) {
        self.topTitleArray =[NSArray arrayWithObjects:@"视频",@"图片",nil];
    }
    return _topTitleArray;
}

-(NSArray *)topImageArray
{
    if (!_topImageArray) {
        self.topImageArray =[NSArray arrayWithObjects:@"icon_video",@"icon_image",nil];
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

}

@end
