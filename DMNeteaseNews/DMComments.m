//
//  DMComments.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-3-2.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMComments.h"

@interface DMComments ()

@end

@implementation DMComments

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       //tableView
    self.ymTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 380)];
    [self.view addSubview:self.ymTableView ];
    [self.ymTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];

    [self.ymTableView setDataSource:self];
    [self.ymTableView setDelegate:self];
    
    
    //设置控件
    [self gmSetControlSubView];
    
    //注册一个通知，请求评论列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gmCommentList:) name:@"gmCommentList" object:nil];
  
    //再注册一个通知，实时刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gmRefreshData) name:@"gmRefreshData" object:nil];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置控件
-(void)gmSetControlSubView{
    //视图头部 设置
    if(!self.ymCommentsTitleUpV){
        self.ymCommentsTitleUpV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.ymCommentsTitleUpV setAlpha:0.8];
        [self.view addSubview:self.ymCommentsTitleUpV];
    }
    UIView *tempBackV = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 280, 40)];
    [tempBackV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"displayNewsBackground210*65.jpg"]]];
    [self.ymCommentsTitleUpV addSubview:tempBackV];
    
        
    //左上方Button
    UIButton *tempUpLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:tempUpLeft];
    [tempUpLeft setBackgroundImage:[UIImage imageNamed:@"displayNews1.jpg"] forState:UIControlStateNormal];
    [tempUpLeft addTarget:self action:@selector(gmUpLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tempUpLeft setAlpha:0.8];
    
    
    //下方，写跟帖
    self.ymDownV = [[UIView alloc] initWithFrame:CGRectMake(0, 420, 320, 40)];
    self.ymDownImgComments = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"displayNewsDown1.jpg"]];
    [self.ymDownImgComments setFrame:CGRectMake(0, 0, 320, 40)];
    [self.ymDownV addSubview:self.ymDownImgComments];
    
    [self.view addSubview:self.ymDownV];
    
    //在下方Button上面放一个UITextfield
    self.ymTxtDownUpBut = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 240, 28)];
    [self.ymTxtDownUpBut addTarget:self action:@selector(gmTxtDownActionEditingStart) forControlEvents:UIControlEventEditingDidBegin];
    [self.ymTxtDownUpBut addTarget:self action:@selector(gmTxtDownActionEditingEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self.ymTxtDownUpBut setTextColor:[UIColor grayColor]];
    //设置键盘模式
    [self.ymTxtDownUpBut setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self.ymDownV addSubview:self.ymTxtDownUpBut];
    
    //UITextFiled右侧有一个Button
    UIButton *butDownRight = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
    
    [butDownRight addTarget:self action:@selector(gmButtonDownRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ymDownV addSubview:butDownRight];
}

//左上角关联事件
-(void)gmUpLeftButtonAction{
    
    [self.view removeFromSuperview];
    
}
//右上方Button
-(void)gmUpRightButtonAction:(id)sender{
    UIButton *tempButRightUp = (UIButton *)sender;
    //弹出子View
    [self gmSetSubView];
    if(tempButRightUp.isSelected){
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymSubViewUp setFrame:CGRectMake(200, 40, 115, 120)];
        } completion:^(BOOL finished){}];
        
        
        tempButRightUp.selected = NO;
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymSubViewUp setFrame:CGRectMake(200, 40, 115, 0)];
        } completion:^(BOOL finished){}];
        
        tempButRightUp.selected = YES;
    }
    
}
//弹出子View设置
-(void)gmSetSubView{
    //弹出子View
    if(!self.ymSubViewUp){
        self.ymSubViewUp = [[UIScrollView alloc] initWithFrame:CGRectMake(200, 40, 115, 0)];
        [self.ymSubViewUp setBackgroundColor:[UIColor grayColor]];
        [self.ymSubViewUp setAlpha:0.8];
        [self.ymSubViewUp setBounces:NO];
        [self.view addSubview:self.ymSubViewUp];
    }
    for(int i = 0;i < 3;i ++){
        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(0, i*40, 115, 39)];
        [tempBut setImage:[UIImage imageNamed:[NSString stringWithFormat:@"BasicSubView%d.jpg",i+1]] forState:UIControlStateNormal ];
        tempBut.tag = 600 +i;
        [tempBut addTarget:self action:@selector(gmSubViewButAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [tempBut setAlpha:0.8];
        [self.ymSubViewUp addSubview:tempBut];
        
    }
    
}

//在下方Button上面放一个UITextfield,编辑开始事件
-(void)gmTxtDownActionEditingStart{
    [self.ymDownImgComments setImage:[UIImage imageNamed:@"displayNewsDown4.jpg"]];
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymDownV setFrame:CGRectMake(0, 420-212, 320, 40)];
        
    } completion:^(BOOL finished){
        
    }];
}
//编辑结束事件
-(void)gmTxtDownActionEditingEnd{
    [UIView animateWithDuration:0.15 animations:^{
        [self.ymDownV setFrame:CGRectMake(0, 420, 320, 40)];
        
    } completion:^(BOOL finished){
        
    }];
    
}
//UITextFiled右侧有一个Button
-(void)gmButtonDownRightAction{
    //判断是否登录
    if(![[DMJSONParse gmPassValue:@""] isEqualToString:@""]){
        if([self.ymTxtDownUpBut.text length] != 0){
            
            [self gmTxtDownActionEditingEnd];
            [self.view endEditing:YES];
            
            [self.ymDownImgComments setImage:[UIImage imageNamed:@"displayNewsDown1.jpg"]];
            
            //发表评论,附上新闻ID，和跟帖内容
            NSString *strAO = [DMAppearObserve gmFromAppearObserveToJSONContentid:[NSString stringWithFormat:@"%d", self.ymContentid] andContent:self.ymTxtDownUpBut.text];
            NSString *strJudge = [strAO substringWithRange:NSMakeRange(12, 5)];
            
            //若评论成功，操作
            if([strJudge intValue] == 10000){
                UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发表评论成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
                [alertSuccess show];
            }else{
            //评论失败
                UIAlertView *alertFaild = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发表评论失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
               
                [alertFaild show];
            }
            
            
            self.ymTxtDownUpBut.text = nil;
            
        }

    }else{
    //未登录时
        UIAlertView *alertFaild = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请登录您的账号" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"返回", nil];
        alertFaild.tag = 3501;
        [alertFaild show];

    }
    
    
    
}
//子ViewButton点击后关联事件
-(void)gmSubViewButAction:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
    
    //分享
    if(tempBut.tag == 600){
        
        
        //收藏
    }else if (tempBut.tag == 601){
        
        
        //字体大小
    }else if(tempBut.tag == 602){
        
    }
    
}


