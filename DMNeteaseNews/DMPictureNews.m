//
//  DMPictureNews.m
//  DMNeteaseNews
//
//  Created by Geimin on 14-2-28.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMPictureNews.h"

@interface DMPictureNews ()

@end

@implementation DMPictureNews

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
 
  
        //UIview
    self.ymScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:self.ymScrollV ];
    [self.ymScrollV  setBackgroundColor:[UIColor blackColor]];
    [self.ymScrollV setAlpha:0.7];
    self.ymScrollV.bounces = YES;
    self.ymScrollV.showsHorizontalScrollIndicator = NO;
    self.ymScrollV.showsVerticalScrollIndicator = NO;
    

    

    //设置控件
    [self gmSetControlSubView];
    

    //设置显示模式
    [self gmDisplayBasicModel];
    
    //请求图组
    [self gmRequestImageArr:[self.ymPictureModel.ymContentid intValue]];
    
    //图片赋值操作
    [self gmPictureImageChangeValue:self.ymPictureModel];
    
    
    
    
    
}


//设置Model传回数据使用UILabel显示
-(void)gmDisplayBasicModel{
    //    //新闻标题
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
    [labTitle setNumberOfLines:0];
    [labTitle setText:self.ymPictureModel.ymTitle];
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
    NSString *strTimeOne = [self.ymPictureModel.ymPublished substringToIndex:10];
    NSString *strTimeTwo = [self.ymPictureModel.ymPublished substringFromIndex:[self.ymPictureModel.ymPublished length]-8];
    NSString *strSource = [NSString stringWithFormat:@"来源：%@ %@ %@",self.ymPictureModel.ymSource,strTimeOne,strTimeTwo];

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
    
    
    //UIScrollView Frame设置
    //scrollView
    if(!self.ymPictureAll){
        self.ymPictureAll = [[UIScrollView alloc] init];
        [self.ymScrollV addSubview:self.ymPictureAll];
         self.ymPictureAll.bounces = NO;
        self.ymPictureAll.showsHorizontalScrollIndicator = NO;
        self.ymPictureAll.showsVerticalScrollIndicator = NO;
        self.ymPictureAll.pagingEnabled = YES;
    }
    self.ymPicZeroHight = labSource.frame.origin.y+labSource.bounds.size.height+10;
    [self.ymPictureAll setFrame:CGRectMake(0,self.ymPicZeroHight , 320, 340)];
    
    //设置点击手势
    //给imageView添加手势
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap1:)];
    tapRecognizer1.numberOfTapsRequired = 1;//单击
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap2:)];
    tapRecognizer2.numberOfTapsRequired = 2;//双击
    [self.ymPictureAll addGestureRecognizer:tapRecognizer1];
    [self.ymPictureAll addGestureRecognizer:tapRecognizer2];
    [self.ymPictureAll setUserInteractionEnabled:YES];
    [self.ymPictureAll setAutoresizesSubviews:YES];
    [self.view addSubview:self.ymPictureAll];
    
    
    

    //具体新闻内容
    UILabel *descriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300,60)];
    [descriptionlab setNumberOfLines:0];
    [descriptionlab setText:[NSString stringWithFormat:@"    %@",self.ymPictureModel.ymDescription]];
    [descriptionlab setTextColor:[UIColor whiteColor]];
    UIFont *fontTwo = [UIFont systemFontOfSize:16];
    descriptionlab.font = fontTwo;
    descriptionlab.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *dictTwo = [NSDictionary dictionaryWithObjectsAndKeys:fontTwo,NSFontAttributeName, nil];
    CGSize sizeTwo = [descriptionlab.text boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTwo context:nil].size;
    [descriptionlab setFrame:CGRectMake(10, self.ymPictureAll.frame.origin.y + self.ymPictureAll.bounds.size.height + 10, sizeTwo.width, sizeTwo.height)];
    [self.ymScrollV addSubview:descriptionlab];
    
    //设置self.ymScrollV的大小
    [self.ymScrollV setContentSize:CGSizeMake(320, descriptionlab.frame.origin.y + descriptionlab.bounds.size.height)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置控件
-(void)gmSetControlSubView{
    //视图头部 设置
    if(!self.ymPictureTitleUpV){
        self.ymPictureTitleUpV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.ymPictureTitleUpV setAlpha:0.8];
        [self.view addSubview:self.ymPictureTitleUpV];
    }
    UIView *tempBackV = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 240, 40)];
    [tempBackV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"displayNewsBackground210*65.jpg"]]];
    [self.ymPictureTitleUpV addSubview:tempBackV];
    
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
    [self gmPictureAction];
    
    
    
    
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
            [self.ymSubViewUp setFrame:CGRectMake(200, 40, 115, 160)];
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
    for(int i = 0;i < 4;i ++){
        NSInteger tempNum = i;
        if(i == 3){
            tempNum = i +1;
        }
        
        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(0, i*40, 115, 39)];
        [tempBut setImage:[UIImage imageNamed:[NSString stringWithFormat:@"BasicSubView%d.jpg",tempNum]] forState:UIControlStateNormal ];
        tempBut.tag = 600 +i;
        [tempBut addTarget:self action:@selector(gmSubViewButAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [tempBut setAlpha:0.8];
        [self.ymSubViewUp addSubview:tempBut];
        
    }
    
}
//子ViewButton点击后关联事件
-(void)gmSubViewButAction:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
   
    //跟帖
    if(tempBut.tag == 600){
        
        
    //分享
    }else if (tempBut.tag == 601){
        

     //收藏
    }else if(tempBut.tag == 602){

             [DMCollectionSave gmSharedPicture:self.ymPictureModel];
        
    //保存
    }else if(tempBut.tag == 603){
    
    }
    
    
}
//跟帖Button
-(void)gmPictureAction{
    //title中跟帖
    UIButton *basicBut = [UIButton buttonWithType:UIButtonTypeSystem];

    [basicBut setTitle:[NSString stringWithFormat:@"%d跟帖",[self.ymPictureModel.ymComments intValue]] forState:UIControlStateNormal];
    [basicBut.titleLabel setFont:[UIFont fontWithName:@"" size:14]];
    NSInteger tempInt = [basicBut.titleLabel.text length]*10+20;
    [basicBut setFrame:CGRectMake(275-tempInt, 7, tempInt, 26)];
    [basicBut setBackgroundColor:[UIColor redColor]];
    //跟帖关联事件
    [basicBut addTarget:self action:@selector(gmCommentsPicture) forControlEvents:UIControlEventTouchUpInside];
    [basicBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [basicBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [basicBut setAlpha:0.6];
     [self.ymPictureTitleUpV addSubview:basicBut];
    
    //跟帖右侧覆盖Button
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBut setFrame:CGRectMake(270, 7, 10, 33)];
    
    [rightBut setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"displayNewsBackground210*65.jpg"]]];
    [rightBut.layer setCornerRadius:5];
    
    [self.ymPictureTitleUpV addSubview:rightBut];
    
    
}
//跟帖关联事件
-(void)gmCommentsPicture{
    self.ymCommentsPicture = nil;
    if(!self.ymCommentsPicture){
        self.ymCommentsPicture = [[DMComments alloc] init];
        [self.ymCommentsPicture.view setFrame:CGRectMake(320, 0, 320, 460)];
        
         self.ymCommentsPicture.ymContentid = [self.ymPictureModel.ymContentid intValue];
        //响应通知
        NSNotification *notification = [[NSNotification alloc] initWithName:@"gmCommentList" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.view addSubview:self.ymCommentsPicture.view];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymCommentsPicture.view setFrame:CGRectMake(0, 0, 320, 460)];
    } completion:^(BOOL finished){}];
    
    

}

