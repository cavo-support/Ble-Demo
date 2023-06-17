package com.wosmart.sdkdemo.util.v7_gt7d.utils.ota;


public class ImgHeadUtil {

    private static byte[] uuid = new byte[]{0x6d, 0x67, (byte) 0xde, (byte) 0xf1, 0x3e, 0x33, (byte) 0xe8, 0x11, (byte) 0xb1, 0x02, 0x4d, 0x2d, (byte) 0xf4, 0x0c, (byte) 0xde, 0x01};
    private static byte[] uuid1 = new byte[]{0x1d, 0x6A, (byte) 0x69, (byte) 0xf1, 0x2f, 0x38, (byte) 0xeA, 0x11, (byte) 0x82, (byte) 0xA7, 0x67, 0x37, (byte) 0x0A, 0x3c, (byte) 0xA3, 0x2e};

    /**
     * CRC16 编码
     *
     * @param bytes 编码内容
     * @return 编码结果
     */
    public static int crc16(byte[] bytes) {
        int wCRCin = 0x0000;
        int wCPoly = 0x8408;
        for (byte b : bytes) {
            wCRCin ^= ((int) b & 0x00ff);
            for (int j = 0; j < 8; j++) {
                if ((wCRCin & 0x0001) != 0) {
                    wCRCin >>= 1;
                    wCRCin ^= wCPoly;
                } else {
                    wCRCin >>= 1;
                }
            }
        }
        return wCRCin ^= 0x0000;
    }

    public static byte[] getImgHeader(byte[] originData) {
        int len = 1024;
        byte[] data = new byte[len];

        for (int i = 0; i < len; i++) {
            data[i] = (byte) 0xff;
        }

        data[0] = 0x05;
        data[1] = 0x00;
        data[2] = 0x70;
        data[3] = (byte) 0xFD;
        data[4] = (byte) 0xFE;
        data[5] = (byte) 0xFF;

        int crc16 = crc16(originData);
        data[6] = (byte) (crc16 & 0xFF);
        data[7] = (byte) ((crc16 & 0xFF) >> 8);


        int originLen = originData.length;
        data[8] = (byte) (originLen & 0xFF);
        data[9] = (byte) ((originLen >> 8) & 0xFF);
        data[10] = (byte) ((originLen >> 16) & 0xFF);
        data[11] = (byte) ((originLen >> 24) & 0xFF);
//        data[8] = (byte) 0x88;
//        data[9] = (byte) 0xb9;
//        data[10] = (byte) 0x02;
//        data[11] = (byte) 0x00;

        System.arraycopy(uuid, 0, data, 12, uuid.length);

        return data;
    }

    public static byte[] getMpHeader(byte[] originData) {
        int len = 512;
        byte[] data = new byte[len];

        for (int i = 0; i < len; i++) {
            data[i] = 0x00;
        }

        // bin
        data[0] = 0x01;
        data[1] = 0x00;
        data[2] = 0x02;
        data[3] = 0x02;
        data[4] = 0x09;

        //version
        data[5] = 0x02;
        data[6] = 0x00;
        data[7] = 0x04;
        data[8] = 0x00;
        data[9] = 0x00;
        data[10] = 0x00;
        data[11] = 0x00;

        //part number
        data[12] = 0x03;
        data[13] = 0x00;
        data[14] = 0x20;
        data[15] = 0x00;
        for (int i = 0; i < 31; i++) {
            data[16 + i] = (byte) 0xFF;
        }

        //origin data length
        data[47] = 0x04;
        data[48] = 0x00;
        data[49] = 0x04;
        int fullLength = originData.length + 1024;
        data[50] = (byte) (fullLength & 0xFF);
        data[51] = (byte) ((fullLength >> 8) & 0xFF);
        data[52] = (byte) ((fullLength >> 16) & 0xFF);
        data[53] = (byte) ((fullLength >> 24) & 0xFF);
//        data[50] = (byte) 0x44;
//        data[51] = (byte) 0x18;
//        data[52] = (byte) 0x0B;
//        data[53] = (byte) 0x00;

        // ota version
        data[54] = 0x11;
        data[55] = 0x00;
        data[56] = 0x01;
        data[57] = 0x01;

        //image id
        data[58] = 0x12;
        data[59] = 0x00;
        data[60] = 0x02;
        data[61] = (byte) 0xFE;
        data[62] = (byte) 0xFF;

        //full image size
        data[63] = 0x14;
        data[64] = 0x00;
        data[65] = 0x04;

        int originLen = originData.length + 1024;
        data[66] = (byte) (originLen & 0xFF);
        data[67] = (byte) ((originLen >> 8) & 0xFF);
        data[68] = (byte) ((originLen >> 16) & 0xFF);
        data[69] = (byte) ((originLen >> 24) & 0xFF);

//        data[66] = (byte) 0x88;
//        data[67] = (byte) 0xbd;
//        data[68] = (byte) 0x02;
//        data[69] = (byte) 0x00;

        //secure version
        data[70] = 0x15;
        data[71] = 0x00;
        data[72] = 0x01;
        data[73] = 0x00;

        //image version
        data[74] = 0x16;
        data[75] = 0x00;
        data[76] = 0x04;
        data[77] = 0x00;
        data[78] = 0x00;
        data[79] = 0x00;
        data[80] = 0x00;

        return data;
    }

