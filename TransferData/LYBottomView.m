//
//  LYBottomView.m
//  TransferData
//
//  Created by lychow on 11/18/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "UIView+Extention.h"
#import "LYBottomView.h"
#import "LYConst.h"
static CGFloat imageWitdh =20;
static CGFloat imageHeight =20;

#define backGroundColor kColor(216, 216, 216, 1)
@interface LYBottomView ()

@end

@implementation LYBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.frame=CGRectMake(0, kScreenHeight-64-44, kScreenWeight, bottomHeight);
    }
    return self;
}

-(void)setupItems
{
    for (int i=0; i<_itemsImageArray.count; i++)
    {
        UIView *itemView =[[UIView alloc] initWithFrame:CGRectMake(i*kScreenWeight/_itemsImageArray.count, 0, kScreenWeight/_itemsImageArray.count, bottomHeight)];
        itemView.backgroundColor=backGroundColor;
        
        UIImage *image =[UIImage imageNamed:[_itemsImageArray objectAtIndex:i]];

        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((kScreenWeight/_itemsImageArray.count - imageWitdh)/2,(30-imageHeight)/2, imageWitdh,imageHeight)];
        imageView.image=image;
        [itemView addSubview:imageView];
        
        UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 30, kScreenWeight/_itemsImageArray.count, bottomHeight-30)];
        titleLabel.font=[UIFont systemFontOfSize:13];
        titleLabel.textColor=kColor(44, 62, 84, 1);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.text=[_itemsTitleArray objectAtIndex:i];
        [itemView addSubview:titleLabel];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItemIndex:)];
        [itemView addGestureRecognizer:tap];
        tap.view.tag=i;
        [self addSubview:itemView];
    }
    

}

-(void)popBottomView
{
[UIView animateWithDuration:0.3 animations:^{
    self.y=kScreenHeight-64-bottomHeight-44;
}];
}


-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.y=kScreenHeight-64-44;
    }];
}


-(void)tapItemIndex:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(bottomView:tapItemIndex:)]) {
        [_delegate bottomView:self tapItemIndex:tap.view.tag];
    }
}

@end
