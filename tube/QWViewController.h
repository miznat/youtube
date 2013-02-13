//
//  KKViewController.h
//  tube
//
//  Created by zim on 5/02/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWViewController : UITableViewController {
    
}

@property (nonatomic, retain) NSMutableArray *videoMetaData;


@property (nonatomic, retain) NSMutableArray *allThumbnails;

@property (nonatomic, retain) NSDictionary *myJSON;

@property (weak, nonatomic) IBOutlet UIImageView *cellimage;

@end

