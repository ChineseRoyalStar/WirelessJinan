//
//  XTADScrollView.m
//  PocketKitchen
//
//  Created by 夏婷 on 15/10/15.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import "XTADScrollView.h"
#import "CycleImageCell.h"

@interface XTADScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate>

#pragma mark -轮播视图声明
@property (nonatomic, retain) UICollectionView *cycleCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
#pragma mark - 分页控制器声明
@property (nonatomic, strong) UIPageControl *pageControl;
#pragma mark - 索引声明
@property (nonatomic, assign) NSInteger currentIndex;
#pragma mark - 定时器声明
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XTADScrollView

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (self.pageControl && [self imageCount] >= 2)
    {
        self.pageControl.numberOfPages = _imageArray.count;
    }
    
    [self resetViewStateAndStartAutoCarousel];
    
}
-(void)setImageURLArray:(NSArray *)imageURLArray
{
    _imageURLArray = imageURLArray;
    
    if (self.pageControl)
    {
        self.pageControl.numberOfPages = _imageURLArray.count;
    }
    
    [self resetViewStateAndStartAutoCarousel];
}
-(void)resetViewStateAndStartAutoCarousel
{
    if (self.cycleCollectionView)
    {
        [_cycleCollectionView reloadData];
        [self startAutoCarousel];
    }
    
    if (self.pageControl && [self imageCount] > 1) //图片个数最少为2张才能显示分页控制器。
    {
        [self.pageControl setHidden:!_needPageControl];
    }
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttribute];
        [self createSubViews];
        
    }
    return self;
}
-(void)initAttribute
{
    _needPageControl = YES;
    _infiniteLoop = NO;
    _pageControlPositionType = pageControlPositionTypeLeft;
    _currentIndex = 0;
}
#pragma mark - 创建子视图

-(void)createSubViews
{
    //创建collectionView
    [self createCycleView];
    //创建PageControl
    [self createPageControl];
}
#pragma mark - 创建collectionView
-(void)createCycleView
{
    if (_layout) {
        //如果已经存在，就不再创建
        return;
    }
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _cycleCollectionView.backgroundColor = [UIColor whiteColor];
    //停靠模式，宽高都自由
    _cycleCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _cycleCollectionView.delegate = self;
    _cycleCollectionView.dataSource = self;
    _cycleCollectionView.pagingEnabled = YES;
    _cycleCollectionView.showsHorizontalScrollIndicator= NO;
    [self addSubview:_cycleCollectionView];
    //注册轮播cell
    [_cycleCollectionView registerClass:[CycleImageCell class] forCellWithReuseIdentifier:@"CycleImageCell"];
}

#pragma mark - 创建PageControl
-(void)createPageControl
{
    if (_pageControl) {
        //如果已经存在，不用再创建
        return;
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width - 80, CGRectGetMaxY(_cycleCollectionView.frame) - 30, 60, 30)];
    _pageControl.userInteractionEnabled = YES;
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];//当前显示页的页码颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];//普通模式的页码颜色
    [self addSubview:_pageControl];
    
}
#pragma mark - 对外开放方法
- (BOOL)isAutoCarouseling
{
    if (self.cycleCollectionView)
    {
        if ([self imageCount] < 2)
        {
            return NO;
        }
        else
        {
            if (self.timer)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    else
    {
        return NO;
    }
}

- (void)startAutoCarousel
{
    if (_infiniteLoop) //启用无限轮播
    {
        if ([self imageCount] >= 2) //图片个数必须最少2张，才能自动轮播
        {
            [self starTimer];
        }
    }
    else
    {
        [self stopTimer];
    }
}

- (void)stopAutoCarousel
{
    [self stopTimer];
}


#pragma mark - 启动定时器
-(void)starTimer
{
    if (_timer) {
        
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(roll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    if (_timer == nil) {
        
        return;
    }
    [_timer invalidate];
    _timer = nil;
    
}
-(void)roll
{
    if (_cycleCollectionView) {
        //取出当前显示的cell
        NSIndexPath *indexPath = [_cycleCollectionView indexPathsForVisibleItems].lastObject ;
        if (indexPath) {
            //显示下一张
            [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item + 1 inSection:0] atScrollPosition:0 animated:YES];
        }
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
            [self scrollViewDidEndDecelerating:_cycleCollectionView];
        });
    }
    
}

-(NSInteger) imageCount
{
    if (_imageArray) {
        return  [_imageArray count];
    }else if (_imageURLArray)
    {
        return [_imageURLArray count];
    }else
        return 0;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageArray) {
        if ([_imageArray count] >= 2) {
            
            return INT16_MAX;
        }
        return [_imageArray count];
    }
    if (_imageURLArray) {
        if ([_imageURLArray count] >= 2) {
            
            return INT16_MAX;
        }
        return [_imageURLArray count];
    }else
    {
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CycleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleImageCell" forIndexPath:indexPath];
    cell.placeHolderImageName = _placeHolderImageName;
    NSInteger imageIndex = [self indexWithOffset:indexPath.item];
    if (_imageArray) {
        
        cell.imageName = _imageArray[imageIndex];
    }else if (_imageURLArray)
    {
        cell.imageURL = _imageURLArray[imageIndex];
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

}

-(NSInteger)indexWithOffset:(NSInteger)offset
{
    if (_imageArray) {
        
        return (offset % [_imageArray count]);
    }else if (_imageURLArray)
    {
        return (offset % [_imageURLArray count]);
    }else
    {
        return 0;
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.x /scrollView.frame.size.width;
    NSInteger imageCount = 0;
    if (_imageArray) {
        imageCount = [_imageArray count];
    }else if (_imageURLArray)
    {
        imageCount = [_imageURLArray count];
    }
    
    
    _pageControl.currentPage = offset%imageCount;
    
    
    _currentIndex = [self indexWithOffset:offset];
}




#pragma mark - 将要开始拖拽，停止自动轮播
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAutoCarousel];
}

#pragma mark - 已经结束拖拽，启动自动轮播
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startAutoCarousel];
}

@end
