//
//  MZOtherImagesVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/11/26.
//  Copyright © 2019 曾龙. All rights reserved.
//

#import "MZOtherImagesVC.h"
#import "MZOtherImageCell.h"
#import "MZImageBrowsingVC.h"

@interface MZOtherImagesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MZOtherImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览器";
    [self.tableView registerNib:[UINib nibWithNibName:@"MZOtherImageCell" bundle:nil] forCellReuseIdentifier:@"MZOtherImageCell"];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *urls = @[@"http://n.sinaimg.cn/sinacn18/352/w640h512/20180810/60c9-hhnunsq9508736.jpg",@"http://uploads.5068.com/allimg/1801/78-1P122135I5-50.jpg",@"http://5b0988e595225.cdn.sohucs.com/q_70,c_zoom,w_640/images/20180702/b90656aeceec4dd5b45de1f0a3f605c3.jpeg",@"http://b-ssl.duitang.com/uploads/item/201501/30/20150130203141_mXWze.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201209/21/20120921180035_TLYMT.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201207/28/20120728104206_c5JEu.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201703/30/20170330200900_UMCLz.jpeg",@"http://03imgmini.eastday.com/mobile/20181108/20181108000721_d41d8cd98f00b204e9800998ecf8427e_3.jpeg",@"http://h.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f1c7a6f67ad64034f79f019cf.jpg",@"http://i0.hdslb.com/bfs/article/7406a34172fd9c73651235ded78ea10147eb23ce.jpg"];
    MZOtherImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MZOtherImageCell"];
    cell.imageUrl = urls[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *urls = @[@"http://n.sinaimg.cn/sinacn18/352/w640h512/20180810/60c9-hhnunsq9508736.jpg",@"http://uploads.5068.com/allimg/1801/78-1P122135I5-50.jpg",@"http://5b0988e595225.cdn.sohucs.com/q_70,c_zoom,w_640/images/20180702/b90656aeceec4dd5b45de1f0a3f605c3.jpeg",@"http://b-ssl.duitang.com/uploads/item/201501/30/20150130203141_mXWze.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201209/21/20120921180035_TLYMT.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201207/28/20120728104206_c5JEu.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201703/30/20170330200900_UMCLz.jpeg",@"http://03imgmini.eastday.com/mobile/20181108/20181108000721_d41d8cd98f00b204e9800998ecf8427e_3.jpeg",@"http://h.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f1c7a6f67ad64034f79f019cf.jpg",@"http://i0.hdslb.com/bfs/article/7406a34172fd9c73651235ded78ea10147eb23ce.jpg"];
    MZOtherImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MZImageBrowsingVC *vc = [[MZImageBrowsingVC alloc] initWithImageUrlArray:urls currentImageView:cell.iconView currentIndex:indexPath.row];
    vc.indexPath = indexPath;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
