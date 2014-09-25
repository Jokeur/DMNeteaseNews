//
//  DMCollectVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMCollectVC.h"

@interface DMCollectVC ()

@end

@implementation DMCollectVC

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
    // Do any additional setup after loading the view from its nib.
    
    

    //收藏文件沙盒位置

    [DMCollectionSave gmAcquireCollectDataPath:collectPath_save];
 
    //更新TableView数据
    self.ymCellMArr = [DMCollectionSave gmSharedNewsCollection];
    self.ymFloat = 3000;
    //更新数据，存档
    [self gmSaveDataAndReloadData];
    
    
    //清空沙盒中数据
    [self gmRemoveDataFromPath:self.ymCollectPath];
    
    
    UIImageView *tempIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    [tempIV setImage:[UIImage imageNamed:@"collectLeftMark2.jpg"]];
    [self.view addSubview:tempIV];
    //修理标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"collectLeftMark222.jpg"]];
    [tempIV addSubview:tempIVThree];
   

    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 40)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];
  
    [self.view addSubview:leftUpBut];
    //声明，Button
    if(!self.ymCollectButton){
        self.ymCollectButton = [[UIButton alloc] initWithFrame:CGRectMake(45, 0, 118, 40)];
        self.ymCollectButton.selected = YES;
        [self.ymCollectButton setImage:[UIImage imageNamed:@"newCollect.jpg"] forState:UIControlStateNormal];
        [self.ymCollectButton addTarget:self action:@selector(gmCollectButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.ymCollectButton];
    }
    self.ymCollectTV = nil;
    if(!self.ymCollectTV){
        self.ymCollectTV = [[UITableView alloc] init];
        [self.ymCollectTV setFrame:CGRectMake(0, 40, 320, 420)];
        [self.ymCollectTV setDataSource:self];
        [self.ymCollectTV setDelegate:self];
        [self.view addSubview:self.ymCollectTV];
        [self.ymCollectTV setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    }
    
    
    //声明view

    if(!self.ymCollectView){
        self.ymCollectView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 40, 118, 0)];
        [self.ymCollectView setBackgroundColor:[UIColor grayColor]];
        [self.ymCollectView setAlpha:0.8];
        [self.view addSubview:self.ymCollectView];
    }
    
    //在ScrollView上面创建三个Button
    self.ymCollectMArr = nil;
    if(!self.ymCollectMArr){
        self.ymCollectMArr = [[NSMutableArray alloc] init];
    }
    
    NSArray *tempArr = [[NSArray alloc] initWithObjects:@"新闻收藏",@"跟帖收藏",@"图片收藏",nil];
    for(int i = 0; i < 3; i++){
        UIButton *tempBut = [[UIButton alloc] initWithFrame:CGRectMake(0, i*40, 118, 39)];
        [tempBut setTitle:[tempArr objectAtIndex:i]  forState:UIControlStateNormal];
        [tempBut setBackgroundColor:[UIColor blackColor]];
        

        tempBut.tag = 3000+i;
        [self.ymCollectMArr addObject:tempBut];
        if(i == 0){
            [tempBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [tempBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        //关联事件
        [tempBut addTarget:self action:@selector(gmCollectDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.ymCollectView addSubview:tempBut];
    }
    

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
}
//收藏Button
-(void)gmCollectButtonAction{
    
    if([self.ymCollectButton isSelected]){
        [self.ymCollectView setFrame:CGRectMake(45, 42.5, 118, 119)];
        self.ymCollectButton.selected = NO;
        
        
    }else{
        [self gmDismissView];
        self.ymCollectButton.selected = YES;
    }


}
//Button关联事件
-(void)gmCollectDown:(id)sender{
    UIButton *tempBut = (UIButton *)sender;
    
    self.ymFloat = 0;
    //新闻收藏
    if(tempBut.tag == 3000){
        [self.ymCollectButton setImage:[UIImage imageNamed:@"newCollect.jpg"] forState:UIControlStateNormal];
        
        
        //更新TableView数据
        self.ymCellMArr = [DMCollectionSave gmSharedNewsCollection];
        self.ymFloat = 3000;
        //更新数据，存档
        
        [self gmSaveDataAndReloadData];
    }
    //跟帖收藏
   else  if(tempBut.tag == 3001){
        [self.ymCollectButton setImage:[UIImage imageNamed:@"followCollect.jpg"] forState:UIControlStateNormal];
        [self gmDismissView];
        self.ymCollectButton.selected = YES;
        
        
        //更新TableView数据
        self.ymCellMArr = [DMCollectionSave gmSharedCommentCollection];
         self.ymFloat = 3001;
        //更新数据，存档
   
        [self gmSaveDataAndReloadData];
    }
    //图片收藏
   else if(tempBut.tag == 3002){
        [self.ymCollectButton setImage:[UIImage imageNamed:@"pictureCollect.jpg"] forState:UIControlStateNormal];
        [self gmDismissView];
        self.ymCollectButton.selected = YES;
         self.ymFloat = 3002;
        
        //更新TableView数据
        self.ymCellMArr = [DMCollectionSave gmSharedPictureCollection];
        //更新数据，存档
        [self gmSaveDataAndReloadData];
    }
    
    for(int i = 0; i < [self.ymCollectMArr count];i ++){
        [[self.ymCollectMArr objectAtIndex:i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self gmDismissView];
        self.ymCollectButton.selected = YES;
    }
    
    [tempBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//更新数据 存档
-(void)gmSaveDataAndReloadData{

    //更新数据
    [self.ymCollectTV reloadData];
    
  
}
//清空沙盒中数据
-(void)gmRemoveDataFromPath:(NSString *)strPath{
    NSError *error = [[NSError alloc] init];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:strPath error:&error];
}

//从沙盒获取数据
-(NSMutableArray *)gmAcquireCollectDataPath:(NSString *)strPath{
    
    NSData *collectData = [NSData dataWithContentsOfFile:strPath];
    NSMutableArray *collectArr = [NSKeyedUnarchiver unarchiveObjectWithData:collectData];
    
    return collectArr;
}

//移除View
-(void)gmDismissView{
  
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymCollectView setFrame:CGRectMake(45, 42.5, 118, 0)];
    } completion:^(BOOL finished){}];

}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  return [self.ymCellMArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DMCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    if(self.ymFloat == 3000){
        DMNewsDataModel *tempModel = [self.ymCellMArr objectAtIndex:indexPath.row];
        
        [cell gmNewsCollectTitle:tempModel.ymTitle andContent:tempModel.ymDescription andComments:tempModel.ymComments];
    }
    else if(self.ymFloat == 3001){
        
        DMCommentModel *tempModel = [self.ymCellMArr objectAtIndex:indexPath.row];
        NSString *titleStr = [DMCollectionSave gmTextNewsTitleFromContent:tempModel.ymContentId];
        [cell gmCommentCollectTitle:titleStr andContent:tempModel.ymContent];
    }
    else if (self.ymFloat == 3002){
        DMPictureNewsModel *tempModel = [self.ymCellMArr objectAtIndex:indexPath.row];
        NSMutableArray *tempArr = [self gmPictureAll:tempModel];
        
        [cell gmPictureCollectImage:tempArr andPictureLab:tempModel.ymTitle andComments:[NSString stringWithFormat:@"%d",[tempArr count]]];
    
    }

    
    return cell;
}

//得到图组图片数组
-(NSMutableArray *)gmPictureAll:(DMPictureNewsModel *)theModel{
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSMutableArray*tempImageList = theModel.ymImageList;
    for(DMImageInfoModel *imgModel in tempImageList){
        NSURL *url = [NSURL URLWithString:imgModel.ymFrURL];
        UIImage *img = [DMJSONParse gmRequestImageNews:url];
        [tempArr addObject:img];
    
    }
    return tempArr;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(self.ymFloat == 3000){
         return 80;
        
    }
    else if(self.ymFloat == 3001){
          return 80;
    }
    else{
        return 200;
        
    }
 

}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    if(self.ymFloat == 3000){
        DMNewsDataModel *tempModel = [self.ymCellMArr objectAtIndex:indexPath.row];
         self.ymBasicNews = nil;
        if(!self.ymBasicNews){
            self.ymBasicNews = [[DMBasicNews alloc] init];
            self.ymBasicNews.ymBasicModel = tempModel;
            [self.ymBasicNews.view setFrame:CGRectMake(320, 0, 320, 460)];
        }
        [self.view addSubview:self.ymBasicNews.view];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymBasicNews.view setFrame:CGRectMake(0, 0, 320, 460)];
        } completion:^(BOOL finished){}];
      
    }
    else if(self.ymFloat == 3001){

    }
    else if (self.ymFloat == 3002){
        DMPictureNewsModel *tempModel = [self.ymCellMArr objectAtIndex:indexPath.row];
        self.ymPictureNews = nil;
        if(!self.ymPictureNews){
            self.ymPictureNews = [[DMPictureNews alloc] init];
            self.ymPictureNews.ymPictureModel = tempModel;
            [self.ymPictureNews.view setFrame:CGRectMake(320, 0, 320, 460)];
        }
        [self.view addSubview:self.ymPictureNews.view];
      
        [UIView animateWithDuration:0.2 animations:^{
            [self.ymPictureNews.view setFrame:CGRectMake(0, 0, 320, 460)];
        } completion:^(BOOL finished){}];
    }
  
}
@end
