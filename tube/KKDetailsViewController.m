//
//  KKDetailsViewController.m
//  tube
//
//  Created by Robert Ryan on 2/7/13.
//  Copyright (c) 2013 ikhlas. All rights reserved.
//

#import "KKDetailsViewController.h"

#import "AFNetworking.h"


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
    
    //NSLog(@" imported HQ thumbnail %@", self.textView.text);
    
    NSURL *url = [[NSURL alloc] initWithString:[self.importThumbnail objectForKey:@"hqDefault"]];
    
    [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fakeThumbnail.png"]];
    
    NSLog(@" imported HQ thumbnail %@", url);
    
    //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    

    
    
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
