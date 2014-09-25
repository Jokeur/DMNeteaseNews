//
//  DMProjectNews.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMProjectNews.h"

@interface DMProjectNews ()

@end

@implementation DMProjectNews

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
    self.ymScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
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
    [labTitle setText:self.ymProjectModel.ymTitle];
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
    
    NSString *strTimeOne = [self.ymProjectModel.ymPublished substringToIndex:10];
    NSString *strTimeTwo = [self.ymProjectModel.ymPublished substringFromIndex:[self.ymProjectModel.ymPublished length]-8];
    NSString *strSource = [NSString stringWithFormat:@"来源：%@ %@ %@",self.ymProjectModel.ymSource,strTimeOne,strTimeTwo];
    
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

    NSURL *tempURL = [NSURL URLWithString:self.ymProjectModel.ymThumb];
    [basicImg setImage: [DMJSONParse gmRequestImageNews:tempURL]];
    [self.ymScrollV addSubview:basicImg];
    
    //具体新闻内容
    UILabel *descriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
    [descriptionlab setNumberOfLines:0];
    [descriptionlab setText:[NSString stringWithFormat:@"    %@",self.ymProjectModel.ymDescription]];
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
    if(!self.ymProjectTitleUpV){
        self.ymProjectTitleUpV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.view addSubview:self.ymProjectTitleUpV];
    }
    UIImageView *tempImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"displayUpRight2222.jpg"]];
    [tempImgV setFrame:CGRectMake(40, 0, 280, 40)];
    [self.ymProjectTitleUpV addSubview:tempImgV];
    
    
    //左上方Button
    UIButton *tempUpLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:tempUpLeft];
    [tempUpLeft setBackgroundImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
    [tempUpLeft addTarget:self action:@selector(gmUpLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

//左上角关联事件
-(void)gmUpLeftButtonAction{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 0, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
    
}


@end
