//
//  HomeworkViewController.m
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/10/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import "HomeworkViewController.h"

@interface HomeworkViewController ()


@end

@implementation HomeworkViewController
@synthesize homework, task, editedSelection; 


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
    homework=[NSMutableArray arrayWithObjects:nil];
    task=[NSMutableArray arrayWithObjects:nil];
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [homework count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeworkCell"];
    NSString *home=[homework objectAtIndex:indexPath.row];
    cell.textLabel.text=home;
    NSString *tasks=[task objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=tasks;
    return cell;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row]; 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [homework removeObjectAtIndex:row]; 
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
       
    }   
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddHomework"]){
        UINavigationController *navigationController =
        segue.destinationViewController;
        HomeworkDetailsViewController *homeworkDetailsViewController =
        [[navigationController viewControllers] objectAtIndex:0];
        homeworkDetailsViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"EnterTask"]){
        UIViewController *destination=segue.destinationViewController; 
        if ([destination respondsToSelector:@selector(setDelegate:)]){ 
            [destination setValue:self forKey:@"delegate"]; 
        if ([destination respondsToSelector:@selector(setSelection:)]){ 
            NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
            id object=[task objectAtIndex:indexPath.row];
       NSDictionary *selection=[NSDictionary dictionaryWithObjectsAndKeys: indexPath, @"indexPath", object, @"object", nil];
            [destination setValue:selection forKey:@"selection"]; 
          
        }
    }
}
}

- (void)setEditedSelection:(NSDictionary *)dict {
    if (![dict isEqual:editedSelection]) {
        editedSelection = dict;
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        id newValue = [dict objectForKey:@"object"]; 
        [task replaceObjectAtIndex:indexPath.row withObject:newValue];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; 
    }
}


-
(void)homeworkDetailsViewControllerDidCancel:(HomeworkDetailsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)homeworkDetailsViewController:(HomeworkDetailsViewController *)controller DidSave:(NSString *)newHomework{
    if(newHomework.length>0){
    
    [homework addObject:newHomework];
    [task addObject:@"Not Done"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[homework count]-1 inSection:0]; 
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation: UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    //dismisses the view controller
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSUInteger fromRow=[fromIndexPath row]; 
    NSUInteger toRow=[toIndexPath row]; 
    NSString *moveHomework=[homework objectAtIndex:fromRow];
    [homework removeObjectAtIndex:fromRow]; 
    [homework insertObject:moveHomework atIndex:toRow]; 
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < [homework count])
        return YES;
    else return NO; 
}

/*-(NSString *)dataFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory=[paths objectAtIndex:0]; 
    NSLog(@"documents path: %@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"continents.plist"]; 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath=[self dataFilePath];
    NSLog(@"filePath: %@", filePath);
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    //creates a NSFileManager instance for the file system
    if (![fileManager fileExistsAtPath:filePath]){ //uses starting
        plist
        NSLog(@"file not found");
        NSBundle *bundle=[NSBundle mainBundle]; //returns a bundle
        object of our app
        filePath=[bundle pathForResource:@"continents"
                                  ofType:@"plist"]; //retrieve the path of continents.plist
    }
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]
                                     initWithContentsOfFile:filePath]; //loads the contents of the plist
    file into a dictionary
    //the dictionary uses the continents as the keys and a NSArray
    with the countries for each continent.
        continentData=dictionary;
    self.title=@"Continents"; //sets the title of the controller
    UIApplication *app=[UIApplication sharedApplication]; //returns
    the application instance
    //subscribing to UIApplicationWillResignActiveNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];Aileen Pierce Mobile Application Development 10/29/2012
}*/
@end