//图片赋值操作
-(void)gmPictureImageChangeValue:(DMPictureNewsModel *)theModel{
    NSMutableArray *tempImageModelArr = theModel.ymImageList;
    
    [self.ymPictureAll setContentSize:CGSizeMake([tempImageModelArr count]*320, self.ymPictureAll.frame.size.height)];
    if(!self.ymImageArr){
        self.ymImageArr = [[NSMutableArray alloc] init];
    }
    if(!self.ymImageDataArr){
        self.ymImageDataArr = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i< [tempImageModelArr count]; i++){
        DMImageInfoModel *tempImageModel  = [tempImageModelArr objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:tempImageModel.ymFrURL];
        
        UIImage *image = [DMJSONParse gmRequestImageNews:url];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(320*i, 0, 320, self.ymPictureAll.frame.size.height)];
        [self.ymPictureAll addSubview:imageView];
        
        [self.ymImageArr addObject:imageView];
        [self.ymImageDataArr addObject:image];
    }
}

//请求图组
-(void)gmRequestImageArr:(NSInteger)contentid{
    NSString *str = [NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/GetImageNewsByContentId?contentid=%d",contentid ];
    NSURL *tempURL = [NSURL URLWithString:str];

    NSMutableDictionary *dictImg = [DMJSONParse gmJSONPictureParse:tempURL andKey:[NSString stringWithFormat:@"%d",contentid]];
    DMPictureNewsModel *tempPictureNewsModel = [dictImg objectForKey:[NSString stringWithFormat:@"%d",contentid]];
    self.ymPictureModel = tempPictureNewsModel;
    
}
//跳转UIImage大小
-(void)gmImageFrame{
    
    [UIView animateWithDuration:0.5 animations:^{

        

    } completion:^(BOOL finished){
        for(int i = 0; i < [self.ymImageArr count]; i ++){
            UIImageView *tempIV = [self.ymImageArr objectAtIndex:i];
            [tempIV setFrame:CGRectMake(320*i, 0, self.ymPictureAll.bounds.size.width, self.ymPictureAll.bounds.size.height)];
            
         [tempIV setImage:[self scale:[self.ymImageDataArr objectAtIndex:i] toSize:tempIV.bounds.size]];
        
        }
    }];
}
-(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (void) handleTap1:(UITapGestureRecognizer*) recognizer {
    [UIView beginAnimations:@"FullScreen" context:nil];
    
    self.ymPictureAll.frame = CGRectMake(0, 0, 320, 480);
    [self.view bringSubviewToFront:self.ymPictureAll];
    [UIView commitAnimations];
    [self.view addSubview:self.ymPictureAll];
    
    //改变Image的frame
    [self gmImageFrame];
}

- (void) handleTap2:(UITapGestureRecognizer*) recognizer {
    [UIView beginAnimations:@"Normal" context:nil];
    self.ymPictureAll.frame = CGRectMake(0, self.ymPicZeroHight, 320, 340);
    [self.view sendSubviewToBack:self.ymPictureAll];
    [UIView commitAnimations];
    [self.ymScrollV addSubview:self.ymPictureAll];
    //改变Image的frame
    [self gmImageFrame];
}
@end
