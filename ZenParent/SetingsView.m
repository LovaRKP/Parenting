//
//  SetingsView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "SetingsView.h"
#import "SettingsSelectionView.h"
#import "HomeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "SettingsView2Controller.h"

#import <QuartzCore/QuartzCore.h>

@interface SetingsView ()
{
  
    NSMutableArray *Settings;
    NSMutableArray *childDic;
    NSString *useridValue;
   // NSString *userTokenValue;
    NSMutableArray *selectedIDS;
    CDActivityIndicatorView * activityIndicatorView ;
    NSDate *userDate;
    NSString *dateString;
    NSString *dateToDisplay;
    
}


@end



@implementation SetingsView

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      self.screenName = @"Settings View";
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    _DatePickerView.hidden = YES;
    _PickerToolBar.hidden = YES;
    
    
    self.navigationItem.title = @"Your Details";
      [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
   self.navigationController.navigationBar.tintColor = [UIColor whiteColor];


    [_mytable reloadData];
    
    selectedIDS = [[NSMutableArray alloc]init];
    
    _nextButton.layer.cornerRadius = 10; // this value vary as per your desire
    _nextButton.clipsToBounds = YES;
    
    //[self.navigationItem setHidesBackButton:YES animated:YES];
 
    
    //Default Values
    
    [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"IDstatus"] ;
    [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"IDstatus1"] ;
    [[NSUserDefaults standardUserDefaults]setObject:@"10" forKey:@"IDstatus2"] ;
    [[NSUserDefaults standardUserDefaults]setObject:@"12" forKey:@"IDstatus3"] ;
    [[NSUserDefaults standardUserDefaults]setObject:@"15" forKey:@"IDstatus4"] ;


    NSString *userTokeValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];

    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{
                           
                             @"user_id":UserId,
                             
                             @"token": userTokeValue
                             
                             };
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [manager POST:@"http://zenparent.in/api/preference" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my prefarences Value :%@", responseObject);
        
        NSMutableArray *resulta = [[NSMutableArray alloc]init];
        
        resulta = [responseObject objectForKey:@"result"];
    
        Settings = resulta;
        NSLog(@"myrelult =%@",resulta);

        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self.mytable reloadData];
                            [activityIndicatorView stopAnimating];
                       });
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%ld", (long)error.code);
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self.mytable reloadData];
                                [activityIndicatorView stopAnimating];
                           
                       });
      
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.mytable reloadData];
    
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
    return [Settings count]-3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (indexPath.row == 0 ){
    cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
        
       cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
        
    }else if (indexPath.row == 1 ){
        
        cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status1"];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
    }else if (indexPath.row == 2 ){
        
        cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status2"];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
    }
    else if (indexPath.row == 3 ){
        
        cell.detailTextLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"status3"];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
    }
    else if (indexPath.row == 4 ){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString * valueOfLabe = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"DetailTextLabelDOB"]];
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"DetailTextLabelDOB"] == nil || [[NSUserDefaults standardUserDefaults]objectForKey:@"DetailTextLabelDOB"] == (id)[NSNull null] ) {
            NSLog(@"Value of %@",valueOfLabe);
            
             cell.detailTextLabel.text = @"Please Select The D.O.B";
             cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
          
        }else {
        
             NSLog(@"Value of %@",valueOfLabe);
            
            cell.detailTextLabel.text = valueOfLabe;
            cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
 
        }
        
      

    }

    cell.textLabel.text = [[Settings objectAtIndex:indexPath.row]objectForKey:@"parent"];
    
    if (indexPath.row == 4) {
      
         cell.textLabel.text = @"Select Date Of Birth";
    }
    
    cell.textLabel.textColor = [UIColor colorWithRed:116.0f/255.0f
                                               green:79.0f/255.0f
                                                blue:141.0f/255.0f
                                               alpha:1.0f];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
        
    }else if (indexPath.row == 1){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }else if (indexPath.row == 2){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
  
    }
    else if (indexPath.row == 3){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }else if (indexPath.row == 4){

        
        // Working On this to add date picker
        
        
        [_PickerToolBar setTintColor:[UIColor whiteColor]];

        _DatePickerView.hidden = NO;
        _PickerToolBar.hidden = NO;
        
        _DatePickerView.backgroundColor = [UIColor lightGrayColor];
        _PickerToolBar.backgroundColor = [UIColor blackColor];
     
        
        
  [_DatePickerView addTarget:self   action:@selector(LabelChange:)forControlEvents:UIControlEventValueChanged];

        
    }else if (indexPath.row == 5){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }else if (indexPath.row == 6){
        SettingsSelectionView *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     
                                     instantiateViewControllerWithIdentifier:@"Settings"];
        
        childDic = [[Settings objectAtIndex:indexPath.row]objectForKey:@"childs"];
        wc.tableData = childDic;
        wc.table = _mytable;
        
        [self.navigationController pushViewController:wc animated:YES];
  
    }
    

}




- (IBAction)dobButtonPressed:(id)sender {
    
    
    
    [selectedIDS removeAllObjects];
    
    NSLog(@"selctedids===%@",selectedIDS);

  
    [selectedIDS addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IDstatus"]];
    [selectedIDS addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IDstatus1"]];
    [selectedIDS addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IDstatus2"]];
    [selectedIDS addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IDstatus3"]];
    [selectedIDS addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"IDstatus4"]];
    
    NSLog(@"selectedArray%@",selectedIDS);
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedIDS forKey:@"preverslyIDS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
dateToDisplay = [[NSUserDefaults standardUserDefaults]objectForKey:@"preverslyIDS"];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"dob"] != nil) {

        SettingsView2Controller *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                       instantiateViewControllerWithIdentifier:@"SecondView"];
        
        wc.MiltiSelection = Settings;
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }else {

        
        if ([UIAlertController class])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ZenParent" message:@"Please Fill in all required fields." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"ZenParent" message:@"Fill in all required fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
   
    }

}

- (IBAction)DonButtonPressedForPicker:(id)sender {
    
    // Catch the date User Selected and Sve it to the Sever
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    
    UITableViewCell* cell = [_mytable cellForRowAtIndexPath:indexPath];
    
   dateString = [NSDateFormatter localizedStringFromDate:userDate
                                                          dateStyle:NSDateFormatterMediumStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    NSLog(@"%@",dateString);

    cell.detailTextLabel.text = dateString;

    [_mytable reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    

    _PickerToolBar.hidden = YES;
    _DatePickerView.hidden = YES;

    
}

- (IBAction)cancelPressedForDatePicker:(id)sender {
   //Dismiss the Bouth Views
    
    _DatePickerView.hidden = YES;
    _PickerToolBar.hidden = YES;
    
}
-(void)LabelChange:(id)sender {
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *stringDate = [dateFormatter stringFromDate:_DatePickerView.date];

    userDate = _DatePickerView.date;
    NSLog(@"userDate Selected ===%@",stringDate);
    
    [[NSUserDefaults standardUserDefaults] setValue:stringDate forKey:@"DetailTextLabelDOB"];
    
    time_t unixTime = (time_t) [userDate timeIntervalSince1970];

    NSLog(@"TimeStamp :   %ld",unixTime * 1000);
    
    [[NSUserDefaults standardUserDefaults] setDouble: unixTime*1000 forKey:@"dob"];
    
    NSLog(@"Saving Value As :   %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dob"]);
   
    [[NSUserDefaults standardUserDefaults]synchronize];


}



@end
