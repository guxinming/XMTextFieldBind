//
//  ViewController.m
//  TextFieldBind
//
//  Created by LLM on 2019/3/1.
//  Copyright © 2019 LLM. All rights reserved.
//

#import "ViewController.h"
#import "ButtonMonitor.h"
#import "KVOPlugin.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) NSObject *obj;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nil
    
    NSMapTable *map = [NSMapTable weakToWeakObjectsMapTable];
    [map setObject:@"^1[0-9]{10}$" forKey:self.tf1];
    [map setObject:@"^[0-9a-zA-Z]{6,20}$" forKey:self.tf2];
    [[ButtonMonitor shareInstance] monitorButton:self.button byRegulars:map];
    
    self.obj = [NSObject new];
    
    [[KVOPlugin shareInstance] eventForControl:self.tf1 controlEvent:UIControlEventEditingChanged eventBlock:^(UIControl *control) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.button.enabled = !self.button.enabled;
    self.button.frame = CGRectMake(0, 0, 100, 100);
    
}


@end
