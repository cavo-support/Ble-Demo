//
//  RTKLEFoundation.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/7.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for RTKLEFoundation.
FOUNDATION_EXPORT double RTKLEFoundationVersionNumber;

//! Project version string for RTKLEFoundation.
FOUNDATION_EXPORT const unsigned char RTKLEFoundationVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <RTKLEFoundation/PublicHeader.h>

#import <RTKLEFoundation/RTKLEGeneralDefines.h>

#import <RTKLEFoundation/RTKLEPeripheral.h>
#import <RTKLEFoundation/RTKProfileAttribute.h> // deprecated
#import <RTKLEFoundation/RTKProfileAttributeKey.h>  // deprecated

#import <RTKLEFoundation/RTKLEProfile.h>


#import <RTKLEFoundation/RTKLECentralManager.h> // deprecated

#import <RTKLEFoundation/RTKPeripheralCharacteristicOperation.h>
#import <RTKLEFoundation/RTKLEPackage.h>
#import <RTKLEFoundation/RTKPackageCommunication.h>
#import <RTKLEFoundation/RTKCharacteristicReadWrite.h>

#import <RTKLEFoundation/RTKAttemptAction.h>

#import <RTKLEFoundation/RTKGATTProfileClient.h>    // deprecated

#import <RTKLEFoundation/RTKPackageIDGenerator.h>
#import <RTKLEFoundation/RTKLog.h>
#import <RTKLEFoundation/RTKLELogMacros.h>
#import <RTKLEFoundation/RTKError.h>

/* UI */
#import <RTKLEFoundation/RTKScanPeripheralViewController.h>

#import <RTKLEFoundation/RTKFile.h>
#import <RTKLEFoundation/RTKFileBrowseViewController.h>

#import <RTKLEFoundation/RTKTableViewCell.h>
