//
//  ViewController.m
//  Affimity
//
//  Created by sandeep kumar gupta on 16/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import "MainTabViewController.h"
#import "CustomTableViewCell.h"

@interface MainTabViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *buzzTableView;
@property (strong, nonatomic) CustomTableViewCell *customcell;

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buzzTableView.dataSource = self;
    self.buzzTableView.delegate = self;
    _dataArray = [@[@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        @"sandeep kumar gupta",
        @"i am really tired of this now...pls somebody help me Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    CustomTableViewCell *cell = [self.buzzTableView dequeueReusableCellWithIdentifier:@"CustomCell" ];
    cell.postTextLabel.text = _dataArray[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!self.customcell) {
        self.customcell = [self.buzzTableView dequeueReusableCellWithIdentifier:@"CustomCell" ];
    }
    self.customcell.postTextLabel.text = _dataArray[indexPath.row];
//    [self configureCell:self.customcell forIndexPath:indexPath isForOffscreenUse:YES];]
    [self.customcell.contentView setNeedsLayout];
    [self.customcell.contentView layoutIfNeeded];
    
    CGFloat height = [self.customcell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    CGFloat height = 240;
    NSLog(@"height= %f",height);
    return height+1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

@end
