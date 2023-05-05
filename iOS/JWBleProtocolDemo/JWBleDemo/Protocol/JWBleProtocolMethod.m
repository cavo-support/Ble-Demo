//
//  JWBleProtocolMethod.m
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "JWBleProtocolMethod.h"

/******************* Macro defination *************************************/
#define L1_HEADER_MAGIC (0xAB)   /*header magic number */
#define L1_HEADER_VERSION (0x00) /*protocol version */
#define L1_HEADER_SIZE (8)       /*L1 header length*/

/**************************************************************************
 * define L1 header byte order
 ***************************************************************************/
#define L1_HEADER_MAGIC_POS (0)
#define L1_HEADER_PROTOCOL_VERSION_POS (1)
#define L1_PAYLOAD_LENGTH_HIGH_BYTE_POS (2) /* L1 payload lengh high byte */
#define L1_PAYLOAD_LENGTH_LOW_BYTE_POS (3)
#define L1_HEADER_CRC16_HIGH_BYTE_POS (4)
#define L1_HEADER_CRC16_LOW_BYTE_POS (5)
#define L1_HEADER_SEQ_ID_HIGH_BYTE_POS (6)
#define L1_HEADER_SEQ_ID_LOW_BYTE_POS (7)

/**************************************************************************
 * define L2 header byte order
 ***************************************************************************/
#define L2_HEADER_SIZE (2)       /*L2 header length*/
#define L2_HEADER_VERSION (0x00) /*L2 header version*/
#define L2_KEY_SIZE (1)
#define L2_PAYLOAD_HEADER_SIZE (3) /*L2 payload header*/

#define L2_FIRST_VALUE_POS (L2_HEADER_SIZE + L2_PAYLOAD_HEADER_SIZE)

#define L1_PACKET_PRE_SIZE (L1_HEADER_SIZE + L2_FIRST_VALUE_POS) /*L2 header length*/

UInt16 crc16_table2[256] =
    {
        0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241,
        0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440,
        0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40,
        0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841,
        0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40,
        0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41,
        0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641,
        0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040,
        0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240,
        0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441,
        0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41,
        0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840,
        0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41,
        0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40,
        0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640,
        0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041,
        0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240,
        0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441,
        0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41,
        0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840,
        0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41,
        0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40,
        0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640,
        0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041,
        0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241,
        0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440,
        0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40,
        0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841,
        0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40,
        0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41,
        0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641,
        0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040};

typedef struct _L1_HEADER {
    UInt8 magicByte; //0xab
    UInt8 reserve : 1;
    UInt8 noAckFlag: 1;
    UInt8 errFlag : 1;
    UInt8 ackFlag : 1;
    UInt8 version : 4;
    UInt16 payloaddLength;
    UInt16 crc16;
    UInt16 seqID;

} L1_HEADER;

typedef struct _L2_HEADER {
    UInt8 cmdID;
    UInt8 version : 4;
    UInt8 reserve : 4;
} L2_HEADER;

typedef struct _L2_PACKET {
    L2_HEADER l2Header;
    UInt8 l2Payload[0];
} L2_PACKET;

typedef enum _CMD_ID {
    CMD_UPDATE = 0x01,
    CMD_SETTING = 0x02,
    CMD_BOND_REG = 0x03,
    CMD_NOTIFY = 0x04,
    CMD_SPORTS = 0x05,
    CMD_FACTORY = 0x06,
    CMD_CTRL = 0x07,
    CMD_DUMP = 0x08,
    CMD_FLASH = 0x09,
    CMD_LOG = 0x0a,
} CMD_ID;

@interface JWBleProtocolMethod ()

@property (nonatomic, strong) NSMutableData *nData;

@end

@implementation JWBleProtocolMethod

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nData = [[NSMutableData alloc]init];
    }
    return self;
}

#pragma mark public
- (void)wBLoginWithID:(UInt8 *)loginID isBond:(BOOL)bBond {
    
//    bBond
    if (bBond) {
        NSLog(@"bBond with ID: %s", loginID);
    } else {
        NSLog(@"login with ID: %s", loginID);
    }

    UInt8 key = bBond ? 0x01 : 0x03;
    UInt8 *l1p = [self wbMakeTxL1Packet:L2_HEADER_SIZE + L2_PAYLOAD_HEADER_SIZE + 32 andCmd:0x03 andKey:key andL2PayloadLength:32 andPayload:(UInt8 *) loginID];
    [self wBSendL1Data:l1p andLength:L1_PACKET_PRE_SIZE + 32];

    free(l1p);
}

