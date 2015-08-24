//
//  SampleDetail.m
//  ZenParent
//
//  Created by Soumya Ranjan on 04/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "SampleDetail.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "SetingsView.h"
#import "VSDropdown.h"
#import "HOMEViewController.h"

@interface SampleDetail () <VSDropdownDelegate>


{
    VSDropdown *_dropdown;
    NSMutableDictionary *myArray;
    CGSize Hight;
    NSString *shareUrl;
    CDActivityIndicatorView * activityIndicatorView ;
    CGSize final;
}
@property (weak, nonatomic) IBOutlet UIButton *Prefarencebutton;


@property (weak, nonatomic) IBOutlet UIButton *LanguageButton;

@end

@implementation SampleDetail




- (void)viewDidLoad {
    
    
     self.screenName = @"Settings View";
    
    [super viewDidLoad];
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];

    
}

-(void)viewWillAppear:(BOOL)animated
{

    
    
    
}

-(void)updateButtonLayers
{

    [self.LanguageButton.layer setCornerRadius:3.0];
    [self.LanguageButton.layer setBorderWidth:1.0];
    [self.LanguageButton.layer setBorderColor:[self.LanguageButton.titleLabel.textColor CGColor]];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPrefrencePressed:(id)sender {
    
    
    SetingsView *wc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                        instantiateViewControllerWithIdentifier:@"SETT"];
    
    [self.navigationController pushViewController:wc1 animated:YES];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}


- (IBAction)testAction:(id)sender
{
    
    [self showDropDownForButton:sender adContents:@[@"Hindi",@"English"] multipleSelection:NO];

    
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{

    
    
    [_dropdown setDrodownAnimation:rand()%2];
    
    [_dropdown setAllowMultipleSelection:multipleSelection];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    
    if (_dropdown.allowMultipleSelection)
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:[sender.titleLabel.text componentsSeparatedByString:@";"]];
        
    }
    else
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:@[sender.titleLabel.text]];
        
        
    }

    
}

#pragma mark -
#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];
    
    if ([str isEqualToString:@"Hindi"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LanguageSettings"];

        NSLog(@"Hindi Selected........");
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Hindi" forKey:@"LanguageDefalt"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HOMEViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"HOMEIOS"];
        
        [self.navigationController pushViewController:ivc animated:YES];


    }else  {
    
     NSLog(@"English Selected........");
         [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LanguageSettings"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HOMEViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"HOMEIOS"];
        
        [self.navigationController pushViewController:ivc animated:YES];

    }
    
    
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    UIButton *btn = (UIButton *)dropdown.dropDownView;
    
    return btn.titleLabel.textColor;
    
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}



/*
 
 How to use Bool Value
 
 if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
 [self displayLogin];
 } else {
 [self displayMainScreen];
 }
 
 */

@end
