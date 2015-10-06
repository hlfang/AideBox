//
//  HMViewController.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  首页Controller

#import "HMViewController.h"
#import "HLTimeLoopImageView.h"
#import "HPAdvert.h"
#import "AdvertParser.h"
#import "AdvertViewModel.h"
#import "HPRecommend.h"
#import "RecommendParser.h"
#import "RecommViewModel.h"
#import "ITableCellItemView.h"
#import "HLPresentModalManager.h"
#import "HMSearchController.h"
#import "HLFixedHeaderTableView.h"

static const CGFloat kHomeTableCellHeight = 80.0f;

@interface HMViewController ()

@property (nonatomic, strong) HLFixedHeaderTableView *mTableView;

@property (nonatomic, strong) HLFixedHeaderView *fixedHeaderView;

@property (nonatomic, strong) LGRefreshView *headRefreshView;

/**
 *  推荐列表数据
 */
@property (nonatomic, strong) NSArray *recommList;

/**
 *  轮播视图
 */
@property (nonatomic, strong) HLTimeLoopImageView *imageLoopView;

/**
 *  推荐列表参数对象
 */
@property (nonatomic, strong) HPRecommend *recommParam;

/**
 *  搜索页面
 */
@property (nonatomic, strong) HMSearchController *searchController;


@property (nonatomic, strong) HMTableHeader *tableHeader;

@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation HMViewController


#pragma mark -------------------以下为页面交互部分--------------------

-(void)searchButtonTouchHandler:(id)sender{
//    [self.navigationController pushViewController:self.searchController animated:YES];
}

-(void)tableHeader:(HMTableHeader *)tableHeader didSelectedItem:(HMHeaderDataItem *)item{
    ObjLog(item.title);
}

-(void)itemView:(HMRecommItemView *)itemView appid:(NSString *)appid{
    if(appid.length == 0){
        return;
    }
    SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
    storeController.delegate = self;
    NSDictionary *appParameters = @{SKStoreProductParameterITunesItemIdentifier:appid};
    [storeController loadProductWithParameters:appParameters completionBlock:^(BOOL result, NSError *error) {
    }];
    [self presentViewController:storeController animated:YES completion:NULL];
}

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:NULL];
}

/**
 *  下拉刷新代理方法
 *
 *  @param refreshView 下拉刷新组件
 */
-(void)refreshViewRefreshing:(LGRefreshView *)refreshView{
}

/**
 *  上拉加载下一页方法
 */
-(void)footerRefreshHandler{
    
}

#pragma mark -------------------以下为请求数据部分--------------------

/**
 *  获取首页轮播图片列表
 */
-(void)fetchLoopImageDataList{
    id<IDispatch> aDispatch = [self fetchBaseDispatchInIdle];
    NSString *urlString = @"http://bjone.api.apptao.com/topicdir";
    AdvertParser *parser = [[AdvertParser alloc] init];
    BOOL cacheEnable = NO;
    if(self.imageLoopView.imageModelList.count == 0){
        id cacheData = [aDispatch fetchCacheDataWithUrlString:urlString dataParser:parser];
        [self didBuildAdvertLoopWithResultData:cacheData];
        cacheEnable = YES;
    }
    HPAdvert *advertParam = [[HPAdvert alloc] init];
    NSDictionary *aParam = [advertParam getDictionary];
    __weak typeof(self) welf = self;
    [aDispatch sendRequestWithUrlString:urlString cacheEnable:cacheEnable param:aParam reqMethod:HTTRequestGET dataParser:parser success:^(id resultData) {
        [welf didBuildAdvertLoopWithResultData:resultData];
        aDispatch.idle = NO;
    } failgure:^(NSString *aMess) {
        aDispatch.idle = NO;
    }];
}

/**
 *  获取首页推荐列表
 */
-(void)fetchRecommendList{
    id<IDispatch> aDispatch = [self fetchBaseDispatchInIdle];
    RecommendParser *parser = [[RecommendParser alloc] init];
    NSString *urlString = @"http://bjone.api.apptao.com/mustlist";
    BOOL cacheEnable = NO;
    if(self.recommList.count == 0){
        id cacheData = [aDispatch fetchCacheDataWithUrlString:urlString dataParser:parser];
        [self fetchRecommendListCompleteHandler:cacheData];
        cacheEnable = YES;
    }
    
    NSDictionary *aParam = [self.recommParam getDictionary];
    __weak typeof(self) welf = self;
    [aDispatch sendRequestWithUrlString:urlString cacheEnable:cacheEnable param:aParam reqMethod:HTTRequestGET dataParser:parser success:^(id resultData) {
        [welf fetchRecommendListCompleteHandler:resultData];
        aDispatch.idle = NO;
    } failgure:^(NSString *aMess) {
        aDispatch.idle = NO;
    }];
}

#pragma mark -------------------以下为请求返回部分--------------------

/**
 *  根据返回的数据构造广告轮播视图
 *
 *  @param resultData 广告轮播返回数据
 */