- (void)analysisNotifyData:(NSData *)data {
    if (NULL == data) {
        return;
    }
    
    NSLog(@"<-------\t%@",data);
    
    int noAckFlag = 0;
    NSData *topData1 = [data subdataWithRange:NSMakeRange(0, 2)];
    NSData *topData2 = [data subdataWithRange:NSMakeRange(1, 1)];
    int value = [self data2Int:topData2];
    noAckFlag = (value >> 6) & 0x01;
//    NSLog(@"topData1: %@ \t topData2: %@ \t noAckFlag: %d", topData1, topData2, noAckFlag);
    
    UInt8 *respData = (UInt8 *)data.bytes;
    NSInteger length = data.length;
    
    if (length < L1_HEADER_SIZE) {
        NSLog(@"CHECK L1 HEADER FAIL");
        return;
    }
    
    L1_HEADER *l1Hdr = (L1_HEADER *)respData;
    if (CFByteOrderGetCurrent() == CFByteOrderLittleEndian) {
        l1Hdr->seqID = CFSwapInt16BigToHost(l1Hdr->seqID);
        l1Hdr->crc16 = CFSwapInt16BigToHost(l1Hdr->crc16);
        l1Hdr->payloaddLength = CFSwapInt16BigToHost(l1Hdr->payloaddLength);
        UInt8 protocolVersion = ((UInt8 *)l1Hdr)[L1_HEADER_PROTOCOL_VERSION_POS];
        l1Hdr->errFlag = (protocolVersion >> 5) & 0x1;
        l1Hdr->ackFlag = (protocolVersion >> 4) & 0x1;
        l1Hdr->version = protocolVersion & 0xf;
    }
    
    if (l1Hdr->errFlag == 0 && l1Hdr->ackFlag == 0) //DATA Packet
    {
        [self wbSendSucAckData:l1Hdr->seqID];
    }
    
    [self.nData appendBytes:respData length:length];
    
    int len = (int)[self.nData length] - L1_HEADER_SIZE;
    UInt8 *l2Packet = malloc(len);
    [self.nData getBytes:l2Packet range:NSMakeRange(L1_HEADER_SIZE, len)];
    
    UInt16 crc16 =  [self bd_crc16:0 andByte:l2Packet andLength:len];
    if (CFByteOrderGetCurrent() == CFByteOrderLittleEndian) {
        crc16 = CFSwapInt16BigToHost(crc16);
    }
    L2_HEADER *l2h = (L2_HEADER *)l2Packet;
    NSLog(@"l2h->cmdID : %d",l2h->cmdID);
//    [self parseL2:l2h length:len];
    [self.nData setLength:0];
}

#pragma mark help
- (void)parseL2:(L2_HEADER *)l2Packet length:(int)length {
    NSLog(@"l2h->cmdID : %d",l2Packet->cmdID);
    
    NSData *contentData = [self getContentDataByl2Packet:l2Packet andLength:length];
    NSLog(@"l2h->cmdID : %d",l2Packet->cmdID);
}

- (void)wbSendSucAckData:(UInt16)seqID {
    NSLog(@"wbSendSucAckData : %d",seqID+1);
    
    UInt8 l1Packet[8] = {0xAB, 0x10, 00, 00, 00, 00, (seqID >> 8) & 0XFF, seqID & 0XFF};
    NSData *data = [[NSData alloc] initWithBytes:l1Packet length:8];
    [self wBSendL1Data:data];
}

- (void)wBSendL1Data:(Byte *)writeData andLength:(int)length {
    NSData *txData = [[NSData alloc] initWithBytes:writeData length:length];
    [self wBSendL1Data:txData];
}

