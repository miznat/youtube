//
//  KKViewController.h
//  tube
//
//  Created by zim on 5/02/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKViewController : UITableViewController {
    
}

@property (nonatomic, retain) NSMutableArray *videoMetaData;

@property (nonatomic, retain) NSMutableArray *allThumbnails;

@property (nonatomic, retain) NSMutableArray *myJSON;

@property (nonatomic, retain) NSMutableArray *myData;

@property (nonatomic, retain) NSURL *myurl;

@property (weak, nonatomic) IBOutlet UIImageView *cellimage;

@property (nonatomic, retain) NSMutableArray *videoID;

@property (strong,nonatomic) NSArray *urlStrings;

@end
