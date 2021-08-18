//
//  InstructionViewController.m
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLeft addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRight addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    self.currentPage = 0;
    [self setData];
}

-(void) clickBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) clickLeft
{
    self.currentPage--;
    [self setData];
}
-(void) clickRight
{
    self.currentPage++;
    [self setData];
}

-(void) setData
{
    if (self.currentPage == 0)
    {
        self.btnLeft.hidden = YES;
        [self.imgScreenshot setImage:[UIImage imageNamed:@"one.png"]];
        self.lblDescription.text = @"Choose the number of cards Fewer cards make the game easier.";
    }
    else if (self.currentPage == 4)
    {
        self.btnRight.hidden = YES;
        [self.imgScreenshot setImage:[UIImage imageNamed:@"five.png"]];
        self.lblDescription.text = @"If an incorrect location is selected, you will need to pick again.";
    }
    else
    {
        self.btnRight.hidden = NO;
        self.btnLeft.hidden = NO;
        
        if (self.currentPage == 1)
        {
            [self.imgScreenshot setImage:[UIImage imageNamed:@"two.png"]];
            self.lblDescription.text = @"Click on a matching set of angles and a category.";
        }
        else if (self.currentPage == 2)
        {
            [self.imgScreenshot setImage:[UIImage imageNamed:@"three.png"]];
            self.lblDescription.text = @"If the set does not match, you will need to pick again.";
        }
        else if (self.currentPage == 3)
        {
            [self.imgScreenshot setImage:[UIImage imageNamed:@"four.png"]];
            self.lblDescription.text = @"If the set does match, you will pick the location on the circle where it should go.";
        }
    }
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
