//
//  ViewController.m
//  WaveTableview
//
//  Created by apple on 16/11/6.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "WXWaveView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) WXWaveView *waveView;

@property (weak,nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 245)];
    hearderView.backgroundColor = [UIColor colorWithRed:164/255.f  green:174/255.f blue:246/255.f alpha:1];
    self.tableView.tableHeaderView = hearderView;
    
    
}


-(void)viewDidLayoutSubviews {
    if (!self.waveView) {
        self.waveView = [WXWaveView addToView:self.tableView.tableHeaderView withFrame:CGRectMake(0, CGRectGetHeight(self.tableView.tableHeaderView.frame)-4.5, CGRectGetWidth(self.tableView.frame), 5)];
        NSLog(@"%@",self.tableView.tableHeaderView);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.waveView wave]) {
        
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",arc4random_uniform(5)];
    return cell;
}

-(void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
