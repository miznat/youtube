//
//  KKViewController.m
//  tube
//
//  Created by zim on 5/02/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import "KKViewController.h"

#import "AFNetworking.h"

#import "AFJSONRequestOperation.h"

#import "KKDetailsViewController.h"

#import "CustomCell.h"

@interface KKViewController ()

@end

@implementation KKViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // link to the youtube channel or playlist NOTE: JSON and JSONC are not the same. Use JSONC, as far as i recall, its customised for youtube.
    
    NSString *urlAsString = @"http://gdata.youtube.com/feeds/api/playlists/PL7CF5B0AC3B1EB1D5?v=2&alt=jsonc&max-results=50";
    
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
   // This will initiate the request and parse the data using apples JSONSerialization
    
   AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       
       
       // I am using self.videoMetaData. I am defining it in the .h file as a property. This will let me use it anywhere in this .m file.
       
       
       self.myJSON = [JSON valueForKey:@"data"];
       
       self.videoMetaData = [self.myJSON valueForKeyPath:@"items.video"];

       NSLog(@" KKVC video Meta Data %@", self.videoMetaData);
       
       
       
       // This will have all the sq and hq thumbnails
       
       self.allThumbnails = [JSON valueForKeyPath:@"data.items.video.thumbnail"];
       
       // Grab the video ID
       
       self.videoID = [JSON valueForKeyPath:@"data.items.video.id"];
       
       // The table need to be reloaded or else we will get an empty table.
       
       [self.tableView reloadData]; // Must Reload
       
      // NSLog(@" video Meta Data %@", self.videoMetaData);
       
       
       
    
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

  return [self.videoMetaData count];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    
    // Creating a NSDictionary. this will hold all the keys and their respective objects.
    
    
    NSDictionary *titles = [self.videoMetaData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [titles objectForKey:@"title"];
    cell.detailTextLabel.text = [titles objectForKey:@"description"];
    
    NSDictionary *thumbnails = [self.allThumbnails objectAtIndex:indexPath.row];
    
    //NSLog(@"%@",thumbnails);
    
    NSURL *url = [[NSURL alloc] initWithString:[thumbnails objectForKey:@"hqDefault"]];
    
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fakeThumbnail.png"]];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //cell.imageView.contentMode = UIViewContentModeCenter;
    
    return cell;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetails"])
    {
        NSDictionary *importVideoMetaData = [self.videoMetaData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        // Sending video metadata to the next view
        
        [segue.destinationViewController setImportVideoMetaData:importVideoMetaData];
        
        NSDictionary *importThumbnail = [self.allThumbnails objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        // Sending thumbnails to the next view
        
        [segue.destinationViewController setImportThumbnail:importThumbnail];
        
        
        NSLog(@" sending HQ & SQ thumbnails %@", importThumbnail);
        
        // Sending the video ID to the next view
        
        NSDictionary *importVideoID = [self.videoID objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        [segue.destinationViewController setImportVideoID:importVideoID];
        
        NSLog(@" sending video ID %@", importVideoID);
        
    }
}


@end
