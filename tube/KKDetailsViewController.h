//
//  KKDetailsViewController.h
//  tube
//
//  Created by Robert Ryan on 2/7/13.
//  Copyright (c) 2013 ikhlas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KKDetailsViewController : UIViewController {
    
    IBOutlet UIWebView *videoView;
}

@property (weak, nonatomic) NSDictionary *importVideoMetaData;

@property (weak, nonatomic) NSDictionary *importThumbnail;

@property (weak, nonatomic) NSString *importVideoID;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