- (void)wBSendL1Data:(NSData *)data {
    if (self.writeCharacteristic) {
        NSLog(@"------->\t%@",data);
        [self.peripheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

- (UInt8 *)wbMakeTxL1Packet:(UInt16)l1PayloadLength andCmd:(UInt8)cmd andKey:(UInt8)key andL2PayloadLength:(UInt16)l2PayloadLength andPayload:(UInt8 *)payload {
    if (l1PayloadLength < 0 || (l1PayloadLength > 0 && l1PayloadLength != L2_HEADER_SIZE + L2_PAYLOAD_HEADER_SIZE + l2PayloadLength)) {
        return NULL;
    }

    uint16_t seqId = 0; //txSequenceID;

    UInt8 *l1Packet = malloc(L1_HEADER_SIZE + l1PayloadLength);

    l1Packet[L1_HEADER_MAGIC_POS] = L1_HEADER_MAGIC;
    l1Packet[L1_HEADER_PROTOCOL_VERSION_POS] = 0;
    l1Packet[L1_PAYLOAD_LENGTH_HIGH_BYTE_POS] = (l1PayloadLength >> 8) & 0XFF;
    l1Packet[L1_PAYLOAD_LENGTH_LOW_BYTE_POS] = l1PayloadLength & 0XFF;

    l1Packet[L1_HEADER_SEQ_ID_HIGH_BYTE_POS] = (seqId >> 8) & 0XFF;
    l1Packet[L1_HEADER_SEQ_ID_LOW_BYTE_POS] = seqId & 0XFF;

    if (l1PayloadLength == 0) {
        l1Packet[L1_HEADER_CRC16_HIGH_BYTE_POS] = 0;
        l1Packet[L1_HEADER_CRC16_LOW_BYTE_POS] = 0;
    } else {
        //    UInt8 *l1Payload = malloc(l1PayloadLength);
        l1Packet[L1_HEADER_SIZE] = cmd;
        l1Packet[L1_HEADER_SIZE + 1] = 0; //version+reversion<<4
        l1Packet[L1_HEADER_SIZE + L2_HEADER_SIZE] = key;
        l1Packet[L1_HEADER_SIZE + L2_HEADER_SIZE + 1] = (l2PayloadLength >> 8) & 0x1;
        l1Packet[L1_HEADER_SIZE + L2_HEADER_SIZE + 2] = l2PayloadLength & 0xFF;
        if (l2PayloadLength > 0) {
            memcpy(l1Packet + L1_PACKET_PRE_SIZE, payload, l2PayloadLength);
        }

        UInt16 crc16 = [self bd_crc16:0 andByte:l1Packet + L1_HEADER_SIZE andLength:l1PayloadLength];
        l1Packet[L1_HEADER_CRC16_HIGH_BYTE_POS] = (crc16 >> 8) & 0xff;
        l1Packet[L1_HEADER_CRC16_LOW_BYTE_POS] = crc16 & 0xff;
    }

    return l1Packet;
}

/**
 * crc16 - compute the CRC-16 for the data buffer
 * @crc: previous CRC value
 * @buffer: data pointer
 * @len: number of bytes in the buffer
 *
 * Returns the updated CRC value.
 */
- (UInt16)bd_crc16:(uint16_t)crc andByte:(uint8_t *)buffer andLength:(uint16_t)len {
    while (len--) {
        crc = (crc >> 8) ^ crc16_table2[(crc ^ *buffer++) & 0xff];
    }
    return crc;
}

- (int)data2Int:(NSData *)data {
    NSMutableString *hexString = [[NSMutableString alloc] init];
    const Byte *bytes = data.bytes;
    for (NSUInteger i=0; i<data.length; i++) {
        Byte value = bytes[i];
        Byte high = (value & 0xf0) >> 4;
        Byte low = value & 0xf;
        [hexString appendFormat:@"%x%x", high, low];
    }
    int i = strtoul(hexString.UTF8String, 0, 16);
    return i;
}

- (NSData *)int2Data:(int)value {
    return [NSData dataWithBytes:&value length:1];
}

- (NSData *)getContentDataByl2Packet:(Byte *)byte andLength:(int)length {
    NSData *temphead = [[NSData alloc]initWithBytes:byte length:length-2];
    NSData *dataLengData = [temphead subdataWithRange:NSMakeRange(1, 2)];
    int contentDataLength = temphead.length - 3;
    NSData *contentData = [temphead subdataWithRange:NSMakeRange(3, contentDataLength)];
    return contentData;
}


@end
