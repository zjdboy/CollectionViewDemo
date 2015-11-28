//
//  ViewController.m
//  LPJCollectionDemo
//
//  Created by lovepeijun on 15/11/28.
//  Copyright © 2015年 lovepeijun. All rights reserved.
//

#import "ViewController.h"
#import "LPJCell.h"
#define itmeSize CGSizeMake(self.view.bounds.size.width/3.0, 40)
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
//数据
@property(nonatomic, strong)NSArray *itemsData;/** item数据组 */
@property(nonatomic, weak)UIView *bottomView; /** bottomView */
@property(nonatomic, weak)UICollectionView *menuVIew; /** menuView */
@property(nonatomic, weak)UICollectionView *pageView; /** 内容展示View */
@end

@implementation ViewController
static NSString *ID = @"meunDemo";
static NSString *PageID = @"pageView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //使用collectionview来创建
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = itmeSize;
    
    
    
    UICollectionView *menuVIew = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 22, self.view.bounds.size.width, 40) collectionViewLayout:layout];
    menuVIew.dataSource = self;
    menuVIew.delegate = self;
    menuVIew.scrollEnabled = YES;
    menuVIew.bounces = YES;
    menuVIew.showsHorizontalScrollIndicator = NO;
    menuVIew.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    menuVIew.backgroundColor = [UIColor clearColor];
    //注册
    [menuVIew registerClass:[LPJCell class] forCellWithReuseIdentifier:ID];
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor redColor];
    [menuVIew addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.frame = CGRectMake(0, menuVIew.bounds.size.height - 3,self.view.bounds.size.width/3.0, 3);
    [self.view addSubview:menuVIew];
    self.menuVIew = menuVIew;
    
    
    UICollectionViewFlowLayout *pageLayout = [[UICollectionViewFlowLayout alloc] init];
    pageLayout.minimumInteritemSpacing = 0;
    pageLayout.minimumLineSpacing = 0;
    pageLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    pageLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 40);
    
    
    UICollectionView *pageView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 62, self.view.bounds.size.width, self.view.bounds.size.height - 40) collectionViewLayout:pageLayout];
    pageView.dataSource = self;
    pageView.delegate = self;
    pageView.scrollEnabled = YES;
    pageView.bounces = YES;
    pageView.showsHorizontalScrollIndicator = NO;
    pageView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    pageView.pagingEnabled = YES;
    [self.view addSubview:pageView];
    self.pageView = pageView;
    //注册
    [pageView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:PageID];
}






#pragma mark - Lazy
- (NSArray *)itemsData
{
    if (_itemsData == nil) {
        _itemsData = [NSArray array];
        _itemsData = @[@"大陆AV",@"欧美AV", @"日韩AV", @"其他",@"小狗", @"小猫", @"小动物"];
    }
    return _itemsData;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menuVIew == collectionView) {
        LPJCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        NSLog(@"%@",self.itemsData[indexPath.row]);
        item.titleName = self.itemsData[indexPath.row];
        return item;
    }else
    {
        UICollectionViewCell *pageitem = [collectionView dequeueReusableCellWithReuseIdentifier:PageID forIndexPath:indexPath];
        int r  = arc4random() % 255;
        int g  = arc4random() % 255;
        int b  = arc4random() % 255;
        
        pageitem.backgroundColor = [UIColor colorWithRed:r/255.0 green: g/255.0 blue:b/255.0 alpha:1];
        //        pageitem.backgroundColor = [UIColor greenColor];
        return pageitem;
    }
    
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menuVIew == collectionView) {
        LPJCell *cell = (LPJCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //设置bottomView的frame
        NSLog(@"%ld",indexPath.row);
        [UIView animateWithDuration:.2 animations:^{
            self.bottomView.frame = CGRectMake(cell.frame.origin.x, cell.bounds.size.height - 3, cell.bounds.size.width, 5);
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            [self.pageView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            
        }];
        
    }
    
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.pageView) {
        int index = scrollView.contentOffset.x / self.pageView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self collectionView:self.menuVIew didSelectItemAtIndexPath:indexPath];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.pageView) {
        if (![self isZeroSize:itmeSize]) {
            self.bottomView.frame = CGRectMake(scrollView.contentOffset.x/self.pageView.frame.size.width * self.view.bounds.size.width/3.0 , self.menuVIew.bounds.size.height - 3,self.view.bounds.size.width/3.0, 5);
        }
        
    }
}


- (BOOL)isZeroSize:(CGSize)size
{
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        return YES;
    }
    return NO;
}



@end
