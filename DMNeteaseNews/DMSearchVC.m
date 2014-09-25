//
//  DMSearchVC.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMSearchVC.h"

@interface DMSearchVC ()

@end

@implementation DMSearchVC

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
   

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
    //修理标题栏
    UIImageView *tempIVThree = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 276.5, 42.5)];
    [tempIVThree setImage:[UIImage imageNamed:@"searchNight11.jpg"]];
    [self.view addSubview:tempIVThree];
 
    UIButton *leftUpBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 42.5)];
    [leftUpBut addTarget:self action:@selector(gmLeftUpBut) forControlEvents:UIControlEventTouchUpInside];
    [leftUpBut setImage:[UIImage imageNamed:@"displayUpLeft111.jpg"] forState:UIControlStateNormal];

    [self.view addSubview:leftUpBut];
    
    
    
    //搜索框设置
    self.ymTxtField = [[UITextField alloc] initWithFrame:CGRectMake(15, 58, 260, 30)];
    [self.ymTxtField setBackgroundColor:[UIColor grayColor]];
    [self.ymTxtField setAlpha:0.6];
    [self.ymTxtField.layer setCornerRadius:5];
    //设置提示字符
    [self.ymTxtField setPlaceholder:@"请输入关键字..."];
    [self.ymTxtField setTextColor:[UIColor whiteColor]];

 
    //修改颜色
    [self.ymTxtField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:self.ymTxtField];
    
    //键盘风格设置
    self.ymTxtField.keyboardAppearance = UIKeyboardAppearanceAlert;
    

    
    //设置SearchButton,searchButton50_50.jpg
    
    UIButton *searchBut = [[UIButton alloc ] initWithFrame:CGRectMake(280, 58, 30, 30)];
    [searchBut setImage:[UIImage imageNamed:@"plugin_icon_search@2x.png"] forState:UIControlStateNormal];
    [searchBut setAlpha:0.5];
    //SearchButton关联事件
    [searchBut addTarget:self action:@selector(gmSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBut];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//菜单栏，左上方Button
-(void)gmLeftUpBut{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(320, 20, 320, 460)];
    } completion:^(BOOL finished){
        [self.view removeFromSuperview];
    }];
}
//SearchButton关联事件
-(void)gmSearchAction{
    
   [self.view endEditing:YES];
    //创建队列
//    dispatch_queue_t curQueueSearch = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    dispatch_async(curQueueSearch, ^{
        //判断新闻简介中有无关键字
      [self gmJudgeWord];
    
    if([self.ymSearchArr count]){
        //搜索结果显示
        [self gmSearchResultDisplay];
        //刷新数据
        [self.ymTVSearch reloadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未搜索到相关信息" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
        
//     });

}
                   
//判断新闻简介中有无关键字
-(void)gmJudgeWord{
    if(!self.ymSearchArr){
        self.ymSearchArr = [[NSMutableArray alloc] init];
    }
    
    //搜索关键字不为空时执行
    if(![self.ymTxtField.text isEqualToString:@""]){
        //数据存储地址
        self.ymStrPath = saveData_Path;
        //获得缓存中的数据
        NSMutableDictionary *tempDict = [self gmAcquireSaveNewsData];
        NSArray *dictArrKey = [tempDict allKeys];
        for(NSString *strKey in dictArrKey){
            //一个分类中的新闻数据
            NSMutableArray *tempArr = [tempDict objectForKey:strKey];
            
            for(DMNewsDataModel *newModel in tempArr){
                BOOL result = YES;
                NSInteger intTxt = [self.ymTxtField.text length];
                NSInteger intDescription = [newModel.ymDescription length];
                
                if(!(intDescription < intTxt)){
                //具体新闻
                for(int i = 0;i < intDescription - intTxt + 1;i ++){
                    NSString *subDecription = [newModel.ymDescription substringWithRange:NSMakeRange(i, intTxt)];
                    //判断截取字符串是否相等
                    if([subDecription isEqualToString:self.ymTxtField.text]){
                        //判断数组里面有无此对象
                        if([self.ymSearchArr count]){
                            for(DMNewsDataModel *tempModel in self.ymSearchArr){
                                if([tempModel.ymContentid intValue] == [newModel.ymContentid intValue] ){
                                    result = NO;
                                }
                            }
                        }
                        if(result){
                            //存储进数组
//                            [self.ymSearchArr addObject:newModel];
                            [self.ymSearchArr insertObject:newModel atIndex:0];
                        }
                    }
                    
                }
            }
          }
        }
    }
}

//获得缓存中的数据
-(NSMutableDictionary *)gmAcquireSaveNewsData{
    //逆归档
    NSData *deCodeData = [NSData dataWithContentsOfFile:self.ymStrPath];
    NSMutableDictionary *tempAcquireDict = nil;
    if(deCodeData){
        tempAcquireDict = [NSKeyedUnarchiver unarchiveObjectWithData:deCodeData];
    }
    
    
    return tempAcquireDict;
}
//搜索结果显示
-(void)gmSearchResultDisplay{
    self.ymTVSearch = nil;
    if(self.ymSearchArr){
        if(!self.ymTVSearch){
            self.ymTVSearch = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 360)];
            self.ymTVSearch.delegate = self;
            self.ymTVSearch.dataSource = self;
            [self.ymTVSearch setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grayEight.jpg"]]];
            [self.view addSubview:self.ymTVSearch];
        }
    }

}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.ymSearchArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //关键的一步，每次赋值时先清空cell
    cell = nil;
    if (cell == nil) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if(self.ymSearchArr){
        DMNewsDataModel *tempModel = (DMNewsDataModel *)[self.ymSearchArr objectAtIndex:indexPath.row];
        //获取数据
        NSURL *tempURL = [NSURL URLWithString:tempModel.ymThumb];
        
        [cell gmLeftIV:[DMJSONParse gmRequestImageNews:tempURL] andModelid:[tempModel.ymContentid intValue] andCommentsNum:tempModel.ymComments andTitle:tempModel.ymTitle andInfo:tempModel.ymDescription andHight:60];
    }
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//点击Cell 方法响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.ymBasicNews = nil;
    if(!self.ymBasicNews){
        self.ymBasicNews = [[DMBasicNews alloc] init];
        self.ymBasicNews.ymBasicModel = (DMNewsDataModel *)[self.ymSearchArr objectAtIndex:indexPath.row];;
         [self.ymBasicNews.view setFrame:CGRectMake(320, 0, 320, 460)];
    }
    [self.view addSubview:self.ymBasicNews.view];
   
    [UIView animateWithDuration:0.2 animations:^{
        [self.ymBasicNews.view setFrame:CGRectMake(0, 0, 320, 460)];
    } completion:^(BOOL finished){}];

}


@end
