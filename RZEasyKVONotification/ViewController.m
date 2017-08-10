//
//  ViewController.m
//  RZEasyKVONotification
//
//  Created by 人众 on 2017/8/10.
//
//

#import "ViewController.h"
#import "NSObject+RZAddKvoOrNotification.h"
#import "Person.h"
@interface ViewController ()
@property (nonatomic, strong) Person *objA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _objA = [Person new];
    [_objA rz_addObserverBlockForKeyPath:@"name" block:^(id obj, id oldVal, id newVal) {
        NSLog(@"kvo，修改name为%@", newVal);
    }];
    [self rz_addNotificationForName:@"dongpeng" block:^(NSNotification *notification) {
        NSLog(@"收到通知1：%@", notification.userInfo);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dongpeng" object:nil userInfo:@{@"dongpeng" : @"dongpeng"}];
    static BOOL flag = NO;
    if (!flag) {
        _objA.name = @"dongpeng";
        flag = YES;
    }else{
        _objA = nil;//objA 销毁的时候其绑定的KVO会自己移除
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
