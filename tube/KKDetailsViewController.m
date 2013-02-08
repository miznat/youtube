//
//  KKDetailsViewController.m
//  tube
//
//  Created by Robert Ryan on 2/7/13.
//  Copyright (c) 2013 ikhlas. All rights reserved.
//

#import "KKDetailsViewController.h"


@interface KKDetailsViewController ()

@end

@implementation KKDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // This will set the video title on the nav bar
    
    //self.title = self.importVideoMetaData[@"title"];
    
    //self.textView.text = self.importVideoMetaData[@"description"];
    
    self.textView.text = [self.importVideoMetaData objectForKey:@"description"];
    
    //self.imageView.image = [self.importAllThumbnails objectForKey:@"hqDefault"];
    
    self.imageView.image = [[UIImage alloc] init];
    self.imageView.image =[UIImage imageNamed:[(NSDictionary *)self.importAllThumbnails objectForKey:@"hqDefault"]];
    
    //self.imageView = [UIImage imageNamed: @"hqDefault"];
    
    NSLog(@" video Meta Data %@", self.importAllThumbnails);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
