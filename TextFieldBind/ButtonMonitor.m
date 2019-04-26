//
//  ButtonMonitor.m
//  TextFieldBind
//
//  Created by LLM on 2019/3/1.
//  Copyright © 2019 LLM. All rights reserved.
//

#import "ButtonMonitor.h"
#import "KVOPlugin.h"

@implementation ButtonMonitor

static ButtonMonitor *instance;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
        instance.map = [NSMapTable weakToStrongObjectsMapTable];
        instance.resultMap = [NSMapTable weakToStrongObjectsMapTable];
    });
    return instance;
}

- (void)monitorButton:(UIButton *)button byRegulars:(NSMapTable<UITextField *,NSString *> *)regularDict {
    
    NSEnumerator *enumerator = [regularDict keyEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
        //构建当textField变化用来查询的map
        NSMapTable *maptable = [NSMapTable weakToStrongObjectsMapTable];
        [maptable setObject:regularDict forKey:button];
        [self.map setObject:maptable forKey:value];
        [self.resultMap setObject:@(NO) forKey:value];
        [(UITextField *)value addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSMapTable *map = [self.map objectForKey:textField];
    UIButton *button = nil;
    NSEnumerator *enumerator = [map keyEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
         button = value;
    }
    NSMapTable *subMap = [map objectForKey:button];
    NSString *regular = [subMap objectForKey:textField];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    [self.resultMap setObject:@([predicate evaluateWithObject:textField.text]) forKey:textField];
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSEnumerator *subEnumerator = [subMap keyEnumerator];
    id subValue;
    while ((subValue = [subEnumerator nextObject])) {
        UITextField *subTextField = subValue;
        [mArray addObject:[self.resultMap objectForKey:subTextField]];
    }

}

@end
