//
//  CompletedViewController.m
//  Angle Connection
//
//  Created by my on 2020/7/1.
//  Copyright © 2020 my. All rights reserved.
//

#import "CompletedViewController.h"
#import "Globals.h"
#import "CaseCell.h"

@interface CompletedViewController ()

@end

@implementation CompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.tblCase.delegate = self;
    self.tblCase.dataSource = self;
    
    [self.tblCase registerNib:[UINib nibWithNibName:@"CaseCell" bundle:nil] forCellReuseIdentifier:@"CaseCell"];
    [self.tblCase reloadData];
    
}

-(void) clickBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    for (int i = 0; i < g_lstComplete.count;i++)
    {
        NSDictionary *data = [g_lstComplete objectAtIndex:i];
        if ([data[@"op"] longLongValue] == section + 9)
        {
            count++;
        }
    }
    return count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Linear pairs";
    }
    else if (section == 1)
    {
        return @"Same-side interior";
    }
    else if (section == 2)
    {
        return @"Vertical";
    }
    else if (section == 3)
    {
        return @"Alternate Interior";
    }
    else if (section == 4)
    {
        return @"Alternate Exterior";
    }
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count = 0;
    CaseCell *cell = (CaseCell *)[theTableView dequeueReusableCellWithIdentifier:@"CaseCell"];
    for (int i = 0; i < g_lstComplete.count;i++)
    {
        NSDictionary *data = [g_lstComplete objectAtIndex:i];
        if ([data[@"op"] longLongValue] == indexPath.section + 9)
        {
            if (count == indexPath.row)
            {
                cell.lblContent.text = [NSString stringWithFormat:@"%@ and %@",data[@"left"],data[@"right"]];
                break;
            }
            count++;
        }
    }
    
    return cell;
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
