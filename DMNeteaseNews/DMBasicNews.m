//
//  DMBasicNews.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMBasicNews.h"

@interface DMBasicNews ()

@end

@implementation DMBasicNews

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //scrollView
    self.ymScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:self.ymScrollV ];
    [self.ymScrollV  setBackgroundColor:[UIColor blackColor]];
    [self.ymScrollV setAlpha:0.7];
    [self.ymScrollV  setBounces:NO];
    [self.ymScrollV  setContentSize:CGSizeMake(320, 1500)];

    //设置控件
    [self gmSetControlSubView];
    
    //设置显示模式
    [self gmDisplayBasicModel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置Model传回数据使用UILabel显示
-(void)gmDisplayBasicModel{
//    //新闻标题
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
    [labTitle setNumberOfLines:0];
    [labTitle setText:self.ymBasicModel.ymTitle];
    [labTitle setTextColor:[UIColor whiteColor]];
    UIFont *font = [UIFont systemFontOfSize:18];
    labTitle.font = font;
    labTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    //获取当前文本属性
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    //文本需要的Size限制宽度
    CGSize sizeZero = [labTitle.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    [labTitle setFrame:CGRectMake(10, 45, sizeZero.width, sizeZero.height)];
    [self.ymScrollV addSubview:labTitle];
    
    //新闻来源+时间
     UILabel *labSource = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300,60)];
    [labSource setNumberOfLines:0];
    
    
    
    NSString *strTimeOne = [self.ymBasicModel.ymPublished substringToIndex:10];
    NSString *strTimeTwo = [self.ymBasicModel.ymPublished substringFromIndex:[self.ymBasicModel.ymPublished length]-8];
    NSString *strSource = [NSString stringWithFormat:@"来源：%@ %@ %@",self.ymBasicModel.ymSource,strTimeOne,strTimeTwo];
    [labSource setText:strSource];
    
    [labSource setTextColor:[UIColor whiteColor]];
    UIFont *fontOne = [UIFont systemFontOfSize:10];
    labSource.font = fontOne;
    labSource.lineBreakMode = NSLineBreakByTruncatingTail;
    //获取当前文本属性
    NSDictionary *dictOne = [NSDictionary dictionaryWithObjectsAndKeys:fontOne,NSFontAttributeName, nil];
    //文本需要的Size限制宽度
    CGSize sizeOne = [labSource.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictOne context:nil].size;
    [labSource setFrame:CGRectMake(10, 45+labTitle.bounds.size.height+5, sizeOne.width, sizeOne.height)];
    [self.ymScrollV addSubview:labSource];
    
    //新闻图片
    UIImageView *basicImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, labSource.frame.origin.y+labSource.bounds.size.height+10, 300, 250)];
    
    NSURL *tempURL = [NSURL URLWithString:self.ymBasicModel.ymThumb];
    [basicImg setImage: [DMJSONParse gmRequestImageNews:tempURL]];
    
    [self.ymScrollV addSubview:basicImg];
    
    //具体新闻内容
    UILabel *descriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
    [descriptionlab setNumberOfLines:0];
    [descriptionlab setText:[NSString stringWithFormat:@"    %@",self.ymBasicModel.ymDescription]];
    [descriptionlab setTextColor:[UIColor whiteColor]];
    UIFont *fontTwo = [UIFont systemFontOfSize:16];
    descriptionlab.font = fontTwo;
    descriptionlab.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *dictTwo = [NSDictionary dictionaryWithObjectsAndKeys:fontTwo,NSFontAttributeName, nil];
    CGSize sizeTwo = [descriptionlab.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTwo context:nil].size;
    [descriptionlab setFrame:CGRectMake(10, basicImg.frame.origin.y + basicImg.bounds.size.height + 10, sizeTwo.width, sizeTwo.height)];
    [self.ymScrollV addSubview:descriptionlab];

    //设置self.ymScrollV的大小
    [self.ymScrollV setContentSize:CGSizeMake(320, descriptionlab.frame.origin.y + descriptionlab.bounds.size.height)];
    
}

