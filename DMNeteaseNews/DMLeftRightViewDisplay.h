//  子视图控制父视图 显/隐
//  DMLeftRightViewDisplay.h
//  DMNeteaseNews
//
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMLeftRightViewDisplay <NSObject>


@optional
//左侧视图
-(void)gmLeftRightViewDisplay:(BOOL)display andLeft:(BOOL)dismiss;
//右侧视图
-(void)gmLeftRightViewDisplay:(BOOL)display andRight:(BOOL)dismiss;

//调整左侧一级菜单现、隐
-(void)gmFristTitleDisplay;

@end
