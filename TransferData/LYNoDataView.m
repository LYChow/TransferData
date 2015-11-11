//
//  LYNoDataView.m
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYNoDataView.h"
@interface LYNoDataView()

/**
 *  显示的图片
 */
@property (nonatomic, strong) UIImageView  * iconImage;

/**
 *  显示的文本
 */
@property (nonatomic, strong) UILabel * textLabel;
@end
@implementation LYNoDataView

-(id)init
{
    if (self = [super init])
    {
        _iconImage = [[UIImageView alloc] init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:_iconImage action:@selector(tapNoDataView)];
        [self addGestureRecognizer:tap];
        [self addSubview:_iconImage];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)updateNoDataViewImage:(NSString *)imageName tipsLabel:(NSString *)tips viewType:(viewType)type
{
    switch (type) {
        case textAndImageViewType:
        {

            if (imageName != nil)
            {
                _iconImage.image = [UIImage imageNamed:imageName];
            }
            if (tips != nil)
            {
                _textLabel.text = tips;
            }
            _iconImage.frame = CGRectMake((self.frame.size.width - _iconImage.image.size.width)/2, (self.frame.size.height - _iconImage.image.size.height - _textLabel.frame.size.height)/2, _iconImage.image.size.width, _iconImage.image.size.height);
            _textLabel.frame = CGRectMake((self.frame.size.width - _textLabel.frame.size.width)/2, _iconImage.frame.size.height + _iconImage.frame.origin.y, _textLabel.frame.size.width, _textLabel.frame.size.height);
            _iconImage.hidden = NO;
            _textLabel.hidden = NO;
            break;
        }
        default:
            break;
    }
}

-(void)showNoDataViewInParentView:(UIView *)parentView
{
    if (self.superview)
    {
        [self removeFromSuperview];
    }
    self.frame=parentView.bounds;
    [parentView addSubview:self];
}

-(void)hiddenNodataView
{
    _iconImage.hidden=YES;
    _textLabel.hidden=YES;
}

-(void)showNodataView
{
    _iconImage.hidden=NO;
    _textLabel.hidden=NO;
}


-(void)tapNoDataView
{
    if ([_delegate respondsToSelector:@selector(tapNoDataViewReloadData)]) {
        [_delegate tapNoDataViewReloadData];
    }
}


@end
