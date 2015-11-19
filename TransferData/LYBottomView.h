//
//  LYBottomView.h
//  TransferData
//
//  Created by lychow on 11/18/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat bottomHeight =50;

@class LYBottomView;
@protocol LYBottomViewDelegate <NSObject>



-(void)bottomView:(LYBottomView *)bottomView tapItemIndex:(NSInteger)index;

@end

typedef enum : NSUInteger {
    widthByScreenWidthItemType,
    equalWidthItemType
} ItemType;

@interface LYBottomView : UIView
/*!
 *  items的标题数组
 */
@property(nonatomic,strong) NSArray  *itemsTitleArray;

/*!
 *  items的图片数组
 */
@property(nonatomic,strong) NSArray  *itemsImageArray;

@property(nonatomic,weak) id <LYBottomViewDelegate> delegate;

/*!
 *  设置items
 */
-(void)setupItems;

/*!
 *  弹出底部View
 */
-(void)popBottomView;

/*!
 *  隐藏底部的bottomView
 */
-(void)hiddenBottomView;
@end
