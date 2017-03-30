//
//  FMViewController.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "FMViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "Car.h"

@interface FMViewController ()


/**
 *  数据源
 */
@property(nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawNavWithTitle:@"测试FMDB"];
    [self drawBackButton];
    
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
    
    /***  添加数据到数据库
     
     Person *person = [[Person alloc] init];
     person.name = name;
     person.age = age;
     
     [[DataBase sharedDataBase] addPerson:person];
     self.dataArray = [[DataBase sharedDataBase] getAllPerson];
     */

    /***  设置删除按钮
     
     Person *person = self.dataArray[indexPath.row];
     
     [[DataBase sharedDataBase] deletePerson:person];
     [[DataBase sharedDataBase] deleteAllCarsFromPerson:person];
     self.dataArray = [[DataBase sharedDataBase] getAllPerson];
     */
    
 }

#pragma mark - Getter

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}


@end
