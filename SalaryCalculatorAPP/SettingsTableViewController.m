//
//  SettingsTableViewController.m
//  SalaryCalculatorAPP
//
//  Created by Nagam Pawan on 1/20/17.
//  Copyright © 2017 chaitanya. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <sys/utsname.h>
#import <Social/Social.h>

#import "NSManagedObject+DictionaryFormat.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background2"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkDropBox) name:@"UIApplicationDidBecomeActiveNotification" object:nil];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"dropBox"] isEqualToString:@"1"]) {
        
        self.dropSwitchButton.on = YES;
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"dropBox"] isEqualToString:@"0"]) {
        
        self.dropSwitchButton.on = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 4;
        
    }
    
    if (section == 1) {
        
        if (self.dropSwitchButton.isOn) {
            
            return 3;
        }
        
        else{
            
            return 1;
            
        }
    }
    return 0;
}

- (IBAction)dropSwitch:(id)sender {
    
    if (self.dropSwitchButton.isOn) {
        
        [DropboxClientsManager authorizeFromController:[UIApplication sharedApplication] controller:self openURL:^(NSURL * url) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            
        } browserAuth:YES];
        
    }
    
    if (![self.dropSwitchButton isOn]) {
        
        NSString *value = @"0";
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"dropBox"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    [self.tableView reloadData];
    
}

-(NSManagedObjectContext *)getContext{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;

}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentStoreCoordinator *coordinator = appDelegate.persistentContainer.persistentStoreCoordinator;
    return coordinator;
    
}

-(NSArray *)fetchData{
    
    NSManagedObjectContext *context = [self getContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Expense"];
    NSArray* backUpArray = [[NSArray alloc]initWithArray:[context executeFetchRequest:request error:nil]];
    
    NSMutableArray* arrayOfDict = [NSMutableArray array];
    for (NSManagedObject* object in backUpArray) {
        NSDictionary* dict = [object getDictionaryFormat];
        [arrayOfDict addObject:dict];
    }
    return arrayOfDict;
    
  }

-(void)checkDropBox{
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"dropBox"] isEqualToString:@"1"]) {
        
        self.dropSwitchButton.on = YES;
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"dropBox"] isEqualToString:@"0"]) {
        
        self.dropSwitchButton.on = NO;
        
    }
    
    [self.tableView reloadData];
    
}

-(void)backUpMethod{
    
    NSArray* data = [self fetchData];
    DropboxClient *client = [DropboxClientsManager authorizedClient];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:data];
    
    [self deleteFolder:client data:myData];
}

- (void) deleteFolder:(DropboxClient *)client data:(NSData *)data{
    [[client.filesRoutes delete_:@"/backup/app"]response:^(DBFILESMetadata * _Nullable metadata, DBFILESDeleteError * _Nullable deleteError, DBRequestError * _Nullable error) {
        [self createFolder:client data:data];
    }];
}

- (void) createFolder:(DropboxClient *)client  data:(NSData *)data{
    [[client.filesRoutes createFolder:@"/backup/app"] response:^(DBFILESFolderMetadata * result, DBFILESCreateFolderError * routeError, DBRequestError * error) {
        
        if (result) {
            
            NSLog(@"%@\n", result);
            [self upload:client data:data];
        }
        else{
            
            NSLog(@"%@\n%@\n", routeError, error);
            
        }
    }];
}

