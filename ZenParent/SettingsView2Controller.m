//
//  SettingsView2Controller.m
//  ZenParent
//
//  Created by Soumya Ranjan on 07/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "SettingsView2Controller.h"
#import "SettingsSelectionView.h"
#import "HOMEViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFHTTPRequestOperationManager.h"


@interface SettingsView2Controller ()


{
    NSMutableArray *childDic ;

    NSArray *tableData;

}

@end

@implementation SettingsView2Controller

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"Settings View";
    
    
    _dobButton.layer.cornerRadius = 10; // this value vary as per your desire
    _dobButton.clipsToBounds = YES;
   // NSLog(@"milti%@",_MiltiSelection);
    tableData = [[NSArray alloc]initWithObjects:@"Kids Interest",@"Qualities you would like to instill in your child" ,nil];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"SKIP" style:UIBarButtonItemStylePlain target:self action:@selector(skipTheScreen)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Question";
    
    
    
}

-(void)skipTheScreen
{
    // update to server
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    
    NSString *userDateOfBirth = [[NSUserDefaults standardUserDefaults]objectForKey:@"dob"];
    
    NSLog(@"usertoken ====%@",userDateOfBirth);
    

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"user_id" : UserId ,
                                 
                                 @"token" : userToken ,
                                 
                                 @"dob"  : userDateOfBirth
                                 
                                 };
    
    
    [manager POST:@"http://zenparent.in/api/preference" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
        
        // send to Home Screen
        
        HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                  
                                  instantiateViewControllerWithIdentifier:@"HOMEIOS"];
        
        [self.navigationController pushViewController:wc animated:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    

}

-(void)viewWillAppear:(BOOL)animated{


    [_settings2View reloadData];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    //  cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.textLabel.text = tableData[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:116.0f/255.0f
                                               green:79.0f/255.0f
                                                blue:141.0f/255.0f
                                               alpha:1.0f];
    
    
    if (indexPath.row == 1) {
       cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    }

    if (indexPath.row == 0 ){
        cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status22"];
        
    }else if (indexPath.row == 1 ){
        
        cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status33"];
    }
    

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (indexPath.row == 0){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"selected2"];
        
        childDic = [[_MiltiSelection objectAtIndex:5]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _settings2View;
        
        [self.navigationController pushViewController:wc animated:YES];
        
    }else if (indexPath.row == 1){
        
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"selected2"];
        
        childDic = [[_MiltiSelection objectAtIndex:6]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _settings2View;
        
        [self.navigationController pushViewController:wc animated:YES];
        
    }
    
    
}
- (IBAction)donButtonPressed:(id)sender {
    
    
    // UPDATE to SERVER

    
        int i = 0 ;
 
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"REG_userId"];
    
    NSLog(@"userID ====%@",userId);
    
     NSString *userToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"REG_TOKEN"];
    
     NSLog(@"usertoken ====%@",userToken);
    
    
    
    NSString *userDateOfBirth = [[NSUserDefaults standardUserDefaults]objectForKey:@"dob"];
    
    NSLog(@"usertoken ====%@",userDateOfBirth);
    
    
    
    NSMutableArray *parameters1 = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"preverslyIDS"] mutableCopy];
    NSLog(@"tags ====%@",parameters1);
    
   
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     //NSMutableDictionary *dicti = [[NSMutableDictionary alloc] init];
 
    [parameters setObject: userId forKey:@"user_id"];
    [parameters setObject: userToken forKey:@"token"];
    [parameters setObject: userDateOfBirth forKey:@"dob"];
    
    for (i = 0 ; i < parameters1.count   ; i++) {
        
        [parameters setObject:[parameters1 objectAtIndex:i] forKey:[NSString stringWithFormat:@"tags[%d]",i]];
    
    }
   
    
    NSLog(@"parameters :  %@",parameters);
    
    [manager POST:@"http://zenparent.in/api/preference" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
       
        // send to Home Screen
        
        HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                  
                                  instantiateViewControllerWithIdentifier:@"HOMEIOS"];
        
        [self.navigationController pushViewController:wc animated:YES];
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         NSLog(@"error code %ld",(long)[operation.response statusCode]);
        
    }];

}


@end
