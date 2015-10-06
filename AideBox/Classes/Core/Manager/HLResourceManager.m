//
//  ABResourceManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLResourceManager.h"
#import "CXMLDocument.h"
#import "MenuViewModel.h"
#import "KMXmlParser.h"

@interface HLResourceManager(){
    NSMutableDictionary *_hostMap;
    NSMutableDictionary *_serviceUrlMap;
}

@property (nonatomic, strong) NSMutableDictionary *resourceDic;

@end

@implementation HLResourceManager

static HLResourceManager *instance = nil;

+(HLResourceManager *)shareInstance{
    @synchronized(self){
        if(!instance){
            instance = [[self alloc] init];
        }
    }
    return instance;
}

#pragma mark--------------------对资源文件配置管理------------------------

+(void)initMenuResourceWithPath:(NSString *)menuPath{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    [aInstance initMenuResourceWithPath:menuPath];
}

-(void)initMenuResourceWithPath:(NSString *)menuPath{
    if(menuPath.length == 0){
        return;
    }

    NSData *data = [NSData dataWithContentsOfFile:menuPath];
    NSString *trimmed = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSData *trimmedData = [trimmed dataUsingEncoding:NSUTF8StringEncoding];
    KMXmlParser *xmlParser = [[KMXmlParser alloc] init];
    xmlParser.discloseArrayTags = @[@"Menu"];
    id result = [xmlParser parseXml:trimmedData nodeName:@"MenuList"];
    if([result isKindOfClass:[NSArray class]]){
        NSArray *menuList = (NSArray *)result;
        NSMutableArray *menuModelList = @[].mutableCopy;
        for(id menuObj in menuList){
            MenuViewModel *model = [[MenuViewModel alloc] init];
            model.title = [menuObj valueForKey:@"title"];
            model.className = [menuObj valueForKey:@"className"];
            NSString *required = [menuObj valueForKey:@"required"];
            NSString *normalImageName = [menuObj valueForKey:@"normalImage"];
            NSString *highlightImageName = [menuObj valueForKey:@"highlightImage"];
            model.normalImage = [UIImage imageNamed:normalImageName];
            model.highlightImage = [UIImage imageNamed:highlightImageName];
            if([required isEqualToString:@"YES"]){
                model.required = YES;
            }else if([required isEqualToString:@"NO"]){
                model.required = NO;
            }
            [menuModelList addObject:model];
        }
        
        [self.resourceDic setValue:menuModelList forKey:kAppMenuSourceKey];
    }
}

+(void)initResourceWithPath:(NSString *)resPath{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    [aInstance initResourceWithPath:resPath];
}

-(void)initResourceWithPath:(NSString *)resPath{
    if(resPath.length == 0){
        return;
    }
    
}

+(id)findResourceWithName:(NSString *)resName{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    
    return [aInstance findResourceWithName:resName];
}

-(id)findResourceWithName:(NSString *)resName{
    id resource = [self.resourceDic valueForKey:resName];
    
    return resource;
}

+(id)findResourceWithParentName:(NSString *)parentName childName:(NSString *)childName{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    
    return [aInstance findResourceWithParentName:parentName childName:childName];
}

-(id)findResourceWithParentName:(NSString *)parentName childName:(NSString *)childName{
    id parentResource = [self.resourceDic valueForKey:parentName];
    
    id childResource = [parentResource valueForKey:childName];
    
    return childResource;
}


#pragma mark--------------------对HTTP通信配置管理------------------------

+(void)initConfigureWithHostPath:(NSString *)hPath suffixPath:(NSString *)spath{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    [aInstance initConfigureWithHostPath:hPath suffixPath:spath];
}

-(void)initConfigureWithHostPath:(NSString *)hPath suffixPath:(NSString *)sPath{
    [self initHostConfigureWithPath:hPath];
    [self initUrlSuffixWithPath:sPath];
    [self assembleUrlAndSuffix];
}

-(CXMLDocument *)prepareParseXML:(NSString *)aPath{
    if(aPath.length == 0){
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:aPath];
    
    NSError *aError;
    CXMLDocument *document = [[CXMLDocument alloc] initWithData:data encoding:NSUTF8StringEncoding options:0 error:&aError];
    if(aError){
        return nil;
    }
    
    if(document.children.count == 0){
        return nil;
    }
    
    return document;
}