//设置控件
-(void)gmSetControlSubView{
    //视图头部 设置
    if(!self.ymBasicTitleUpV){
        self.ymBasicTitleUpV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.ymBasicTitleUpV setAlpha:0.8];
        [self.view addSubview:self.ymBasicTitleUpV];
    }
    UIView *tempBackV = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 240, 40)];
    [tempBackV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"displayNewsBackground210*65.jpg"]]];
    [self.ymBasicTitleUpV addSubview:tempBackV];
    
    //左上方Button
    UIButton *tempUpLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:tempUpLeft];
    [tempUpLeft setBackgroundImage:[UIImage imageNamed:@"displayNews1.jpg"] forState:UIControlStateNormal];
    [tempUpLeft addTarget:self action:@selector(gmUpLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tempUpLeft setAlpha:0.8];
    
    //右上方Button
    UIButton *tempUpRight = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
    [tempUpRight setBackgroundImage:[UIImage imageNamed:@"displayNews2.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:tempUpRight];
    [tempUpRight addTarget:self action:@selector(gmUpRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tempUpRight setAlpha:0.8];
    [tempUpRight setSelected:YES];
    
    //跟帖Button
    [self gmCommentsAction];
    
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
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 0, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
    
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
    if([self.ymTxtDownUpBut.text length] != 0){
        NSLog(@"连接到跟帖");
        
        
        [self gmTxtDownActionEditingEnd];
        [self.view endEditing:YES];
       
        [self.ymDownImgComments setImage:[UIImage imageNamed:@"displayNewsDown1.jpg"]];
        
        
        //发表评论,附上新闻ID，和跟帖内容
        NSString *strAO = [DMAppearObserve gmFromAppearObserveToJSONContentid:self.ymBasicModel.ymContentid andContent:self.ymTxtDownUpBut.text];
        
        NSString *strJudge = [strAO substringWithRange:NSMakeRange(12, 5)];
        
        //若评论成功，操作
        if([strJudge intValue] == 10000){
            UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发表评论成功" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [alertSuccess show];
        }else{
            //评论失败
            UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发表评论失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [alertSuccess show];
        }
        
         self.ymTxtDownUpBut.text = nil;
        
    }
    
    
}
//子ViewButton点击后关联事件
-(void)gmSubViewButAction:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
    
    //分享
    if(tempBut.tag == 600){
    
        
    //收藏
    }else if (tempBut.tag == 601){
        NSMutableArray *tempNewsCollection = [DMCollectionSave gmSharedNewsCollection];
        BOOL result = YES;
        for(int i = 0; i < [tempNewsCollection count]; i ++){
            DMNewsDataModel *tempModel = (DMNewsDataModel *)[tempNewsCollection objectAtIndex:i];
            if([tempModel.ymContentid intValue] == [self.ymBasicModel.ymContentid intValue]){
            
                result = NO;
            }
        }
        if(result){
             [DMCollectionSave gmSharedNews:self.ymBasicModel];
        }
       
        
        
    //字体大小
    }else if(tempBut.tag == 602){
    
    }
    
}
//跟帖Button
-(void)gmCommentsAction{
    //title中跟帖

    UIButton *basicBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [basicBut setTitle:[NSString stringWithFormat:@"%d跟帖",[self.ymBasicModel.ymComments intValue]] forState:UIControlStateNormal];
    [basicBut.titleLabel setFont:[UIFont fontWithName:@"Font" size:12]];
    NSInteger tempInt = [basicBut.titleLabel.text length]*10+20;
    [basicBut setFrame:CGRectMake(275-tempInt, 7, tempInt, 26)];
    [basicBut setBackgroundColor:[UIColor redColor]];
   
    //跟帖关联事件
    [basicBut addTarget:self action:@selector(gmCommentsBasic) forControlEvents:UIControlEventTouchUpInside];
    [self.ymBasicTitleUpV addSubview:basicBut];
    [basicBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    [basicBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [basicBut setAlpha:0.6];
    
    //跟帖右侧覆盖Button
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBut setFrame:CGRectMake(270, 7, 10, 33)];
    
    [rightBut setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"displayNewsBackground210*65.jpg"]]];
    [rightBut.layer setCornerRadius:5];
    
    [self.ymBasicTitleUpV addSubview:rightBut];

}

//跟帖关联事件
-(void)gmCommentsBasic{
     self.ymCommentsBasic = nil;
    if(!self.ymCommentsBasic){
        self.ymCommentsBasic = [[DMComments alloc] init];
        [self.ymCommentsBasic.view setFrame:CGRectMake(320, 0, 320, 460)];
       
        self.ymCommentsBasic.ymContentid = [self.ymBasicModel.ymContentid intValue];
        
        //响应通知
        NSNotification *notification = [[NSNotification alloc] initWithName:@"gmCommentList" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.view addSubview:self.ymCommentsBasic.view];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymCommentsBasic.view setFrame:CGRectMake(0, 0, 320, 460)];
    } completion:^(BOOL finished){}];
    
    
    
}
@end
