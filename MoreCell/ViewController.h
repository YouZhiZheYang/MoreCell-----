//
//  ViewController.h
//  MoreCell
//
//  Created by 杨金保 on 13-11-13.
//  Copyright (c) 2013年 杨金保. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *array;
    IBOutlet UITableView *table;
}
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) UITableView *table;

@end
