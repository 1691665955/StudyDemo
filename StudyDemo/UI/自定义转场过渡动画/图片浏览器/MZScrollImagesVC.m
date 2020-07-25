//
//  MZScrollImagesVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2020/7/25.
//  Copyright © 2020 曾龙. All rights reserved.
//

#import "MZScrollImagesVC.h"
#import "MZImageBrowsingVC.h"

@interface MZScrollImagesVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation MZScrollImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览器";
    NSArray *urls = @[@"http://n.sinaimg.cn/sinacn18/352/w640h512/20180810/60c9-hhnunsq9508736.jpg",@"http://uploads.5068.com/allimg/1801/78-1P122135I5-50.jpg",@"http://5b0988e595225.cdn.sohucs.com/q_70,c_zoom,w_640/images/20180702/b90656aeceec4dd5b45de1f0a3f605c3.jpeg",@"http://b-ssl.duitang.com/uploads/item/201501/30/20150130203141_mXWze.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201209/21/20120921180035_TLYMT.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201207/28/20120728104206_c5JEu.thumb.700_0.jpeg",@"http://b-ssl.duitang.com/uploads/item/201703/30/20170330200900_UMCLz.jpeg",@"http://03imgmini.eastday.com/mobile/20181108/20181108000721_d41d8cd98f00b204e9800998ecf8427e_3.jpeg",@"http://h.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f1c7a6f67ad64034f79f019cf.jpg",@"http://i0.hdslb.com/bfs/article/7406a34172fd9c73651235ded78ea10147eb23ce.jpg"];
    for (UIImageView *imageView in self.contentView.subviews) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:urls[imageView.tag-100]]];
    }
}

- (IBAction)preview:(UITapGestureRecognizer *)sender {
    MZImageBrowsingVC *vc = [[MZImageBrowsingVC alloc] initWithImageViewArray:self.contentView.subviews currentIndex:sender.view.tag-100];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
