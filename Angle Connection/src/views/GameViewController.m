//
//  GameViewController.m
//  Angle Connection
//
//  Created by my on 2020/6/30.
//  Copyright © 2020 my. All rights reserved.
//

#import "GameViewController.h"
#import "CompletedViewController.h"
#import "Globals.h"
#import "Utils.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(void) viewDidLayoutSubviews
{
    [self initGame];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameCase = [[NSMutableArray alloc] init];
    self.gameCurrent = [[NSMutableArray alloc] init];
    self.gameButtons = [[NSMutableArray alloc] init];
    self.gameSelections = [[NSMutableArray alloc] init];
    g_lstComplete = [[NSMutableArray alloc] init];
    
    self.gameCase = @[
        @{@"left" : @"1",   @"right" : @"2",    @"op":@"9", @"id":@"1"},
        @{@"left" : @"3",   @"right" : @"4",    @"op":@"9", @"id":@"2"},
        @{@"left" : @"5",   @"right" : @"6",    @"op":@"9", @"id":@"3"},
        @{@"left" : @"7",   @"right" : @"8",    @"op":@"9", @"id":@"4"},
        @{@"left" : @"1",   @"right" : @"3",    @"op":@"9", @"id":@"5"},
        @{@"left" : @"2",   @"right" : @"4",    @"op":@"9", @"id":@"6"},
        @{@"left" : @"5",   @"right" : @"7",    @"op":@"9", @"id":@"7"},
        @{@"left" : @"6",   @"right" : @"8",    @"op":@"9", @"id":@"8"},
        @{@"left" : @"1",   @"right" : @"8",    @"op":@"13", @"id":@"9"},
        @{@"left" : @"2",   @"right" : @"7",    @"op":@"13", @"id":@"10"},
        @{@"left" : @"3",   @"right" : @"6",    @"op":@"12", @"id":@"11"},
        @{@"left" : @"4",   @"right" : @"5",    @"op":@"12", @"id":@"12"},
        @{@"left" : @"3",   @"right" : @"5",    @"op":@"10", @"id":@"13"},
        @{@"left" : @"4",   @"right" : @"6",    @"op":@"10", @"id":@"14"},
        @{@"left" : @"1",   @"right" : @"4",    @"op":@"11", @"id":@"15"},
        @{@"left" : @"2",   @"right" : @"3",    @"op":@"11", @"id":@"16"},
        @{@"left" : @"5",   @"right" : @"8",    @"op":@"11", @"id":@"17"},
        @{@"left" : @"6",   @"right" : @"7",    @"op":@"11", @"id":@"18"}
    ];
    
    
    //self.csMain.constant = self.vwMain.frame.size.width;
    
    [self.btnRefresh addTarget:self action:@selector(refreshGame) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCompleted addTarget:self action:@selector(clickComplete) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGraph = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGraph:)];
    tapGraph.delegate=self;
    [self calculateCenter];
    [self.vwMain addGestureRecognizer:tapGraph];
    self.isClicklock = false;
    
}

-(void) clickComplete
{
    CompletedViewController *selVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CompletedViewController"];
    [self presentViewController:selVc animated:YES completion:nil];
}

-(void) calculateCenter
{
    float rate = self.vwMain.frame.size.width / 512.0f;
    self.centerX1 = 293 * rate;
    self.centerY1 = 191 * rate;
    self.centerX2 = 217 * rate;
    self.centerY2 = 286 * rate;
    self.radius = 38 * rate;
}
-(void) refreshGame
{
    [self clearButtons];
    [self checkGame];
    self.isClicklock = false;
    [self.imgAngle setImage:[UIImage imageNamed:@"angle_reset.png"]];
    [self initGame];
}

-(NSString*) getOperandName:(NSString*) op
{
    if ([op longLongValue] == 9)
    {
        return @"Linear pairs";
    }
    else if ([op longLongValue] == 10)
    {
        return @"Same-side interior";
    }
    else if ([op longLongValue] == 11)
    {
        return @"Vertical";
    }
    else if ([op longLongValue] == 12)
    {
        return @"Alternate Interior";
    }
    else if ([op longLongValue] == 13)
    {
        return @"Alternate Exterior";
    }
    return op;
}

