//
//  MenuViewController.m
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import "MenuViewController.h"
#import "SelectCardViewController.h"
#import "InstructionViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnPlay addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.btnHighscore addTarget:self action:@selector(clickHighscore) forControlEvents:UIControlEventTouchUpInside];
    [self.btnInstruction addTarget:self action:@selector(clickInstruction) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickPlay
{
    SelectCardViewController *selVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SelectCardViewController"];
    [self presentViewController:selVc animated:YES completion:nil];
}

-(void) clickHighscore
{
    
}

-(void) clickInstruction
{
    InstructionViewController *instVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"InstructionViewController"];
    [self presentViewController:instVc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
