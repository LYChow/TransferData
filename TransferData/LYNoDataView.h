//
//  LYNoDataView.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    textViewType,
    imageViewType,
    textAndImageViewType
} viewType;

@protocol LYNoDataViewDelegate <NSObject>

-(void)tapNoDataViewReloadData;

@end


@interface LYNoDataView : UIView

@property(nonatomic,weak) id <LYNoDataViewDelegate> delegate;


-(void)showNoDataViewInParentView:(UIView *)parentView;

/*!
 *  设置/更新 noDataView的Image和Text
 *
 *  @param imageName 背景图
 *  @param tips      提示语
 *  @param type      noDataViewType
 */
-(void)updateNoDataViewImage:(NSString *)imageName tipsLabel:(NSString *)tips viewType:(viewType)type;

-(void)hiddenNodataView;

-(void)showNodataView;

@end
