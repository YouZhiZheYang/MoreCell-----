//
//  ViewController.m
//  MoreCell
//
//  Created by 杨金保 on 13-11-13.
//  Copyright (c) 2013年 杨金保. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize table;
@synthesize array;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    array=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0;  i<10; i++) {
        [array addObject:[NSString stringWithFormat:@"Cell%i",i]];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidUnload{
    self.array=nil;
    self.table=nil;
}

-(void)dealloc{
    [table release];
    [array release];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count =[self.array count];
    return count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tag=@"tag";
    UITableViewCell *cell=[table dequeueReusableCellWithIdentifier:tag];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //cell=[[[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:tag]autorelease];  IOS   3.0  Use
    }
    if ([indexPath row] == ([self.array count])) {
        cell.textLabel.text=@"点击 加载 更多";
    }else{
        cell.textLabel.text=[self.array objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == ([self.array count])) {
        UITableViewCell *loarMoreCell=[tableView cellForRowAtIndexPath:indexPath];
        loarMoreCell.textLabel.text=@"LoadingMore》》》》》》》";
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void)loadMore{
    NSMutableArray *more;
    more=[[NSMutableArray alloc]initWithCapacity:10];
    for (int i=0; i<10; i++) {
        [more addObject:[NSString stringWithFormat:@"Cell ++ %i",i]];
    }
    
    //加载数据
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:YES];
    [more release];
}

-(void)appendTableWith:(NSMutableArray *)data{
    for (int i=0; i<[data count]; i++) {
        [self.array addObject:[data objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths=[[NSMutableArray alloc]initWithCapacity:20];
    for (int j=0; j<[data count]; j++) {
        NSIndexPath *newPath=[NSIndexPath indexPathForRow:[self.array indexOfObject:[data objectAtIndex:j]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.table insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