-(void)didBuildAdvertLoopWithResultData:(id)resultData{
    if(!resultData){
        return;
    }
    if(![resultData isKindOfClass:[NSArray class]]){
        return;
    }
    
    __weak typeof(self) welf = self;
    NSArray *advertList = (NSArray *)resultData;
    NSMutableArray *imgModelList = [NSMutableArray arrayWithCapacity:advertList.count];
    for(AdvertViewModel *vm in advertList){
        HLImageDownloadManager *imageloader = [[HLImageDownloadManager alloc] init];
        [imageloader imageDonloadWithImagePath:vm.imagePath completion:^(UIImage *aImage) {
            if(aImage){
                HLImageModel *imgModel = [[HLImageModel alloc] init];
                imgModel.image = aImage;
                [imgModelList addObject:imgModel];
                welf.imageLoopView.imageModelList = imgModelList;
            }
        }];
    }
}

/**
 *  获取推荐列表完成后处理方法
 *
 *  @param resultData 推荐列表返回数据
 */
-(void)fetchRecommendListCompleteHandler:(id)resultData{
    if(![resultData isKindOfClass:[NSArray class]]){
        return;
    }
    
    self.recommList = resultData;
    [self.mTableView reloadData];
}

#pragma mark -------------------以下是进度显示部分--------------------



#pragma mark -------------------以下是页面跳转部分--------------------


#pragma mark -------------------以下是UITableView部分--------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHomeTableCellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recommList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"homeCellIndentifier";
    HLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[HLTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        HMRecommItemView *itemView = [[HMRecommItemView alloc] init];
        itemView.delegate = self;
        cell.itemView = itemView;
    }
    
    if(indexPath.row >= 0 && indexPath.row < self.recommList.count){
        RecommViewModel *itemData = [self.recommList objectAtIndex:indexPath.row];
        id<ITableCellItemView> itemView = cell.itemView;
        itemView.itemData = itemData;
        itemView.flagImage = nil;
        if(itemData.icon.length > 0){
            HLImageDownloadManager *imageLoader = [[HLImageDownloadManager alloc] init];
            [imageLoader imageDonloadWithImagePath:itemData.icon delegate:self forTableCell:cell];
        }
    }
    
    return cell;
}

-(void)imageDownloadCompleteForTableCell:(HLTableViewCell *)tableCell imagePath:(NSString *)imgPath image:(UIImage *)aImage{
    if(!aImage || !tableCell || !imgPath){
        return;
    }

    RecommViewModel *itemData = tableCell.itemView.itemData;
    if([itemData.icon isEqualToString:imgPath]){
        tableCell.itemView.flagImage = aImage;
    }
}

#pragma mark -------------------以下是页面初始化部分--------------------

-(void)initSubviews{
    [super initSubviews];
    [self addRightButtonWithNormalImage:ic_search_normal highlightImage:ic_search_highlight selector:@selector(searchButtonTouchHandler:)];
    [self.contentView addSubview:self.mTableView];
    self.headRefreshView = [[LGRefreshView alloc] initWithScrollView:self.mTableView delegate:self];
}

#pragma mark -------------------以下是页面布局部分--------------------

-(void)layoutSubElements{
    [super layoutSubElements];
    
    self.mTableView.frame = self.contentView.bounds;

    self.mTableView.fixedHeaderView = self.fixedHeaderView;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


#pragma mark -------------------以下是Controller生命周期部分--------------------

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isPushView && self.runFirst){
        self.runFirst = NO;
        [self fetchLoopImageDataList];
        [self fetchRecommendList];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)destory{
    [_imageLoopView removeFromSuperview];
    [_mTableView removeFromSuperview];
    _recommList = nil;
    _mTableView = nil;
    _searchController = nil;
    _imageLoopView = nil;
    _tableHeader = nil;
    _fixedHeaderView = nil;
    _headRefreshView = nil;
    [super destory];
}

#pragma mark -------------------以下为Getters And Setters部分--------------------

- (HLFixedHeaderTableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[HLFixedHeaderTableView alloc] init];
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, kHomeTableCellHeight, 0.0f);
    }
    return _mTableView;
}

- (HLTimeLoopImageView *)imageLoopView
{
    if (!_imageLoopView) {
        _imageLoopView = [[HLTimeLoopImageView alloc] init];
        _imageLoopView.loopInterval = 3;
    }
    return _imageLoopView;
}

- (HPRecommend *)recommParam
{
    if (!_recommParam) {
        _recommParam = [[HPRecommend alloc] init];
    }
    return _recommParam;
}

- (HMSearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[HMSearchController alloc] init];
    }
    return _searchController;
}

- (HMTableHeader *)tableHeader
{
    if (!_tableHeader) {
        _tableHeader = [[HMTableHeader alloc] init];
        _tableHeader.delegate = self;
    }
    return _tableHeader;
}

- (HLFixedHeaderView *)fixedHeaderView
{
    if (!_fixedHeaderView) {
        CGRect headerFrame = CGRectMake(0.0f, 0.0f, self.mTableView.width, kLoopImageHeight + 30.0f);
        _fixedHeaderView = [[HLFixedHeaderView alloc] initWithFrame:headerFrame topView:self.imageLoopView bottomView:self.tableHeader topHeight:kLoopImageHeight];
    }
    return _fixedHeaderView;
}

@end
