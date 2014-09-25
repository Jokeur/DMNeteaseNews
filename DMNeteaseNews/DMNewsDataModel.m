//
//  DMNewsDataModel.m
//  DMNeteaseNews
//
//  Created by TY on 14-2-25.
//  Copyright (c) 2014年 Geimin. All rights reserved.
//

#import "DMNewsDataModel.h"

@implementation DMNewsDataModel
@synthesize ymContentid = _ymContentid;
@synthesize ymTitle = _ymTitle;
@synthesize ymModelid = _ymModelid;
@synthesize ymCatid = _ymCatid;
@synthesize ymPublished = _ymPublished;
@synthesize ymSource = _ymSource;
@synthesize ymDescription = _ymDescription;
@synthesize ymContent = _ymContent;
@synthesize ymThumb = _ymThumb;
@synthesize ymVideo = _ymVideo;
@synthesize ymPlaytime = _ymPlaytime;
@synthesize ymTopicid = _ymTopicid;
@synthesize ymComments = _ymComments;


-(void)setContentid:(NSString *)theContentid
           andTitle:(NSString *)theTitle
         andModelid:(NSString *)theModelid
           andCatid:(NSString *)theCatid
       andPublished:(NSString *)thePublished
          andSource:(NSString *)theSource
     andDescription:(NSString *)theDescription
         andContent:(NSString *)theContent
           andThumb:(NSString *)theThumb
           andVideo:(NSString *)theVideo
        andPlaytime:(NSString *)thePlaytime
         andTopicid:(NSString *)theTopicid
        andComments:(NSString *)theComments{

    _ymContentid = theContentid;
    _ymTitle = theTitle;
    _ymModelid = theModelid;
    _ymCatid = theCatid;
    _ymPublished = thePublished;
    _ymSource = theSource;
    _ymDescription = theDescription;
    _ymContent = theContent;
    _ymThumb = theThumb;
    _ymVideo = theVideo;
    _ymPlaytime = thePlaytime;
    _ymTopicid = theTopicid;
    _ymComments = theComments;


}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ymContentid forKey:@"_ymContentid"];
    [aCoder encodeObject:_ymTitle forKey:@"_ymTitle"];
    [aCoder encodeObject:_ymModelid forKey:@"_ymModelid"];
    [aCoder encodeObject:_ymCatid forKey:@"_ymCatid"];
    [aCoder encodeObject:_ymPublished forKey:@"_ymPublished"];
    [aCoder encodeObject:_ymSource forKey:@"_ymSource"];
    [aCoder encodeObject:_ymDescription forKey:@"_ymDescription"];
    [aCoder encodeObject:_ymContent forKey:@"_ymContent"];
    [aCoder encodeObject:_ymThumb forKey:@"_ymThumb"];
    [aCoder encodeObject:_ymVideo forKey:@"_ymVideo"];
    [aCoder encodeObject:_ymPlaytime forKey:@"_ymPlaytime"];
    [aCoder encodeObject:_ymTopicid forKey:@"_ymTopicid"];
    [aCoder encodeObject:_ymComments forKey:@"_ymComments"];
    

}
//逆归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if(self){
        _ymContentid = [aDecoder decodeObjectForKey:@"_ymContentid"];
        _ymTitle = [aDecoder decodeObjectForKey:@"_ymTitle"];
        _ymModelid = [aDecoder decodeObjectForKey:@"_ymModelid"];
        _ymCatid = [aDecoder decodeObjectForKey:@"_ymCatid"];
        _ymPublished = [aDecoder decodeObjectForKey:@"_ymPublished"];
        _ymSource = [aDecoder decodeObjectForKey:@"_ymSource"];
        _ymDescription = [aDecoder decodeObjectForKey:@"_ymDescription"];
        _ymContent = [aDecoder decodeObjectForKey:@"_ymContent"];
        _ymThumb = [aDecoder decodeObjectForKey:@"_ymThumb"];
        _ymVideo = [aDecoder decodeObjectForKey:@"_ymVideo"];
        _ymPlaytime = [aDecoder decodeObjectForKey:@"_ymPlaytime"];
        _ymTopicid = [aDecoder decodeObjectForKey:@"_ymTopicid"];
        _ymComments = [aDecoder decodeObjectForKey:@"_ymComments"];
    }
    return self;

}




@end