    public static byte[] getImgHeaderToVD(byte[] originData) {
        int len = 1024;
        byte[] data = new byte[len];

        for (int i = 0; i < len; i++) {
            data[i] = (byte) 0xff;
        }

        data[0] = 0x09;
        data[1] = 0x00;
        data[2] = 0x70;
        data[3] = (byte) 0xFD;
        data[4] = (byte) 0xFE;
        data[5] = (byte) 0xFF;

        data[6] = 0x00;
        data[7] = 0x00;

        int originLen = originData.length;
        data[8] = (byte) (originLen & 0xFF);
        data[9] = (byte) ((originLen >> 8) & 0xFF);
        data[10] = (byte) ((originLen >> 16) & 0xFF);
        data[11] = (byte) ((originLen >> 24) & 0xFF);

        System.arraycopy(uuid1, 0, data, 12, uuid1.length);
        for (int i = 0; i < 68; i++) {
            data[28+i] = (byte) 0xFF;
        }
        data[96] = 0x00;
        data[97] = 0x00;
        data[98] = 0x00;
        data[99] = 0x10;
        return data;
    }

    public static byte[] getMpHeaderToVD(byte[] originData) {
        int len = 512;
        byte[] data = new byte[len];

        for (int i = 0; i < len; i++) {
            data[i] = 0x00;
        }

        // bin
        data[0] = 0x01;
        data[1] = 0x00;
        data[2] = 0x02;
        data[3] = 0x01;
        data[4] = 0x09;

        //version
        data[5] = 0x02;
        data[6] = 0x00;
        data[7] = 0x04;
        data[8] = 0x00;
        data[9] = 0x00;
        data[10] = 0x00;
        data[11] = 0x10;

        //part number
        data[12] = 0x03;
        data[13] = 0x00;
        data[14] = 0x20;
        data[15] = 0x00;
        for (int i = 0; i < 31; i++) {
            data[16 + i] = (byte) 0xFF;
        }

        //origin data length
        data[47] = 0x04;
        data[48] = 0x00;
        data[49] = 0x04;
        int fullLength = originData.length + 1024;
        data[50] = (byte) (fullLength & 0xFF);
        data[51] = (byte) ((fullLength >> 8) & 0xFF);
        data[52] = (byte) ((fullLength >> 16) & 0xFF);
        data[53] = (byte) ((fullLength >> 24) & 0xFF);

        // ota version
        data[54] = 0x11;
        data[55] = 0x00;
        data[56] = 0x01;
        data[57] = 0x01;

        //image id
        data[58] = 0x12;
        data[59] = 0x00;
        data[60] = 0x02;
        data[61] = (byte) 0xFE;
        data[62] = (byte) 0xFF;

        //full image size
        data[63] = 0x14;
        data[64] = 0x00;
        data[65] = 0x04;

        int originLen = originData.length + 1024;
        data[66] = (byte) (originLen & 0xFF);
        data[67] = (byte) ((originLen >> 8) & 0xFF);
        data[68] = (byte) ((originLen >> 16) & 0xFF);
        data[69] = (byte) ((originLen >> 24) & 0xFF);

        //secure version
        data[70] = 0x15;
        data[71] = 0x00;
        data[72] = 0x01;
        data[73] = 0x00;

        //image version
        data[74] = 0x16;
        data[75] = 0x00;
        data[76] = 0x04;
        data[77] = 0x00;
        data[78] = 0x00;
        data[79] = 0x00;
        data[80] = 0x10;
        data[81] = 0x22;
        data[82] = 0x00;
        data[83] = 0x01;
        data[84] = 0x02;

        return data;
    }


}
