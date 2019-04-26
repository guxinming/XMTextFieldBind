//
//  ButtonMonitor.h
//  TextFieldBind
//
//  Created by LLM on 2019/3/1.
//  Copyright © 2019 LLM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ButtonMonitor : NSObject

@property (nonatomic, strong) NSMapTable *map;
@property (nonatomic, strong) NSMapTable *resultMap;

+ (instancetype)shareInstance;

- (void)monitorButton:(UIButton *)button byRegulars:(NSMapTable <UITextField *, NSString *>*)regularDict;


@end

