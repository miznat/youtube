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

@synthesize videoMetaData = _videoMetaData;

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
    
    NSString *urlAsString = @"http://gdata.youtube.com/feeds/api/playlists/PL0l3xlkh7UnvLdr0Zz3XZZuP2tENy_qaP?v=2&alt=jsonc&max-results=50";
    
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
   // This will initiate the request and parse the data using apples JSONSerialization
    
   AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       
       
       // I am using self.videoMetaData. I am defining it in the .h file as a property. This will let me use it anywhere in this .m file.
       
       self.videoMetaData = [JSON valueForKeyPath:@"data.items.video"];
       
       // This will have all the sq and hq thumbnails
       
       self.allThumbnails = [JSON valueForKeyPath:@"data.items.video.thumbnail"];
       
       
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



//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
//    
//    
//    // Creating a NSDictionary. this will hold all the keys and their respective objects.
//    
//    
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
//    return cell;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    // Configure the cell...
    NSDictionary *titles = [self.videoMetaData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [titles objectForKey:@"title"];
    cell.detailTextLabel.text = [titles objectForKey:@"description"];
    
    NSDictionary *thumbnails = [self.allThumbnails objectAtIndex:indexPath.row];
    
    //NSLog(@"%@",thumbnails);
    
    NSURL *url = [[NSURL alloc] initWithString:[thumbnails objectForKey:@"hqDefault"]];
    
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"fakeThumbnail.png"]];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetails"])
    {
        NSDictionary *titleDetails = [self.videoMetaData objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [segue.destinationViewController setTitleDetails:titleDetails];
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