-(void)initHostConfigureWithPath:(NSString *)aPath{
    CXMLDocument *document = [self prepareParseXML:aPath];
    if(!document){
        return;
    }
    
    if(!_hostMap){
        _hostMap = @{}.mutableCopy;
    }
    
    CXMLNode *rootNode = [document childAtIndex:0];
    
    NSArray *subNodes = [rootNode children];
    for(CXMLNode *node in subNodes){
        if(node.kind != XML_ELEMENT_NODE){
            continue;
        }
        NSString *nodeName = [node name];
        NSString *nodeValue = [node stringValue];
        [_hostMap setValue:nodeValue forKey:nodeName];
    }
}

-(void)initUrlSuffixWithPath:(NSString *)aPath{
    CXMLDocument *document = [self prepareParseXML:aPath];
    if(!document){
        return;
    }
    
    if(!_serviceUrlMap){
        _serviceUrlMap = @{}.mutableCopy;
    }
    CXMLNode *rootNode = [document childAtIndex:0];
    
    NSArray *subNodes = [rootNode children];
    for(CXMLNode *node in subNodes){
        if(node.kind != XML_ELEMENT_NODE){
            continue;
        }
        NSString *nodeName = [node name];
        NSString *nodeValue = [node stringValue];
        [_serviceUrlMap setValue:nodeValue forKey:nodeName];
    }
}

-(void)assembleUrlAndSuffix{
    NSArray *servIDs = [_serviceUrlMap allKeys];
    for(NSString *servID in servIDs){
        NSString *servUrlString = [_serviceUrlMap valueForKey:servID];
        if(servUrlString.length == 0){
            continue;
        }
        
        NSRange startRange = [servUrlString rangeOfString:@"{"];
        NSRange endRange = [servUrlString rangeOfString:@"}"];
        
        if(startRange.location == NSNotFound || endRange.location == NSNotFound){
            continue;
        }
        
        NSRange replaceRange = NSMakeRange(startRange.location + 1, endRange.location - startRange.location - 1);
        NSString *replaceString = [servUrlString substringWithRange:replaceRange];
        NSString *suffixString = [servUrlString substringFromIndex:(endRange.location + 1)];
        NSString *hostString = [_hostMap valueForKey:replaceString];
        if(hostString.length == 0){
            continue;
        }
        
        NSString *finalServUrlString = [NSString stringWithFormat:@"%@%@", hostString, suffixString];
        [_serviceUrlMap setValue:finalServUrlString forKey:servID];
    }
}

+(NSString *)urlStringWithServID:(NSString *)servID userID:(NSString *)userID{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    return [aInstance urlStringWithServID:servID userID:userID];
}

-(NSString *)urlStringWithServID:(NSString *)servID userID:(NSString *)userID{
    if(servID.length == 0 || userID.length == 0){
        return nil;
    }
    
    NSString *servUrlString = [_serviceUrlMap valueForKey:servID];
    
    NSRange startRange = [servUrlString rangeOfString:@"["];
    NSRange endRange = [servUrlString rangeOfString:@"]"];
    
    if(startRange.location == NSNotFound || endRange.location == NSNotFound){
        return servUrlString;
    }

    NSString *prefixString = [servUrlString substringToIndex:startRange.location];
    NSString *suffixString = [servUrlString substringFromIndex:(endRange.location + 1)];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", prefixString, userID, suffixString];
    
    return urlString;
}

+(NSString *)urlStringWithServID:(NSString *)servID{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    return [aInstance urlStringWithServID:servID];
}

-(NSString *)urlStringWithServID:(NSString *)servID{
    if(servID.length == 0){
        return nil;
    }
    NSString *urlString = [_serviceUrlMap valueForKey:servID];
    return urlString;
}

+(NSString *)getHostIPWithServID:(NSString *)servID{
    HLResourceManager *aInstance = [HLResourceManager shareInstance];
    return [aInstance getHostIPWithServID:servID];
}

-(NSString *)getHostIPWithServID:(NSString *)servID{
    if (servID.length == 0) {
        return nil;
    }
    NSString *hostIPString = [_hostMap valueForKey:servID];
    return hostIPString;
}

- (NSMutableDictionary *)resourceDic
{
    if (!_resourceDic) {
        _resourceDic = @{}.mutableCopy;
    }
    return _resourceDic;
}


@end
