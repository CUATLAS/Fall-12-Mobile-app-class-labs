//
//  PlaceViewController.h
//  ToDoStuff
//
//  Created by Jenna Raderstrong on 11/12/12.
//  Copyright (c) 2012 Jenna Raderstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceViewController: UIViewController
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (strong, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id delegate;


@end