//TAbleView刷新数据
-(void)gmRefreshData{
    //获取当前新闻的评论列表
    [self gmCommentList:nil];
    
    [self.ymTableView reloadData];

}

//获取当前新闻的评论列表
-(void)gmCommentList:(id)sender{
    NSString *strComment = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetDiscussRecordListByContentid?contentid=%d",self.ymContentid];

    NSURL *urlComment = [NSURL URLWithString:strComment];
    //获取跟帖数据
    self.ymCellData = nil;
    self.ymCellData = [DMJSONParse gmJSONCommentList:urlComment];

}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [self.ymCellData count]+1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DMCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[DMCommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //数据准备
    if(indexPath.row == 0){
        [cell gmHotComments];
    }
    else {
        if(![self.ymCellData count]){

        }else{
            
        DMCommentModel *tempModel = [self.ymCellData objectAtIndex:indexPath.row-1];
        NSString *strTime = [tempModel.ymPublished substringWithRange:NSMakeRange([tempModel.ymPublished length]-8,5)];
        [cell gmCommentsCellPhoto:nil andNetName:tempModel.ymNickName andStfId:[NSString stringWithFormat:@"%d",tempModel.ymStfId] andTime:strTime andContent:tempModel.ymContent];
        }
    }
    return cell;
    
}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0){
    //点击后就收藏
     self.ymTempCommentModel = [self.ymCellData objectAtIndex:indexPath.row-1];

    //弹出UIAlertView提示收藏
    UIAlertView *tempAlertV = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"收藏" otherButtonTitles:@"返回", nil];
        tempAlertV.tag = 3500;
        
    [tempAlertV show];
    }
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        if(![self.ymCellData count]){
            return 400;
        }else{
        return 21;
        }
    }else{
        if([self.ymCellData count]<2){
            return 0;
        }else{
        NSString *strContent = [[self.ymCellData objectAtIndex:indexPath.row-1] ymContent];
        float cellHeight = [self gmFromStringReturnHeight:strContent];
        return cellHeight;
        }
    }
}
//传入一段字符串 返回高度
-(float)gmFromStringReturnHeight:(NSString *)str {
    //具体新闻内容
    
    if(![str isEqualToString:@""]){
        UILabel *descriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
        [descriptionlab setNumberOfLines:0];
        [descriptionlab setText:str];
        [descriptionlab setTextColor:[UIColor whiteColor]];
        UIFont *fontTwo = [UIFont systemFontOfSize:12];
        descriptionlab.font = fontTwo;
        descriptionlab.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *dictTwo = [NSDictionary dictionaryWithObjectsAndKeys:fontTwo,NSFontAttributeName, nil];
        CGSize sizeTwo = [descriptionlab.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTwo context:nil].size;
        
        return sizeTwo.height +35;
    }else{
    
        return 50;
    }

}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 0){
       
        if(alertView.tag == 3500){
            //点击收藏Button就执行收藏操作
            [DMCollectionSave gmSharedComment: self.ymTempCommentModel];
        }
        if(alertView.tag == 3501){
            //跳转到登录页面
            self.ymEnterLand = nil;
            if(!self.ymEnterLand){
                self.ymEnterLand = [[DMEnterLand alloc] init];
                [self.ymEnterLand.view setFrame:CGRectMake(320, 0, 320, 460)];
                
                [self.view addSubview:self.ymEnterLand.view];
            }
            
          
            [UIView animateWithDuration:0.2 animations:^{
                [self.ymEnterLand.view setFrame:CGRectMake(0, 0, 320, 460)];
            } completion:^(BOOL finished){
            }];
        }
    }


}


@end
