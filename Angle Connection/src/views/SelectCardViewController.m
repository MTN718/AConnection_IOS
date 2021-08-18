//
//  SelectCardViewController.m
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import "SelectCardViewController.h"
#import "GameViewController.h"
#import "Utils.h"
#import "Globals.h"

@interface SelectCardViewController ()

@end

@implementation SelectCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPlay addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnCard5 addTarget:self action:@selector(clickCard5) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCard6 addTarget:self action:@selector(clickCard6) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCard7 addTarget:self action:@selector(clickCard7) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCard8 addTarget:self action:@selector(clickCard8) forControlEvents:UIControlEventTouchUpInside];
    g_cardNo = 5;
    [self setCard];
}

-(void) setCard
{
    self.btnCard5.backgroundColor = [Utils colorWithHexString:@"d6d6d6"];
    self.btnCard6.backgroundColor = [Utils colorWithHexString:@"d6d6d6"];
    self.btnCard7.backgroundColor = [Utils colorWithHexString:@"d6d6d6"];
    self.btnCard8.backgroundColor = [Utils colorWithHexString:@"d6d6d6"];
    
    if (self.currentCard == 0)
    {
        self.btnCard5.backgroundColor = [Utils colorWithHexString:@"c0c0c0"];
    }
    else if (self.currentCard == 1)
    {
        self.btnCard6.backgroundColor = [Utils colorWithHexString:@"c0c0c0"];
    }
    else if (self.currentCard == 2)
    {
        self.btnCard7.backgroundColor = [Utils colorWithHexString:@"c0c0c0"];
    }
    else if (self.currentCard == 3)
    {
        self.btnCard8.backgroundColor = [Utils colorWithHexString:@"c0c0c0"];
    }
}

-(void) clickCard5
{
    self.currentCard = 0;
    g_cardNo = 5;
    [self setCard];
}

-(void) clickCard6
{
    self.currentCard = 1;
    g_cardNo = 6;
    [self setCard];
}

-(void) clickCard7
{
    self.currentCard = 2;
    g_cardNo = 7;
    [self setCard];
}

-(void) clickCard8
{
    self.currentCard = 3;
    g_cardNo = 8;
    [self setCard];
}

-(void) clickPlay
{
    GameViewController *selVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GameViewController"];
    [self presentViewController:selVc animated:YES completion:nil];
}

-(void) clickBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
