//
//  XTADScrollView.h
//  PocketKitchen
//
//  Created by 夏婷 on 15/10/15.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//
/**
 简介：通用轮播控件
 1.内嵌一个PageControl，可以通过needPagecontrol这个属性设置是否需要显示PageControl，默认显示（图片张数大于1时）
 2.支持图片数组和图片地址数组，采用sdwebImage库做图片的下载与缓存；
 3.支持自动轮播的暂停和启动
 4.只支持横向轮播
 5.使用该控件要添加SDWebImage的引用
 
 实现思路:轮播模式a:collectionView有无限个Item，每次Item显示的时候通过索引取相应的图片
 轮播模式b:collectionview的Item个数为实际图片的个数，图片初始化后在整个scrollView上的显示情况：item0(pic5)、item1(pic0)、item2(pic1)、
 *          item3(pic2)、item4(pic3)、item5(pic4)。
 这么显示的原因是：在初始化图片后，会让collectionview滚动到item1的位置上，这样左滑就可以滑
 *          动到最后一张图片了，右滑也可以滑动到第二张图片。轮播的规则： 右滑--当collectionview从item1 滚动到item2的位置后，这个时候做一个无动画
 *          滚动，让位置继续滚回到item1，然后下次右滑的时候依然按照这个流程走，这样就可以保证在从最后一张滑动到第一张的时候，滚动动画的正常。左滑同右
 *          滑，只是方向变换一下。
 * 1.当图片个数为1的时候，不能自动轮播
 * 2.当图片个数为2的时候，采用轮播模式a。
 * 3.当图片个数大于2张的时候，采用轮播模式b。
 */

#import <UIKit/UIKit.h>

typedef enum {
    pageControlPositionTypeLeft = 0,
    pageControlPositionTypeMiddle,
    pageControlPositionTypeRight
}pageControlPositionType;

@interface XTADScrollView : UIView

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *imageURLArray;

/**
 *是否需要pageControl,default is YES
 */
@property (nonatomic, assign) BOOL needPageControl;
/**
 *  是否循环轮播,default is NO
 */
@property (nonatomic, assign) BOOL infiniteLoop;

/**占位图片名字*/
@property (nonatomic, copy) NSString *placeHolderImageName;

@property (nonatomic, assign) pageControlPositionType pageControlPositionType;
/**
 *  是否真正轮播
 *
 *  @return 返回YES，正在自动轮播
 */
-(BOOL)isAutoCarouseling;
/**
 *  开始轮播，默认是启动的
 */
-(void)startAutoCarousel;
/**
 *  停止自动轮播
 */
-(void)stopAutoCarousel;


@end
