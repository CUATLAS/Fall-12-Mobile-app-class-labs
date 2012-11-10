//
//  MADViewController.m
//  continents
//
//  Created by Mattie Nobles on 10/23/12.
//  Copyright (c) 2012 Mattie Nobles. All rights reserved.
//

#import "MADViewController.h"

@interface MADViewController (){
    NSDictionary *continentData;
}

@end

@implementation MADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"Continents" ofType:@"plist"];
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    continentData=dictionary;
    self.title=@"Continents";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    continentData=nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [continentData count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    UIImage *world=[UIImage imageNamed:@"world.png"];
    cell.imageView.image=world;
    cell.detailTextLabel.text=@"Earth";
    NSArray *rowData=[continentData allKeys];
    cell.textLabel.text=[rowData objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rowData=[continentData allKeys];
    NSString *rowValue=[rowData objectAtIndex:indexPath.row];
    NSString *message=[[NSString alloc] initWithFormat:@"You picked %@", rowValue];
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"Row Selected" message:message delegate:nil cancelButtonTitle:@"Yes, I did" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
                
                                                       


@end
