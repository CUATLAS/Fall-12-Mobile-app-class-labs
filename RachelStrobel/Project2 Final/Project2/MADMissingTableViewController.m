//
//  MADMissingTableViewController.m
//  Project2
//
//  Created by Rachel Strobel on 11/10/12.
//  Copyright (c) 2012 Rachel Strobel. All rights reserved.
//

#import "MADMissingTableViewController.h"

@interface MADMissingTableViewController ()


@end

@implementation MADMissingTableViewController


 {
     
 //Referencing code below from website: http://www.appcoda.com/customize-table-view-cells-for-uitableview/
     
   NSArray *tableData;
   NSArray *thumbnails;
}


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
    
    //Referencing code below from website: http://www.appcoda.com/customize-table-view-cells-for-uitableview/
    
    tableData = [NSArray arrayWithObjects: @"Blanca Helena Gutierrez Rosales", @"Daniela Patino Castillo", @"Erika de la Piedra Manzano", @"Fabiola Nallerly Luquin Reyes", @"Ivonne Ramirez Mora", @"Lisset Soto Salinas", @"Monica Alejandra Ramirez Alavarado", @"Zaira Berenice Giffard Palacios", nil];
    
//All pictures below were taken from website:https://www.facebook.com/FundacionReintegraAC?fref=ts and modified in photoshop
    thumbnails = [NSArray arrayWithObjects:@"1blanca.jpg", @"2daniela.jpg", @"3erika.jpg", @"4fabiola.jpg", @"5ivonne.jpg", @"6lisset.jpg", @"7monica.jpg", @"8zaira.jpg", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
       return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source


 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
   //Referencing code below from website: http://www.appcoda.com/customize-table-view-cells-for-uitableview/
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12.5];
    
    return cell;

}

#pragma mark - Table view delegate

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue=[tableData objectAtIndex:indexPath.row];
    NSString *message =[[NSString alloc] initWithFormat:@"%@", rowValue];
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"Missing Person Selected" message:message delegate:nil
                        cancelButtonTitle:@"Yes, I will continue to look for her" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
