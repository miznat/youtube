//
//  KKViewController.h
//  tube
//
//  Created by zim on 5/02/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKViewController : UITableViewController {
    
  NSMutableArray *_videoMetaData;
    
}

@property (nonatomic, retain) NSMutableArray *videoMetaData;


@property (nonatomic, retain) NSMutableArray *allThumbnails;



@end
