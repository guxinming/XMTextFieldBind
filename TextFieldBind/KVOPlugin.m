//
//  KVOPlugin.m
//  TextFieldBind
//
//  Created by LLM on 2019/3/4.
//  Copyright © 2019 LLM. All rights reserved.
//

#import "KVOPlugin.h"

static const NSString *kUIControlEvenetKey = @"kUIControlEvenetKey";

@implementation KVOPlugin

static KVOPlugin *instance;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
        instance.keyPathMap = [NSMapTable weakToStrongObjectsMapTable];
    });
    return instance;
}

- (void)observerForObj:(id)obj keyPath:(NSString *)keyPath block:(KVOBlock)block {
    if (obj == nil) return;
    if (keyPath == nil) return;
    
    NSMapTable *map = [self.keyPathMap objectForKey:obj];
    if (!map) {
        map = [NSMapTable strongToWeakObjectsMapTable];
    }
    [map setObject:block forKey:keyPath];
    [self.keyPathMap setObject:map forKey:obj];
    
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSMapTable *map = [self.keyPathMap objectForKey:object];
    KVOBlock block = [map objectForKey:keyPath];
    if (block) {
        block(object, keyPath, change);
    }
}

- (void)eventForControl:(UIControl *)control controlEvent:(UIControlEvents)controlEvent eventBlock:(EventBlock)eventBlock {
    NSMapTable *map = [self.keyPathMap objectForKey:control];
    if (!map) {
        map = [NSMapTable strongToWeakObjectsMapTable];
    }
    [map setObject:eventBlock forKey:kUIControlEvenetKey];
    [self.keyPathMap setObject:map forKey:control];
    
    [control addTarget:self action:@selector(control:event:) forControlEvents:controlEvent];
}

- (void)control:(UIControl *)control event:(UIControlEvents)controlEvent {
    NSMapTable *map = [self.keyPathMap objectForKey:control];
    EventBlock block = [map objectForKey:kUIControlEvenetKey];
    if (block) {
        block(control);
    }
}

@end
