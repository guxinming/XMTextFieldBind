//
//  KVOPlugin.h
//  TextFieldBind
//
//  Created by LLM on 2019/3/4.
//  Copyright © 2019 LLM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^KVOBlock)(id obj, NSString *keyPath, NSDictionary<NSKeyValueChangeKey,id> *);
typedef void(^EventBlock)(UIControl *control);

@interface KVOPlugin : NSObject

@property (copy) KVOBlock kvoBlock;
@property (nonatomic, strong) NSMapTable *keyPathMap;

+ (instancetype)shareInstance;

- (void)observerForObj:(id)obj keyPath:(NSString *)keyPath block:(KVOBlock)block;

- (void)eventForControl:(UIControl *)control controlEvent:(UIControlEvents)controlEvent eventBlock:(EventBlock)eventBlock;

@end

