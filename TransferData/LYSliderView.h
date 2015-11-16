//
//  LYSliderView.h
//  TransferData
//
//  Created by lychow on 11/11/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ItemByScreenWidthTopScrollViewType,   //根据屏幕宽度
    ItemEqualWidthTopScrollViewType,      //等宽
    ItemWidthByContentTopScrollViewType   //根据内容自扩展宽度
} topScrollViewType;



typedef enum : NSUInteger
{
    TextItemType,          //文本
    TextAndImageItemType,  //图片文本
    ImageItemType          //图片
} itemType;



@class LYSliderView;

@protocol LYSliderViewDelegate <NSObject>

@required
/**
 *  根据Index返回对应的ViewController
 */
-(UIViewController *)sliderView:(LYSliderView *)sliderView viewForViewControllerAtIndex:(NSInteger)index;

/**
 *  设置控制器的个数
 */
-(NSInteger)numberOfViewControllersInSliderView:(LYSliderView *)sliderView;

@optional
/**
 *  回调当前滑到VC的Index
 */
-(void)sliderView:(LYSliderView *)sliderView didScrollViewControllerAtIndex:(NSInteger)index;

@end


@interface LYSliderView : UIView

/**
 *  顶部scrollView上item的标题
 */
@property(nonatomic,strong) NSArray  *topTitlesArray;

/**
 *  顶部scrollView上item的标示
 */
@property(nonatomic,strong) NSArray  *topImagesArray;

/**
 *  顶部scrollView
 */
@property(nonatomic,assign) CGFloat topScrollViewHeight;

/**
 *  设置控制器的个数
 */
@property (nonatomic ,assign) NSInteger numberOfViewControllers;

/**
 *  设置选中的item下标
 */
@property (nonatomic ,assign) NSInteger selectedIndex;


@property (nonatomic ,weak) id <LYSliderViewDelegate> delegate;

/**
 *  顶部item分布的类型(宽度设置)
 */
@property (nonatomic ,assign) topScrollViewType topScrollType;

/**
 *  顶部item的内容设置
 */
@property (nonatomic ,assign) itemType topScrollItemType;

/*!
 *  设置TopScrollView、MainScrollView内容
 */
-(void)setUpScrollViewContent;

/**
 *  刷新item标题的内容
 */
-(void)updateSliderItemTitleAtIndex:(NSInteger)index replaceWithTitle:(NSString *)replaceTitle;


@end




@class LYSliderViewItem;



@protocol LYSliderViewItemDelegate <NSObject>
/**
 *  item被点击时,回调当前item的下标、item
 */
-(void)sliderViewItem:(LYSliderViewItem *)item didTapItemAtIndex:(NSInteger)index;
@end


@interface LYSliderViewItem :UIView
/**
 *  用于item标题显示
 */
@property(nonatomic,strong) UILabel  *titleLabel;

/**
 *  用于item图片标示
 */
@property(nonatomic,strong) UIButton  *signButton;

@property(nonatomic, weak) id  <LYSliderViewItemDelegate>  delegate;

/**
 *  item的类型
 */
@property(nonatomic, assign) itemType  topItemType;

@end