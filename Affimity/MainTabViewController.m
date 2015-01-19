//
//  ViewController.m
//  Affimity
//
//  Created by sandeep kumar gupta on 16/01/15.
//  Copyright (c) 2015 neevtech. All rights reserved.
//

#import "MainTabViewController.h"
#import "CustomTableViewCell.h"
#import "LoginViewController.h"
#import "Constants.h"

@interface MainTabViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>{
    NSMutableArray *_dataArray;
    NSMutableData *_responseData;
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
//    _dataArray = [@[@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
//        @"sandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar guptasandeep kumar gupta - with love",
//        @"i am really tired of this now...pls somebody help me Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."] mutableCopy];
    
//    NSString *name = [[LoginViewController sharedInstance] token];
    _dataArray = [[NSMutableArray alloc] init];
    NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
    NSString *token = [loginData objectForKey:@"auth_token"];
    NSLog(@"name = ===== %@",token);
    //http://54.68.210.79:8080/Affimity/post/1/buzz?count=20&direction=1&post_type=0&reference_post_id=0&user_token=52c7427a-66b6-455c-8f41-5f5115b43f6a
    
    // Create the request.
    NSString *buzzPageURL = [NSString stringWithFormat:@"%@%@%@buzz?count=20&direction=1&post_type=0&reference_post_id=0&user_token=%@",BaseURL,BuzzURI,Network_Id,token];
    NSLog(@"url= %@",buzzPageURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:buzzPageURL]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
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
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
//    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    NSArray * response = [jsonObject objectForKey:@"result"];
    NSUInteger successCode = [response count];
//    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
    for (int i=0; i<successCode; i++) {
        [_dataArray addObject:[response[i] objectForKey:@"post"]];
    }
    
    [self.buzzTableView reloadData];
    
//    NSUInteger successCode = [response count];
//    NSLog(@"length == %lu",(unsigned long)successCode);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma tableview datasource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    CustomTableViewCell *cell = [self.buzzTableView dequeueReusableCellWithIdentifier:@"CustomCell" ];
    cell.postTextLabel.text = _dataArray[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!self.customcell) {
        self.customcell = [self.buzzTableView dequeueReusableCellWithIdentifier:@"CustomCell" ];
    }
    self.customcell.postTextLabel.text = _dataArray[indexPath.row];
    self.customcell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.buzzTableView.frame), CGRectGetHeight(self.customcell.bounds));
    [self.customcell setNeedsLayout];
    [self.customcell layoutIfNeeded];
    
    CGFloat height = [self.customcell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    CGFloat height = 240;
    NSLog(@"height= %f",height);
    return height+0.5;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

@end
