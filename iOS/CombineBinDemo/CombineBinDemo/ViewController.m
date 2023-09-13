//
//  ViewController.m
//  CombineBinDemo
//
//  Created by bobobo on 2023/9/13.
//

#import "ViewController.h"
#import "CombineInterfaceBinHelp.h"
#import "ImgHeadUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self combineBin];
}

/**
 自定义组包
 */
- (void)combineBin {
    NSString *imageName = @"test.png";
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    UIImage *previewImage = [ImgHeadUtil image:image scaleToSize:CGSizeMake(66, 128)];
    image = [ImgHeadUtil image:image scaleToSize:CGSizeMake(80, 160)];
    
    [self showImage:image previewImage:previewImage];
    
    NSData *targetBinData = [CombineInterfaceBinHelp combinWithChipType:0 image:image previewImage:previewImage];
    
    // save file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    BOOL success = [targetBinData writeToFile:[documentsDirectory stringByAppendingPathComponent:@"targetData.bin"] atomically:true];
    if (success) {
        NSLog(@"文件写入成功");
    } else {
        NSLog(@"文件写入失败");
    }
}

- (void)showImage:(UIImage *)img previewImage:(UIImage *)previewImage {
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, img.size.width, img.size.height)];
    imv.image = img;
    [self.view addSubview:imv];
    
    UIImageView *previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, previewImage.size.width, previewImage.size.height)];
    previewImageView.image = previewImage;
    [self.view addSubview:previewImageView];
}

@end
