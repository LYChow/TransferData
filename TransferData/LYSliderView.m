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
#define labelFontSize   15
#define animationViewHeight  3
#define animationTime    0.3
#define kBaseTag        1000


typedef enum : NSUInteger {
    ItemWidthAnimationViewType,
    ItemContentWidthAnimationType
} animationViewType;

@interface LYSliderView ()<UIScrollViewDelegate,LYSliderViewItemDelegate>

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

/*!
 *  把items存放在数组中
 */
@property(nonatomic,strong) NSMutableArray  *itemsArray;

@property(nonatomic ,assign)animationViewType animationViewType;
@end

@implementation LYSliderView

-(NSMutableArray *)itemsArray
{
    if (!_itemsArray)
    {
        self.itemsArray =[NSMutableArray array];
    }
    return _itemsArray;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
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
    _topScrollItemType=TextAndImageItemType;
    _animationViewType = ItemContentWidthAnimationType;
}

/**
 *  顶部的topScrollView和下面的MainScrollView
 */
-(void)createScrollView
{
    _topScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,kScreenWeight ,_topScrollViewHeight)];
    _topScrollView.delegate = self;
    _topScrollView.scrollEnabled = YES;
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;

    
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_topScrollViewHeight,kScreenWeight,kScreenHeight-64-_topScrollViewHeight)];
    _mainScrollView.delegate = self;
    _mainScrollView.scrollEnabled = YES;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.userInteractionEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;

   
    
    _animationView =[[UIView alloc] init];
    _animationView.frame=CGRectMake(0, _topScrollViewHeight-animationViewHeight,0, animationViewHeight);
    _animationView.hidden=NO;
    _animationView.backgroundColor=kColor(0,122,255,1);
    

}

/**
 *  _topScrollView和 _mainScrollView进行填充内容
 */


-(void)setUpScrollViewContent
{
    [self createScrollView];
    
    // ItemByScreenWidthTopSrollViewType时item宽
    CGFloat itemWidth =kScreenWeight/_topTitlesArray.count;

    //加载topScrollView
    for (int i=0; i<_topTitlesArray.count; i++)
    {
        //item宽度的大小 根据屏幕均分宽度 、等宽、根据内容自扩展宽度
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
                item.delegate=self;
                item.frame=CGRectMake(i*itemWidth, 0, itemWidth, _topScrollViewHeight);
                
                
                //item上面的内容类型 (文本、图片、文本和图片)

                if (_topScrollItemType == TextItemType)
                {
                    item.signButton.hidden=YES;
                    
                    item.titleLabel.text =[_topTitlesArray objectAtIndex:i];
                    item.titleLabel.frame=CGRectMake(0, 0, item.width, item.height);
                }
                else if (_topScrollItemType == TextAndImageItemType)
                {
                    UIImage *image =[UIImage imageNamed:[_topImagesArray objectAtIndex:i]];
                    CGSize imageSize =image.size;
                    
                    
                    CGSize labelSize = [[_topTitlesArray objectAtIndex:i] sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:labelFontSize] forKey:NSFontAttributeName]];
                    
                    
                    item.tag=kBaseTag+i;
                    item.frame=CGRectMake(i*itemWidth, 0, itemWidth,
                                          _topScrollViewHeight);
                    item.titleLabel.text =[_topTitlesArray objectAtIndex:i];
                    item.titleLabel.frame=CGRectMake((itemWidth-labelSize.width-imageSize.width-10)/2, (_topScrollViewHeight-labelSize.height)/2, labelSize.width, labelSize.height);
                    
                    
                    [item.signButton setImage:[UIImage imageNamed:[_topImagesArray objectAtIndex:i]] forState:UIControlStateNormal];
                    [item.signButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[_topImagesArray objectAtIndex:i]]] forState:UIControlStateSelected];
                    item.signButton.frame=CGRectMake(CGRectGetMaxX(item.titleLabel.frame)+10,(_topScrollViewHeight-image.size.height)/2, imageSize.width, imageSize.height);
                }
                else if (_topScrollItemType == ImageItemType)
                {
                    item.titleLabel.hidden=YES;
                    
                    [item.signButton setImage:[UIImage imageNamed:[_topImagesArray objectAtIndex:i]] forState:UIControlStateNormal];
                    [item.signButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[_topImagesArray objectAtIndex:i]]] forState:UIControlStateSelected];
                    item.signButton.frame=CGRectMake(0, 0, item.width, item.height);
                }
                
                [self.itemsArray addObject:item];
                [_topScrollView addSubview:item];
            }
                break;
            default:
                break;
        }
    }

    
    
    //加载mainScrollView
    _mainScrollView.contentSize=CGSizeMake(kScreenWeight*[_delegate numberOfViewControllersInSliderView:self], kScreenHeight-64-_topScrollViewHeight);

    
    for (int i=0; i<[_delegate numberOfViewControllersInSliderView:self]; i++)
    {
        UIViewController *viewController =[_delegate sliderView:self viewForViewControllerAtIndex:i];
        viewController.view.frame=CGRectMake(i*kScreenWeight, 0, kScreenWeight, kScreenHeight-64-_topScrollViewHeight);
        [_mainScrollView addSubview:viewController.view];
    }

    
    [self addSubview:_animationView];
    [self addSubview:_topScrollView];
    [self addSubview:_mainScrollView];
    
    self.selectedIndex=0;
}