-(void) clickBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void) relocateButtons
{
    float vWidth = self.vwButtons.bounds.size.width;
    float vHeight = self.vwButtons.bounds.size.height;
    
    NSLog(@"%f,%f",vWidth,vHeight);
    
    
    int lineCountMax = self.gameCurrent.count / 2;
    if (self.gameCurrent.count % 2 > 0)
    {
        lineCountMax++;
    }
    for (int i = 0;i < g_cardNo;i++)
    {
        int j = 0;
        for (j = 0; j < self.gameCurrent.count;j++)
        {
            if ([self.gameCurrent[j][@"position"] longLongValue] == (i + 1))
            {
                break;
            }
        }
        float bWidth = 0;
        float bHeight = (vHeight - 8 * 3) / 2;;
        if (i < lineCountMax || self.gameCurrent.count % 2 == 0)
        {
            bWidth = (vWidth - 8 * (lineCountMax + 1)) / (float)lineCountMax;
        }
        else
        {
            bWidth = (vWidth - 8 * (lineCountMax)) / (float)(lineCountMax - 1);
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.numberOfLines = 0; // Dynamic number of lines
        button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [button.titleLabel setTextAlignment:UITextAlignmentCenter];
        [button setBackgroundColor:[Utils colorWithHexString:@"e0e0e0"]];
        [button setTitleColor:[Utils colorWithHexString:@"000000"] forState:UIControlStateNormal];
        
        [button setTitle:self.gameCurrent[j][@"data"] forState:UIControlStateNormal];
        
        if (i < lineCountMax)
        {
            button.frame = CGRectMake(8 * (i + 1) + bWidth * i, 8, bWidth, bHeight);
        }
        else
        {
            button.frame = CGRectMake(8 * (i - lineCountMax + 1) + bWidth * (i - lineCountMax), 16 + bHeight, bWidth, bHeight);
        }
        button.tag = j;
        
        [button addTarget:self
                  action:@selector(clickButton:)
        forControlEvents:UIControlEventTouchUpInside];
        
        //self.gameCurrent[j][@"button"] = button;
//        NSDictionary *bData = @{@"position":[NSString stringWithFormat:@"%i",j],@"button":button};
        [self.gameButtons addObject:button];
        //self.gameCurrent[j] add
        [self.vwButtons addSubview:button];
    }
}
    
-(void) clickButton:(id) sender
{
    if (self.isClicklock) return;
    int index = ((UIButton *) sender).tag;
    UIButton *btn = (UIButton *) sender;
    for (int j = 0;j < self.gameButtons.count;j++)
    {
        if ([[self.gameButtons objectAtIndex:j] isEqual:btn])
        {
            [[self.gameButtons objectAtIndex:j] setSelected:!btn.isSelected];
        }
    }
    [self checkGame];
}

-(void) addAngleSelection:(int) index
{
    UIImageView *iv = [[UIImageView alloc] init];
    switch (index) {
        case 1:
            iv.frame = CGRectMake(self.centerX1 - self.radius, self.centerY1 - self.radius, self.radius + self.radius * sin(45 * M_PI / 180), self.radius);
            [iv setImage:[UIImage imageNamed:@"angle1.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 2:
            iv.frame = CGRectMake(self.centerX1 + 3, self.centerY1 - self.radius * sin(45 * M_PI / 180), self.radius, self.radius * sin(45 * M_PI / 180));
            [iv setImage:[UIImage imageNamed:@"angle2.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 3:
            iv.frame = CGRectMake(self.centerX1 - self.radius, self.centerY1 + 3, self.radius, self.radius * sin(45 * M_PI / 180));
            [iv setImage:[UIImage imageNamed:@"angle3.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 4:
            iv.frame = CGRectMake(self.centerX1 + 3 - self.radius * sin(45 * M_PI / 180), self.centerY1 + 3, self.radius + self.radius * sin(45 * M_PI / 180), self.radius);
            [iv setImage:[UIImage imageNamed:@"angle4.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 5:
            iv.frame = CGRectMake(self.centerX2 - self.radius, self.centerY2 - self.radius, self.radius + self.radius * sin(45 * M_PI / 180), self.radius);
            [iv setImage:[UIImage imageNamed:@"angle1.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 6:
            iv.frame = CGRectMake(self.centerX2 + 3, self.centerY2 - self.radius * sin(45 * M_PI / 180), self.radius, self.radius * sin(45 * M_PI / 180));
            [iv setImage:[UIImage imageNamed:@"angle2.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 7:
            iv.frame = CGRectMake(self.centerX2 - self.radius, self.centerY2 + 3, self.radius, self.radius * sin(45 * M_PI / 180));
            [iv setImage:[UIImage imageNamed:@"angle3.png"]];
            [self.vwMain addSubview:iv];
            break;
        case 8:
            iv.frame = CGRectMake(self.centerX2 + 3 - self.radius * sin(45 * M_PI / 180), self.centerY2 + 3, self.radius + self.radius * sin(45 * M_PI / 180), self.radius);
            [iv setImage:[UIImage imageNamed:@"angle4.png"]];
            [self.vwMain addSubview:iv];
            break;
    }
    iv.tag = index;
    [self.gameSelections addObject:iv];
    if (self.gameSelections.count == 2)
    {
        if ([self selectCheck])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Set is Correctly Placed." preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    g_moveCount++;
                    [g_lstComplete addObject:self.gameMatchcase];
                    [self updateMove];
                    [self refreshGame];
                }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Try again" message:@"That is an incorrect place for the set." preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    g_moveCount++;
                    [self updateMove];
                    [self refreshGame];
                }];
            UIAlertAction *again = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                
            }];
            [alert addAction:cancel];
            [alert addAction:again];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        for (int i = 0;i < self.gameSelections.count;i++)
        {
            UIImageView *iv = [self.gameSelections objectAtIndex:i];
            [iv removeFromSuperview];
        }
        [self.gameSelections removeAllObjects];
        
    }
}

-(void) clickGraph:(UIGestureRecognizer *) gesture
{
    if (!self.isClicklock) return;
    CGPoint point = [gesture locationInView:gesture.view];
    NSLog(@"Point - %f, %f", point.x, point.y);
    float distance = sqrt(pow((point.x - self.centerX1),2) + pow((point.y - self.centerY1),2));
    if (distance < self.radius)
    {
        float angle = atan(fabs(point.y - self.centerY1) / fabs(point.x - self.centerX1));
        if (point.x > self.centerX1 - self.radius && point.x < self.centerX1 && point.y < self.centerY1 && point.y > self.centerY1 - self.radius)
        {
            NSLog(@"Angle1");
            [self addAngleSelection:1];
        }
        
        if (point.x > self.centerX1 && point.x < self.centerX1 + self.radius && point.y < self.centerY1 && point.y > self.centerY1 - self.radius)
        {
            if (angle > 45)
            {
                NSLog(@"Angle1");
                [self addAngleSelection:1];
            }
            else
            {
                NSLog(@"Angle2");
                [self addAngleSelection:2];
            }
        }
        
        if (point.x > self.centerX1 - self.radius && point.x < self.centerX1 && point.y < self.centerY1 + self.radius && point.y > self.centerY1)
        {
            if (angle < 45)
            {
                NSLog(@"Angle3");
                [self addAngleSelection:3];
            }
            else
            {
                NSLog(@"Angle4");
                [self addAngleSelection:4];
            }
        }
        
        if (point.x > self.centerX1 && point.x < self.centerX1 + self.radius && point.y < self.centerY1 + self.radius && point.y > self.centerY1)
        {
            NSLog(@"Angle4");
            [self addAngleSelection:4];
        }
        //if (angle)
    }
    
    distance = sqrt(pow((point.x - self.centerX2),2) + pow((point.y - self.centerY2),2));
    NSLog(@"Distance - %f", distance);
    
    if (distance < self.radius)
    {
        float angle = atan(fabs(point.y - self.centerY2) / fabs(point.x - self.centerX2));
        NSLog(@"Angle - %f", angle  * 180 / M_PI);
        if (point.x > self.centerX2 - self.radius && point.x < self.centerX2 && point.y < self.centerY2 && point.y > self.centerY2 - self.radius)
        {
            NSLog(@"Angle5");
            [self addAngleSelection:5];
        }
        
        if (point.x > self.centerX2 && point.x < self.centerX2 + self.radius && point.y < self.centerY2 && point.y > self.centerY2 - self.radius)
        {
            if (angle > 45)
            {
                NSLog(@"Angle5");
                [self addAngleSelection:5];
            }
            else
            {
                NSLog(@"Angle6");
                [self addAngleSelection:6];
            }
        }
        
        if (point.x > self.centerX2 - self.radius && point.x < self.centerX2 && point.y < self.centerY2 + self.radius && point.y > self.centerY2)
        {
            if (angle < 45)
            {
                NSLog(@"Angle7");
                [self addAngleSelection:7];
            }
            else
            {
                NSLog(@"Angle8");
                [self addAngleSelection:8];
            }
        }
        
        if (point.x > self.centerX2 && point.x < self.centerX2 + self.radius && point.y < self.centerY2 + self.radius && point.y > self.centerY2)
        {
            NSLog(@"Angle8");
            [self addAngleSelection:8];
        }
    }
}

-(bool) selectCheck
{
    for (int i = 0; i < self.gameSelections.count;i++)
    {
        UIImageView *iv = [self.gameSelections objectAtIndex:i];
        if ([self.gameMatchcase[@"left"] longLongValue] != iv.tag &&
            [self.gameMatchcase[@"right"] longLongValue] != iv.tag)
        {
            return false;
        }
    }
    return true;
}

-(void) checkGame
{
    int count = 0;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int j = 0;j < self.gameButtons.count;j++)
    {
        if ([[self.gameButtons objectAtIndex:j] isSelected])
        {
            [[self.gameButtons objectAtIndex:j] setBackgroundColor:[Utils colorWithHexString:@"adcceb"]];
            NSString *string = [[self.gameButtons objectAtIndex:j] titleLabel].text;
            [result addObject:string];
            count++;
        }
        else
        {
            [[self.gameButtons objectAtIndex:j] setBackgroundColor:[Utils colorWithHexString:@"e0e0e0"]];
        }
    }
    if (count == 3)
    {
        //Checking Result
        if ([self checkResult:result])
        {
            NSLog(@"Good");
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"That's a set" message:@"Now touch respective circle to make a set." preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    self.isClicklock = true;
                    self.selectCount = 0;
                    [self.gameSelections removeAllObjects];
                    [self.imgAngle setImage:[UIImage imageNamed:@"angle_show.png"]];
                }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Try again" message:@"Those 3 cards do not form a set." preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    //button click event
                    [self clearButtons];
                    [self checkGame];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
    }
}

-(void) clearButtons
{
    for (int j = 0;j < self.gameButtons.count;j++)
    {
        [[self.gameButtons objectAtIndex:j] setSelected:false];
    }
    
}

-(bool) checkResult :(NSMutableArray *) result
{
    for (int k = 0;k < self.gameCase.count;k++)
    {
        NSDictionary *gCase = [self.gameCase objectAtIndex:k];
    
        int left = [gCase[@"left"] longLongValue];
        int right = [gCase[@"right"] longLongValue];
        NSString *op = [self getOperandName:gCase[@"op"]];
        
        
        if ((left == [[result objectAtIndex:0] longLongValue] && right == [[result objectAtIndex:1] longLongValue] && [op isEqualToString:[result objectAtIndex:2]])
            ||
            (left == [[result objectAtIndex:0] longLongValue] && right == [[result objectAtIndex:2] longLongValue] && [op isEqualToString:[result objectAtIndex:1]])
            ||
            (right == [[result objectAtIndex:0] longLongValue] && left == [[result objectAtIndex:1] longLongValue] && [op isEqualToString:[result objectAtIndex:2]])
            ||
            (right == [[result objectAtIndex:0] longLongValue] && left == [[result objectAtIndex:2] longLongValue] && [op isEqualToString:[result objectAtIndex:1]])
            ||
            (left == [[result objectAtIndex:1] longLongValue] && right == [[result objectAtIndex:2] longLongValue] && [op isEqualToString:[result objectAtIndex:0]])
            ||
            (left == [[result objectAtIndex:2] longLongValue] && right == [[result objectAtIndex:1] longLongValue] && [op isEqualToString:[result objectAtIndex:0]]))
        {
            bool isDuplicate = false;
            for (int k = 0;k < g_lstComplete.count;k++)
            {
                if ([g_lstComplete objectAtIndex:k][@"id"] == gCase[@"id"])
                {
                    isDuplicate = true;
                }
            }
            if (!isDuplicate)
            {
                self.gameMatchcase = gCase;
                return true;
            }
            else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Already Set" message:@"You Already set that pair." preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self clearButtons];
                        [self checkGame];
                        
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
    return false;
}

-(void) updateMove
{
    self.lblMoves.text = [NSString stringWithFormat:@"Moves: %i",g_moveCount];
}
-(NSString*) getEmptyPosition
{
    bool isEqual = true;
    int position = 0;
    while(isEqual)
    {
        position = (arc4random() % g_cardNo) + 1;
        isEqual = false;
        for (int i = 0;i < self.gameCurrent.count;i++)
        {
            NSDictionary *dt = [self.gameCurrent objectAtIndex:i];
            if ([dt[@"position"] longLongValue] == position)
            {
                isEqual = true;
            }
        }
    }
    
    return [NSString stringWithFormat:@"%i",position];
}


-(int) pickUnusedCase
{
    //Pick Case
    bool isEqual = true;
    int position = 0;
    if (g_lstComplete.count == 18) return -1;
    while(isEqual)
    {
        position = (arc4random() % 18) + 1;
        isEqual = false;
        for (int i = 0;i < g_lstComplete.count;i++)
        {
            NSDictionary *dt = [g_lstComplete objectAtIndex:i];
            if ([dt[@"id"] longLongValue] == position)
            {
                isEqual = true;
            }
        }
    }
    return position - 1;
}

-(int) pickNonDuplicate
{
    //Pick Case
    bool isEqual = true;
    int value = 0;
    while(isEqual)
    {
        value = (arc4random() % 13) + 1;
        isEqual = false;
        for (int i = 0;i < self.gameCurrent.count;i++)
        {
            NSDictionary *dt = [self.gameCurrent objectAtIndex:i];
            NSString *op = [self getOperandName:[NSString stringWithFormat:@"%i",value]];
            if ([dt[@"data"] isEqualToString:op])
            {
                isEqual = true;
            }
        }
    }
    return value;
}

-(void) initGame
{
    //Pick Case
    int cIndex = [self pickUnusedCase];
    if (cIndex == -1)
    {
        NSString *str = [NSString stringWithFormat:@"All sets have been placed Your score: %i",g_moveCount];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:str preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
            [self clickBack];
            }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSDictionary *data = [self.gameCase objectAtIndex:cIndex];
    
    [self.gameCurrent removeAllObjects];
    
    NSString* pos = [self getEmptyPosition];
    NSDictionary *gameItem = @{@"position":pos,@"data": data[@"left"],@"isCheck" :@"0"};
    [self.gameCurrent addObject:gameItem];
    
    pos = [self getEmptyPosition];
    gameItem = @{@"position":pos,@"data": data[@"right"],@"isCheck" :@"0"};
    [self.gameCurrent addObject:gameItem];
    
    pos = [self getEmptyPosition];
    gameItem = @{@"position":pos,@"data": [self getOperandName:data[@"op"]],@"isCheck" :@"0"};
    [self.gameCurrent addObject:gameItem];
    
    //Pick Operand
    for (int i = 0;i < g_cardNo - 3;i++)
    {
        int value = [self pickNonDuplicate];
        pos = [self getEmptyPosition];
        
        gameItem = @{@"position":pos,@"data": [self getOperandName:[NSString stringWithFormat:@"%i",value]],@"isCheck" :@"0"};
        [self.gameCurrent addObject:gameItem];
    }
    NSLog(@"%@",self.gameCurrent);
    [self relocateButtons];
    
    
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
