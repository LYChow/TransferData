//
//  LYSliderView.m
//  TransferData
//
//  Created by lychow on 11/11/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYSliderView.h"
#import "LYConst.h"
#import "UIView+Extention.h"

#define kTopItemWidth   100

@interface LYSliderView ()<UIScrollViewDelegate>

/**
 *  顶部切换Item的scrollView
 */
@property(nonatomic,strong) UIScrollView  *topScrollView;

/**
 *  切换不同VC的scrollView
 */
@property(nonatomic,strong) UIScrollView  *mainScrollView;

/**
 *  切换不同的Item时,底部标示动画的view
 */
@property(nonatomic,strong) UIView  *  animationView;


@end

@implementation LYSliderView

-(id)init
{
    if (self=[super init])
    {
        [self initialization];
        [self createScrollView];
    }
    return self;
}

#pragma -mark view的初始化、数据源设置
/**
 *  默认设置赋值
 */
-(void)initialization
{
    _topScrollViewHeight =44;
    _topScrollType =ItemByScreenWidthTopScrollViewType;
    
    
}

/**
 *  顶部的topScrollView和下面的MainScrollView
 */
-(void)createScrollView
{
    _topScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,kScreenWeight ,_topScrollViewHeight)];
    _topScrollView.delegate = self;
    _topScrollView.scrollEnabled = YES;
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_topScrollView];

    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_topScrollViewHeight,kScreenWeight,kScreenHeight-64-_topScrollViewHeight)];
    _mainScrollView.delegate = self;
    _mainScrollView.scrollEnabled = YES;
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.userInteractionEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_mainScrollView];

}

/**
 *  _topScrollView和 _mainScrollView进行填充内容
 */
-(void)setUpScrollView
{
    // ItemByScreenWidthTopScrollViewType时item宽
    CGFloat itemWidth =kScreenWeight/_topTitlesArray.count;
    
    //加载topScrollView
    for (int i=0; i<_topTitlesArray.count; i++)
    {
        switch (_topScrollType) {
            case ItemWidthByContentTopScrollViewType:
            {
            
            }
                break;
            case ItemEqualWidthTopScrollViewType:
            {
            
            }
                break;
            case ItemByScreenWidthTopScrollViewType:
            {
                LYSliderViewItem *item =[[LYSliderViewItem alloc] init];
                item.frame=CGRectMake(i*itemWidth, 0, itemWidth, _topScrollViewHeight);
                item.itemTitle =[_topTitlesArray objectAtIndex:i];
                item.itemSignImageName=[_topImagesArray objectAtIndex:i];
                
                item.topItemType = TextItemType;
                
                
                [_topScrollView addSubview:item];
            }
                break;
            default:
                break;
        }
    }

    
    //加载mainScrollView

}

#pragma -mark 属性值设置
-(void)setSelectedIndex:(NSInteger)selectedIndex
{

}

-(NSInteger)numberOfViewControllers
{
    return _topTitlesArray.count;
}

-(void)setTopScrollType:(topScrollViewType)topScrollType
{
    switch (topScrollType) {
        case ItemByScreenWidthTopScrollViewType:
            
            break;
        case ItemEqualWidthTopScrollViewType:
            
            break;
        case ItemWidthByContentTopScrollViewType:
            
            break;
        default:
            break;
    }
}
#pragma -mark 自定义方法


#pragma -mark UIScrollViewDelegate

@end


#define labelFontSize   15

@interface LYSliderViewItem ()
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UIButton *signButton;
@end
@implementation LYSliderViewItem

-(id)init
{
    if (self=[super init])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor =[UIColor grayColor];
        
        _signButton = [[UIButton alloc] init];
        
        [self addSubview:_titleLabel];
        [self addSubview:_signButton];
    }
    return self;
}

-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    UIGestureRecognizer *tap =[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
    UIView *tapView =tap.view;
    tapView.tag=tag;
    [self addGestureRecognizer:tap];

}

-(void)tapItem:(UIGestureRecognizer *)tap
{

    if ([_delegate respondsToSelector:@selector(sliderViewItem:didTapItemAtIndex:)])
    {
        [_delegate sliderViewItem:self didTapItemAtIndex:tap.view.tag];
    }
    
}

/**
 *  设置item显示的类型 (文本、图片、文本和图片)
 */
-(void)setTopItemType:(itemType)topItemType
{
    switch (topItemType) {
        case TextItemType:
            _titleLabel.hidden=NO;
            _signButton.hidden=YES;
            _titleLabel.frame=self.frame;

            break;
        case TextAndImageItemType:
            _titleLabel.hidden=NO;
            _signButton.hidden=NO;
            break;
        case ImageItemType:
            _titleLabel.hidden=YES;
            _signButton.hidden=NO;
            break;
        default:
            break;
    }
}


-(void)setItemSignImageName:(NSString *)itemSignImageName
{
    [self.signButton setImage:[UIImage imageNamed:itemSignImageName] forState:UIControlStateNormal];
    [self.signButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",itemSignImageName]] forState:UIControlStateSelected];

    
}

-(void)setItemTitle:(NSString *)itemTitle
{
    _titleLabel.text =itemTitle;
    CGSize size = [itemTitle sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:labelFontSize] forKey:NSFontAttributeName]];
    
    _titleLabel.frame=CGRectMake((self.width-size.width)/2, 10, size.width, 21);
    
    UIImage *image =[UIImage imageNamed:_itemSignImageName];
    _signButton.frame=CGRectMake(CGRectGetMaxX(_titleLabel.frame)+10, 10, image.size.width, image.size.width);
    
}

@end