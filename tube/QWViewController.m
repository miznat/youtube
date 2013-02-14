//
//  KKViewController.m
//  tube
//
//  Created by zim on 5/02/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import "QWViewController.h"

#import "AFNetworking.h"

#import "AFJSONRequestOperation.h"

#import "KKDetailsViewController.h"

#import "CustomCell.h"

@interface QWViewController ()



@end

@implementation QWViewController{

int counter;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    counter = 0;
    NSString *urlAsString = @"http://gdata.youtube.com/feeds/api/playlists/PL7CF5B0AC3B1EB1D5?v=2&alt=jsonc&max-results=50";
    NSString *urlAsString2 = @"http://gdata.youtube.com/feeds/api/playlists/PL7CF5B0AC3B1EB1D5?v=2&alt=jsonc&max-results=50&start-index=51";
    self.urlStrings = @[urlAsString,urlAsString2];
    self.allThumbnails = [NSMutableArray array];
    self.videoMetaData = [NSMutableArray array];
    [self getJSONFromURL:self.urlStrings[0]];
}


-(void)getJSONFromURL:(NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.myJSON = [JSON valueForKey:@"data"];
        [self.allThumbnails addObjectsFromArray:[self.myJSON valueForKeyPath:@"items.video.thumbnail"]];
        [self.videoMetaData  addObjectsFromArray:[self.myJSON valueForKeyPath:@"items.video"]];
        [self.tableView reloadData];
        counter += 1;
        if (counter < self.urlStrings.count) [self getJSONFromURL:self.urlStrings[counter]];
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);}];
    
    
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
    
    return cell;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellID = @"Cell";
//
//    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
//    if (cell == nil) {
//        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
//    }
//
//    // Configure the cell...
//    NSDictionary *titles = [self.videoMetaData objectAtIndex:indexPath.row];
//
//    cell.textLabel.text = [titles objectForKey:@"title"];
//    cell.detailTextLabel.text = [titles objectForKey:@"description"];
//
//    NSDictionary *thumbnails = [self.allThumbnails objectAtIndex:indexPath.row];
//
//    //NSLog(@"%@",thumbnails);
//
//    NSURL *url = [[NSURL alloc] initWithString:[thumbnails objectForKey:@"hqDefault"]];
//
//    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fakeThumbnail.png"]];
//
//    //cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    return cell;
//
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetails"])
    {
        NSDictionary *importVideoMetaData = [self.videoMetaData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        [segue.destinationViewController setImportVideoMetaData:importVideoMetaData];
        
        NSDictionary *importAllThumbnails = [self.allThumbnails objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        [segue.destinationViewController setImportThumbnail:importAllThumbnails];
        
        NSDictionary *importVideoID = [self.videoID objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        [segue.destinationViewController setImportVideoID:importVideoID];
        
        NSLog(@" sending video ID %@", importVideoID);
        
    }
}

//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