- (void) upload:(DropboxClient *)client  data:(NSData *)data{
    [[[client.filesRoutes uploadData:@"/backup/app/salarycalculator.backup" inputData:data] response:^(DBFILESFileMetadata * result, DBFILESUploadError * routeError, DBRequestError * error) {
        
        if (result) {
            
            NSLog(@"Uploaded data: %@", result);
            [self dispayAlert:@"Success" :@"App backUp is created in the dropBox"];
            [UIApplication sharedApplication]. networkActivityIndicatorVisible = NO;
            
        }
        else{
            
            NSLog(@"%@\n%@\n", routeError, error);
            [self dispayAlert:@"Error" :@"Failed to backUp"];
            [UIApplication sharedApplication]. networkActivityIndicatorVisible = NO;
            
        }
    }] progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        NSLog(@"\n%lld\n%lld\n%lld\n", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        
    }];
}
- (IBAction)backUpButton:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BackUp to DropBox" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Backup To DropBox" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self backUpMethod];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)feedBack:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
    
        NSLog(@"can send the mail");
        NSString *emailTitle = @"SalaryCaluclator";
        NSString *messageBody = @"My salary app";
        NSArray *recepients = [NSArray arrayWithObject:@"ipa@neorays.com"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        [mc setToRecipients:recepients];
        [self presentViewController:mc animated:YES completion:nil];
    }
    
    else{
        
        [self CreateAlert:@"Error" :@"Your device will not support Mail services"];
        
    }
    
}

-(void)dispayAlert: (NSString *)title : (NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    
    switch (result) {
        case MFMailComposeResultCancelled:
            
            
            [self CreateAlert:@"Error" :@"Message Sending Cancelled"];
            
            break;
            
        case MFMailComposeResultFailed:
            
            [self CreateAlert:@"Error" :@"Message Sending Failed"];
            
            break;
            
        case MFMailComposeResultSent:
            
            [self CreateAlert:@"Message Alert" :@"Message Sent Sucsessfully..."];
            
            
            break;
            
        case MFMailComposeResultSaved:
            
            [self CreateAlert:@"Message Alert" :@"Message Saved Sucsessfully..."];
            
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



-(void)CreateAlert : (NSString *)title :(NSString *)message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)shareToFriends:(id)sender {
    
    NSString *name = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1200699776&mt=8&uo=6";
    NSString * msg = @"\nDownload my App from AppStore";
   
    NSArray *array = @[name, msg];
    UIActivityViewController *shareActivity = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
    [self presentViewController:shareActivity animated:YES completion:nil];
    
}

- (IBAction)rateReview:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1200699776&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"] options:@{} completionHandler:nil];
    
}

#pragma mark- Restore
- (IBAction)restoreFromDropBox:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Restore from Dropbox" message:@"All data in app will be replaced by the data on Dropbox" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Restore from Dropbox" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self restoreMethod];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)restoreMethod{
    
    DropboxClient *client = [DropboxClientsManager authorizedClient];
    
    // Download to NSData
    [[client.filesRoutes downloadData:@"/backup/app/salarycalculator.backup"]response:^(DBFILESFileMetadata * _Nullable metaData, DBFILESDownloadError * _Nullable downloadError, DBRequestError * _Nullable requestError, NSData * _Nonnull data) {
        if (metaData) {
            NSArray* backupResults = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if (backupResults.count > 0) {
                [self deleteAllObjectesInCoreData];
                
                [self createCoreDataObjects:backupResults];
                [self CreateAlert:@"Restore completed" :@"Data is restored from Dropbox successfully"];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
            }
        } else {
            NSLog(@"%@\n%@\n", downloadError, requestError);
            [self CreateAlert:@"Restore failed" :@"Unknown error occured while restoring"];
            [UIApplication sharedApplication]. networkActivityIndicatorVisible = NO;
        }
    }];
}

- (void) deleteAllObjectesInCoreData {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Expense"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [[self persistentStoreCoordinator] executeRequest:delete withContext:[self getContext] error:&deleteError];
}

- (void) createCoreDataObjects:(NSArray*)array {
    for (NSDictionary* dict in array) {
        NSManagedObjectContext *context = [self getContext];
        Expense *object = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"inManagedObjectContext:context];
        [object setValuesFromDictionary:dict];
    }
    
    [self saveData];
}

#pragma -mark SaveData
-(void)saveData {
    
    NSError *error = nil;
    if (![[self getContext] save:&error]) {
        NSLog(@"Data not saved");
    }
    else{
        NSLog(@"data is saved");
    }
    
}

@end