#pragma -mark 属性值设置
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self scrollViewItemDidScrollItemsIndex:selectedIndex];
}

-(NSInteger)numberOfViewControllers
{
    return _topTitlesArray.count;
}

#pragma -mark 自定义方法
-(void)updateSliderItemTitleAtIndex:(NSInteger)index replaceWithTitle:(NSString *)replaceTitle
{
    LYSliderViewItem *item =  [self.itemsArray objectAtIndex:index];
    item.titleLabel.text=replaceTitle;
}


#pragma -mark 点击item时Delegate调用
-(void)sliderViewItem:(LYSliderViewItem *)item didTapItemAtIndex:(NSInteger)index
{
    
    [self scrollViewItemDidScrollItemsIndex:index];
}

-(void)scrollViewItemDidScrollItemsIndex:(NSInteger)index
{

    //当前滑到的Item状态改变
    for (int i=0; i<self.itemsArray.count; i++)
    {
        LYSliderViewItem *item =[self.itemsArray objectAtIndex:i];
        item.titleLabel.textColor =[UIColor grayColor];
        item.signButton.selected = NO;
    }
    LYSliderViewItem *currentItem =[self.itemsArray objectAtIndex:index];
    currentItem.titleLabel.textColor =kColor(0,122,255,1);
    currentItem.signButton.selected = YES ;
    
    
    //animationView动画效果、mainScrollView滚动到某一个位置
    [UIView animateWithDuration:animationTime animations:^{
        
        switch (_animationViewType) {
            case ItemWidthAnimationViewType:
                _animationView.frame=CGRectMake(currentItem.x, _topScrollViewHeight-animationViewHeight, currentItem.width, animationViewHeight);
                break;
            case ItemContentWidthAnimationType:
                _animationView.frame=CGRectMake(currentItem.x+currentItem.titleLabel.x, _topScrollViewHeight-animationViewHeight, currentItem.titleLabel.width+currentItem.signButton.width+10, animationViewHeight);
                break;
            default:
                break;
        }
    
    _mainScrollView.contentOffset=CGPointMake(index *kScreenWeight, 0);
    }];

    if ([_delegate respondsToSelector:@selector(sliderView:didScrollViewControllerAtIndex:)]) {
        [_delegate sliderView:self didScrollViewControllerAtIndex:index];
    }
}


#pragma -mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kScreenWeight
    ;
    [self scrollViewItemDidScrollItemsIndex:index];
}

@end




@interface LYSliderViewItem ()
@end
@implementation LYSliderViewItem

-(id)init
{
    if (self=[super init])
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor =[UIColor grayColor];
        _titleLabel.font =[UIFont systemFontOfSize:labelFontSize];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        
        
        _signButton = [[UIButton alloc] init];
        
        [self addSubview:_titleLabel];
        [self addSubview:_signButton];
    }
    return self;
}

-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
    UIView *tapView =tap.view;
    tapView.tag=tag;
    [self addGestureRecognizer:tap];

}

-(void)tapItem:(UIGestureRecognizer *)tap
{

    if ([_delegate respondsToSelector:@selector(sliderViewItem:didTapItemAtIndex:)])
    {
        [_delegate sliderViewItem:self didTapItemAtIndex:tap.view.tag-kBaseTag];
    }
    
}



@end