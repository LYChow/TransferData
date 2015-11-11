//
//  LYUploadVC.h
//  TransferData
//
//  Created by lychow on 11/16/15.
//  Copyright © 2015 IOSDeveloper. All rights reserved.
//

#import "LYViewController.h"

@interface LYUploadVC : LYViewController

- (IBAction)camera:(id)sender;


- (IBAction)photo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *archiverBtn;
- (IBAction)archiver:(id)sender;

- (IBAction)upload:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@end
