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

@synthesize importVideoID;

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
    
    NSURL *url = [[NSURL alloc] initWithString:[self.importThumbnail objectForKey:@"hqDefault"]];
    [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fakeThumbnail.png"]];
    NSLog(@" imported HQ thumbnail %@", url);
    
    
    // BELOW LINES WILL RECEIVE VIDEO ID FROM PREVIOUS VIEW AND DISPLAY VIDEOS
    
    NSString *htmlString = @"<html><head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
    <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
    <iframe id=\"ytplayer\" type=\"text/html\" width=\"320\" height=\"240\"\
    src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
    frameborder=\"0\"/>\
    </body></html>";
    htmlString = [NSString stringWithFormat:htmlString, importVideoID, importVideoID];
    [videoView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
