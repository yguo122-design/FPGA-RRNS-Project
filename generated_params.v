// --- 自动生成的参数和Case语句 ---
// --- 共 84 组组合 ---
`define COMB_COUNT 84

// --- 1. CRT 常量定义 (复制到这里) ---
    localparam [19:0] MI1_0 = 4095;
    localparam [19:0] MI2_0 = 4160;
    localparam [19:0] MI3_0 = 4032;
    localparam [19:0] INV1_0 = 63;
    localparam [19:0] INV2_0 = 32;
    localparam [19:0] INV3_0 = 33;
    localparam [6:0] M1_0 = 64;
    localparam [6:0] M2_0 = 63;
    localparam [6:0] M3_0 = 65;
    localparam [3:0] IDX1_0 = 0;
    localparam [3:0] IDX2_0 = 1;
    localparam [3:0] IDX3_0 = 2;

    localparam [19:0] MI1_1 = 1953;
    localparam [19:0] MI2_1 = 1984;
    localparam [19:0] MI3_1 = 4032;
    localparam [19:0] INV1_1 = 33;
    localparam [19:0] INV2_1 = 61;
    localparam [19:0] INV3_1 = 16;
    localparam [6:0] M1_1 = 64;
    localparam [6:0] M2_1 = 63;
    localparam [6:0] M3_1 = 31;
    localparam [3:0] IDX1_1 = 0;
    localparam [3:0] IDX2_1 = 1;
    localparam [3:0] IDX3_1 = 3;

    localparam [19:0] MI1_2 = 1827;
    localparam [19:0] MI2_2 = 1856;
    localparam [19:0] MI3_2 = 4032;
    localparam [19:0] INV1_2 = 11;
    localparam [19:0] INV2_2 = 50;
    localparam [19:0] INV3_2 = 1;
    localparam [6:0] M1_2 = 64;
    localparam [6:0] M2_2 = 63;
    localparam [6:0] M3_2 = 29;
    localparam [3:0] IDX1_2 = 0;
    localparam [3:0] IDX2_2 = 1;
    localparam [3:0] IDX3_2 = 4;

    localparam [19:0] MI1_3 = 1449;
    localparam [19:0] MI2_3 = 1472;
    localparam [19:0] MI3_3 = 4032;
    localparam [19:0] INV1_3 = 25;
    localparam [19:0] INV2_3 = 11;
    localparam [19:0] INV3_3 = 10;
    localparam [6:0] M1_3 = 64;
    localparam [6:0] M2_3 = 63;
    localparam [6:0] M3_3 = 23;
    localparam [3:0] IDX1_3 = 0;
    localparam [3:0] IDX2_3 = 1;
    localparam [3:0] IDX3_3 = 5;

    localparam [19:0] MI1_4 = 1197;
    localparam [19:0] MI2_4 = 1216;
    localparam [19:0] MI3_4 = 4032;
    localparam [19:0] INV1_4 = 37;
    localparam [19:0] INV2_4 = 10;
    localparam [19:0] INV3_4 = 5;
    localparam [6:0] M1_4 = 64;
    localparam [6:0] M2_4 = 63;
    localparam [6:0] M3_4 = 19;
    localparam [3:0] IDX1_4 = 0;
    localparam [3:0] IDX2_4 = 1;
    localparam [3:0] IDX3_4 = 6;

    localparam [19:0] MI1_5 = 1071;
    localparam [19:0] MI2_5 = 1088;
    localparam [19:0] MI3_5 = 4032;
    localparam [19:0] INV1_5 = 15;
    localparam [19:0] INV2_5 = 26;
    localparam [19:0] INV3_5 = 6;
    localparam [6:0] M1_5 = 64;
    localparam [6:0] M2_5 = 63;
    localparam [6:0] M3_5 = 17;
    localparam [3:0] IDX1_5 = 0;
    localparam [3:0] IDX2_5 = 1;
    localparam [3:0] IDX3_5 = 7;

    localparam [19:0] MI1_6 = 693;
    localparam [19:0] MI2_6 = 704;
    localparam [19:0] MI3_6 = 4032;
    localparam [19:0] INV1_6 = 29;
    localparam [19:0] INV2_6 = 23;
    localparam [19:0] INV3_6 = 2;
    localparam [6:0] M1_6 = 64;
    localparam [6:0] M2_6 = 63;
    localparam [6:0] M3_6 = 11;
    localparam [3:0] IDX1_6 = 0;
    localparam [3:0] IDX2_6 = 1;
    localparam [3:0] IDX3_6 = 8;

    localparam [19:0] MI1_7 = 2015;
    localparam [19:0] MI2_7 = 1984;
    localparam [19:0] MI3_7 = 4160;
    localparam [19:0] INV1_7 = 31;
    localparam [19:0] INV2_7 = 44;
    localparam [19:0] INV3_7 = 26;
    localparam [6:0] M1_7 = 64;
    localparam [6:0] M2_7 = 65;
    localparam [6:0] M3_7 = 31;
    localparam [3:0] IDX1_7 = 0;
    localparam [3:0] IDX2_7 = 2;
    localparam [3:0] IDX3_7 = 3;

    localparam [19:0] MI1_8 = 1885;
    localparam [19:0] MI2_8 = 1856;
    localparam [19:0] MI3_8 = 4160;
    localparam [19:0] INV1_8 = 53;
    localparam [19:0] INV2_8 = 56;
    localparam [19:0] INV3_8 = 9;
    localparam [6:0] M1_8 = 64;
    localparam [6:0] M2_8 = 65;
    localparam [6:0] M3_8 = 29;
    localparam [3:0] IDX1_8 = 0;
    localparam [3:0] IDX2_8 = 2;
    localparam [3:0] IDX3_8 = 4;

    localparam [19:0] MI1_9 = 1495;
    localparam [19:0] MI2_9 = 1472;
    localparam [19:0] MI3_9 = 4160;
    localparam [19:0] INV1_9 = 39;
    localparam [19:0] INV2_9 = 48;
    localparam [19:0] INV3_9 = 15;
    localparam [6:0] M1_9 = 64;
    localparam [6:0] M2_9 = 65;
    localparam [6:0] M3_9 = 23;
    localparam [3:0] IDX1_9 = 0;
    localparam [3:0] IDX2_9 = 2;
    localparam [3:0] IDX3_9 = 5;

    localparam [19:0] MI1_10 = 1235;
    localparam [19:0] MI2_10 = 1216;
    localparam [19:0] MI3_10 = 4160;
    localparam [19:0] INV1_10 = 27;
    localparam [19:0] INV2_10 = 41;
    localparam [19:0] INV3_10 = 18;
    localparam [6:0] M1_10 = 64;
    localparam [6:0] M2_10 = 65;
    localparam [6:0] M3_10 = 19;
    localparam [3:0] IDX1_10 = 0;
    localparam [3:0] IDX2_10 = 2;
    localparam [3:0] IDX3_10 = 6;

    localparam [19:0] MI1_11 = 1105;
    localparam [19:0] MI2_11 = 1088;
    localparam [19:0] MI3_11 = 4160;
    localparam [19:0] INV1_11 = 49;
    localparam [19:0] INV2_11 = 42;
    localparam [19:0] INV3_11 = 10;
    localparam [6:0] M1_11 = 64;
    localparam [6:0] M2_11 = 65;
    localparam [6:0] M3_11 = 17;
    localparam [3:0] IDX1_11 = 0;
    localparam [3:0] IDX2_11 = 2;
    localparam [3:0] IDX3_11 = 7;

    localparam [19:0] MI1_12 = 715;
    localparam [19:0] MI2_12 = 704;
    localparam [19:0] MI3_12 = 4160;
    localparam [19:0] INV1_12 = 35;
    localparam [19:0] INV2_12 = 59;
    localparam [19:0] INV3_12 = 6;
    localparam [6:0] M1_12 = 64;
    localparam [6:0] M2_12 = 65;
    localparam [6:0] M3_12 = 11;
    localparam [3:0] IDX1_12 = 0;
    localparam [3:0] IDX2_12 = 2;
    localparam [3:0] IDX3_12 = 8;

    localparam [19:0] MI1_13 = 899;
    localparam [19:0] MI2_13 = 1856;
    localparam [19:0] MI3_13 = 1984;
    localparam [19:0] INV1_13 = 43;
    localparam [19:0] INV2_13 = 23;
    localparam [19:0] INV3_13 = 17;
    localparam [6:0] M1_13 = 64;
    localparam [6:0] M2_13 = 31;
    localparam [6:0] M3_13 = 29;
    localparam [3:0] IDX1_13 = 0;
    localparam [3:0] IDX2_13 = 3;
    localparam [3:0] IDX3_13 = 4;

    localparam [19:0] MI1_14 = 713;
    localparam [19:0] MI2_14 = 1472;
    localparam [19:0] MI3_14 = 1984;
    localparam [19:0] INV1_14 = 57;
    localparam [19:0] INV2_14 = 29;
    localparam [19:0] INV3_14 = 4;
    localparam [6:0] M1_14 = 64;
    localparam [6:0] M2_14 = 31;
    localparam [6:0] M3_14 = 23;
    localparam [3:0] IDX1_14 = 0;
    localparam [3:0] IDX2_14 = 3;
    localparam [3:0] IDX3_14 = 5;

    localparam [19:0] MI1_15 = 589;
    localparam [19:0] MI2_15 = 1216;
    localparam [19:0] MI3_15 = 1984;
    localparam [19:0] INV1_15 = 5;
    localparam [19:0] INV2_15 = 9;
    localparam [19:0] INV3_15 = 12;
    localparam [6:0] M1_15 = 64;
    localparam [6:0] M2_15 = 31;
    localparam [6:0] M3_15 = 19;
    localparam [3:0] IDX1_15 = 0;
    localparam [3:0] IDX2_15 = 3;
    localparam [3:0] IDX3_15 = 6;

    localparam [19:0] MI1_16 = 527;
    localparam [19:0] MI2_16 = 1088;
    localparam [19:0] MI3_16 = 1984;
    localparam [19:0] INV1_16 = 47;
    localparam [19:0] INV2_16 = 21;
    localparam [19:0] INV3_16 = 10;
    localparam [6:0] M1_16 = 64;
    localparam [6:0] M2_16 = 31;
    localparam [6:0] M3_16 = 17;
    localparam [3:0] IDX1_16 = 0;
    localparam [3:0] IDX2_16 = 3;
    localparam [3:0] IDX3_16 = 7;

    localparam [19:0] MI1_17 = 341;
    localparam [19:0] MI2_17 = 704;
    localparam [19:0] MI3_17 = 1984;
    localparam [19:0] INV1_17 = 61;
    localparam [19:0] INV2_17 = 24;
    localparam [19:0] INV3_17 = 3;
    localparam [6:0] M1_17 = 64;
    localparam [6:0] M2_17 = 31;
    localparam [6:0] M3_17 = 11;
    localparam [3:0] IDX1_17 = 0;
    localparam [3:0] IDX2_17 = 3;
    localparam [3:0] IDX3_17 = 8;

    localparam [19:0] MI1_18 = 667;
    localparam [19:0] MI2_18 = 1472;
    localparam [19:0] MI3_18 = 1856;
    localparam [19:0] INV1_18 = 19;
    localparam [19:0] INV2_18 = 4;
    localparam [19:0] INV3_18 = 13;
    localparam [6:0] M1_18 = 64;
    localparam [6:0] M2_18 = 29;
    localparam [6:0] M3_18 = 23;
    localparam [3:0] IDX1_18 = 0;
    localparam [3:0] IDX2_18 = 4;
    localparam [3:0] IDX3_18 = 5;

    localparam [19:0] MI1_19 = 551;
    localparam [19:0] MI2_19 = 1216;
    localparam [19:0] MI3_19 = 1856;
    localparam [19:0] INV1_19 = 23;
    localparam [19:0] INV2_19 = 14;
    localparam [19:0] INV3_19 = 3;
    localparam [6:0] M1_19 = 64;
    localparam [6:0] M2_19 = 29;
    localparam [6:0] M3_19 = 19;
    localparam [3:0] IDX1_19 = 0;
    localparam [3:0] IDX2_19 = 4;
    localparam [3:0] IDX3_19 = 6;

    localparam [19:0] MI1_20 = 493;
    localparam [19:0] MI2_20 = 1088;
    localparam [19:0] MI3_20 = 1856;
    localparam [19:0] INV1_20 = 37;
    localparam [19:0] INV2_20 = 2;
    localparam [19:0] INV3_20 = 6;
    localparam [6:0] M1_20 = 64;
    localparam [6:0] M2_20 = 29;
    localparam [6:0] M3_20 = 17;
    localparam [3:0] IDX1_20 = 0;
    localparam [3:0] IDX2_20 = 4;
    localparam [3:0] IDX3_20 = 7;

    localparam [19:0] MI1_21 = 319;
    localparam [19:0] MI2_21 = 704;
    localparam [19:0] MI3_21 = 1856;
    localparam [19:0] INV1_21 = 63;
    localparam [19:0] INV2_21 = 11;
    localparam [19:0] INV3_21 = 7;
    localparam [6:0] M1_21 = 64;
    localparam [6:0] M2_21 = 29;
    localparam [6:0] M3_21 = 11;
    localparam [3:0] IDX1_21 = 0;
    localparam [3:0] IDX2_21 = 4;
    localparam [3:0] IDX3_21 = 8;

    localparam [19:0] MI1_22 = 437;
    localparam [19:0] MI2_22 = 1216;
    localparam [19:0] MI3_22 = 1472;
    localparam [19:0] INV1_22 = 29;
    localparam [19:0] INV2_22 = 15;
    localparam [19:0] INV3_22 = 17;
    localparam [6:0] M1_22 = 64;
    localparam [6:0] M2_22 = 23;
    localparam [6:0] M3_22 = 19;
    localparam [3:0] IDX1_22 = 0;
    localparam [3:0] IDX2_22 = 5;
    localparam [3:0] IDX3_22 = 6;

    localparam [19:0] MI1_23 = 391;
    localparam [19:0] MI2_23 = 1088;
    localparam [19:0] MI3_23 = 1472;
    localparam [19:0] INV1_23 = 55;
    localparam [19:0] INV2_23 = 10;
    localparam [19:0] INV3_23 = 12;
    localparam [6:0] M1_23 = 64;
    localparam [6:0] M2_23 = 23;
    localparam [6:0] M3_23 = 17;
    localparam [3:0] IDX1_23 = 0;
    localparam [3:0] IDX2_23 = 5;
    localparam [3:0] IDX3_23 = 7;

    localparam [19:0] MI1_24 = 253;
    localparam [19:0] MI2_24 = 704;
    localparam [19:0] MI3_24 = 1472;
    localparam [19:0] INV1_24 = 21;
    localparam [19:0] INV2_24 = 5;
    localparam [19:0] INV3_24 = 5;
    localparam [6:0] M1_24 = 64;
    localparam [6:0] M2_24 = 23;
    localparam [6:0] M3_24 = 11;
    localparam [3:0] IDX1_24 = 0;
    localparam [3:0] IDX2_24 = 5;
    localparam [3:0] IDX3_24 = 8;

    localparam [19:0] MI1_25 = 323;
    localparam [19:0] MI2_25 = 1088;
    localparam [19:0] MI3_25 = 1216;
    localparam [19:0] INV1_25 = 43;
    localparam [19:0] INV2_25 = 4;
    localparam [19:0] INV3_25 = 2;
    localparam [6:0] M1_25 = 64;
    localparam [6:0] M2_25 = 19;
    localparam [6:0] M3_25 = 17;
    localparam [3:0] IDX1_25 = 0;
    localparam [3:0] IDX2_25 = 6;
    localparam [3:0] IDX3_25 = 7;

    localparam [19:0] MI1_26 = 209;
    localparam [19:0] MI2_26 = 704;
    localparam [19:0] MI3_26 = 1216;
    localparam [19:0] INV1_26 = 49;
    localparam [19:0] INV2_26 = 1;
    localparam [19:0] INV3_26 = 2;
    localparam [6:0] M1_26 = 64;
    localparam [6:0] M2_26 = 19;
    localparam [6:0] M3_26 = 11;
    localparam [3:0] IDX1_26 = 0;
    localparam [3:0] IDX2_26 = 6;
    localparam [3:0] IDX3_26 = 8;

    localparam [19:0] MI1_27 = 187;
    localparam [19:0] MI2_27 = 704;
    localparam [19:0] MI3_27 = 1088;
    localparam [19:0] INV1_27 = 51;
    localparam [19:0] INV2_27 = 5;
    localparam [19:0] INV3_27 = 10;
    localparam [6:0] M1_27 = 64;
    localparam [6:0] M2_27 = 17;
    localparam [6:0] M3_27 = 11;
    localparam [3:0] IDX1_27 = 0;
    localparam [3:0] IDX2_27 = 7;
    localparam [3:0] IDX3_27 = 8;

    localparam [19:0] MI1_28 = 2015;
    localparam [19:0] MI2_28 = 1953;
    localparam [19:0] MI3_28 = 4095;
    localparam [19:0] INV1_28 = 62;
    localparam [19:0] INV2_28 = 22;
    localparam [19:0] INV3_28 = 21;
    localparam [6:0] M1_28 = 63;
    localparam [6:0] M2_28 = 65;
    localparam [6:0] M3_28 = 31;
    localparam [3:0] IDX1_28 = 1;
    localparam [3:0] IDX2_28 = 2;
    localparam [3:0] IDX3_28 = 3;

    localparam [19:0] MI1_29 = 1885;
    localparam [19:0] MI2_29 = 1827;
    localparam [19:0] MI3_29 = 4095;
    localparam [19:0] INV1_29 = 25;
    localparam [19:0] INV2_29 = 28;
    localparam [19:0] INV3_29 = 5;
    localparam [6:0] M1_29 = 63;
    localparam [6:0] M2_29 = 65;
    localparam [6:0] M3_29 = 29;
    localparam [3:0] IDX1_29 = 1;
    localparam [3:0] IDX2_29 = 2;
    localparam [3:0] IDX3_29 = 4;

    localparam [19:0] MI1_30 = 1495;
    localparam [19:0] MI2_30 = 1449;
    localparam [19:0] MI3_30 = 4095;
    localparam [19:0] INV1_30 = 37;
    localparam [19:0] INV2_30 = 24;
    localparam [19:0] INV3_30 = 1;
    localparam [6:0] M1_30 = 63;
    localparam [6:0] M2_30 = 65;
    localparam [6:0] M3_30 = 23;
    localparam [3:0] IDX1_30 = 1;
    localparam [3:0] IDX2_30 = 2;
    localparam [3:0] IDX3_30 = 5;

    localparam [19:0] MI1_31 = 1235;
    localparam [19:0] MI2_31 = 1197;
    localparam [19:0] MI3_31 = 4095;
    localparam [19:0] INV1_31 = 5;
    localparam [19:0] INV2_31 = 53;
    localparam [19:0] INV3_31 = 2;
    localparam [6:0] M1_31 = 63;
    localparam [6:0] M2_31 = 65;
    localparam [6:0] M3_31 = 19;
    localparam [3:0] IDX1_31 = 1;
    localparam [3:0] IDX2_31 = 2;
    localparam [3:0] IDX3_31 = 6;

    localparam [19:0] MI1_32 = 1105;
    localparam [19:0] MI2_32 = 1071;
    localparam [19:0] MI3_32 = 4095;
    localparam [19:0] INV1_32 = 13;
    localparam [19:0] INV2_32 = 21;
    localparam [19:0] INV3_32 = 8;
    localparam [6:0] M1_32 = 63;
    localparam [6:0] M2_32 = 65;
    localparam [6:0] M3_32 = 17;
    localparam [3:0] IDX1_32 = 1;
    localparam [3:0] IDX2_32 = 2;
    localparam [3:0] IDX3_32 = 7;

    localparam [19:0] MI1_33 = 715;
    localparam [19:0] MI2_33 = 693;
    localparam [19:0] MI3_33 = 4095;
    localparam [19:0] INV1_33 = 43;
    localparam [19:0] INV2_33 = 62;
    localparam [19:0] INV3_33 = 4;
    localparam [6:0] M1_33 = 63;
    localparam [6:0] M2_33 = 65;
    localparam [6:0] M3_33 = 11;
    localparam [3:0] IDX1_33 = 1;
    localparam [3:0] IDX2_33 = 2;
    localparam [3:0] IDX3_33 = 8;

    localparam [19:0] MI1_34 = 899;
    localparam [19:0] MI2_34 = 1827;
    localparam [19:0] MI3_34 = 1953;
    localparam [19:0] INV1_34 = 26;
    localparam [19:0] INV2_34 = 15;
    localparam [19:0] INV3_34 = 3;
    localparam [6:0] M1_34 = 63;
    localparam [6:0] M2_34 = 31;
    localparam [6:0] M3_34 = 29;
    localparam [3:0] IDX1_34 = 1;
    localparam [3:0] IDX2_34 = 3;
    localparam [3:0] IDX3_34 = 4;

    localparam [19:0] MI1_35 = 713;
    localparam [19:0] MI2_35 = 1449;
    localparam [19:0] MI3_35 = 1953;
    localparam [19:0] INV1_35 = 41;
    localparam [19:0] INV2_35 = 27;
    localparam [19:0] INV3_35 = 11;
    localparam [6:0] M1_35 = 63;
    localparam [6:0] M2_35 = 31;
    localparam [6:0] M3_35 = 23;
    localparam [3:0] IDX1_35 = 1;
    localparam [3:0] IDX2_35 = 3;
    localparam [3:0] IDX3_35 = 5;

    localparam [19:0] MI1_36 = 589;
    localparam [19:0] MI2_36 = 1197;
    localparam [19:0] MI3_36 = 1953;
    localparam [19:0] INV1_36 = 43;
    localparam [19:0] INV2_36 = 18;
    localparam [19:0] INV3_36 = 14;
    localparam [6:0] M1_36 = 63;
    localparam [6:0] M2_36 = 31;
    localparam [6:0] M3_36 = 19;
    localparam [3:0] IDX1_36 = 1;
    localparam [3:0] IDX2_36 = 3;
    localparam [3:0] IDX3_36 = 6;

    localparam [19:0] MI1_37 = 527;
    localparam [19:0] MI2_37 = 1071;
    localparam [19:0] MI3_37 = 1953;
    localparam [19:0] INV1_37 = 11;
    localparam [19:0] INV2_37 = 11;
    localparam [19:0] INV3_37 = 8;
    localparam [6:0] M1_37 = 63;
    localparam [6:0] M2_37 = 31;
    localparam [6:0] M3_37 = 17;
    localparam [3:0] IDX1_37 = 1;
    localparam [3:0] IDX2_37 = 3;
    localparam [3:0] IDX3_37 = 7;

    localparam [19:0] MI1_38 = 341;
    localparam [19:0] MI2_38 = 693;
    localparam [19:0] MI3_38 = 1953;
    localparam [19:0] INV1_38 = 17;
    localparam [19:0] INV2_38 = 17;
    localparam [19:0] INV3_38 = 2;
    localparam [6:0] M1_38 = 63;
    localparam [6:0] M2_38 = 31;
    localparam [6:0] M3_38 = 11;
    localparam [3:0] IDX1_38 = 1;
    localparam [3:0] IDX2_38 = 3;
    localparam [3:0] IDX3_38 = 8;

    localparam [19:0] MI1_39 = 667;
    localparam [19:0] MI2_39 = 1449;
    localparam [19:0] MI3_39 = 1827;
    localparam [19:0] INV1_39 = 46;
    localparam [19:0] INV2_39 = 28;
    localparam [19:0] INV3_39 = 7;
    localparam [6:0] M1_39 = 63;
    localparam [6:0] M2_39 = 29;
    localparam [6:0] M3_39 = 23;
    localparam [3:0] IDX1_39 = 1;
    localparam [3:0] IDX2_39 = 4;
    localparam [3:0] IDX3_39 = 5;

    localparam [19:0] MI1_40 = 551;
    localparam [19:0] MI2_40 = 1197;
    localparam [19:0] MI3_40 = 1827;
    localparam [19:0] INV1_40 = 59;
    localparam [19:0] INV2_40 = 11;
    localparam [19:0] INV3_40 = 13;
    localparam [6:0] M1_40 = 63;
    localparam [6:0] M2_40 = 29;
    localparam [6:0] M3_40 = 19;
    localparam [3:0] IDX1_40 = 1;
    localparam [3:0] IDX2_40 = 4;
    localparam [3:0] IDX3_40 = 6;

    localparam [19:0] MI1_41 = 493;
    localparam [19:0] MI2_41 = 1071;
    localparam [19:0] MI3_41 = 1827;
    localparam [19:0] INV1_41 = 40;
    localparam [19:0] INV2_41 = 14;
    localparam [19:0] INV3_41 = 15;
    localparam [6:0] M1_41 = 63;
    localparam [6:0] M2_41 = 29;
    localparam [6:0] M3_41 = 17;
    localparam [3:0] IDX1_41 = 1;
    localparam [3:0] IDX2_41 = 4;
    localparam [3:0] IDX3_41 = 7;

    localparam [19:0] MI1_42 = 319;
    localparam [19:0] MI2_42 = 693;
    localparam [19:0] MI3_42 = 1827;
    localparam [19:0] INV1_42 = 16;
    localparam [19:0] INV2_42 = 19;
    localparam [19:0] INV3_42 = 1;
    localparam [6:0] M1_42 = 63;
    localparam [6:0] M2_42 = 29;
    localparam [6:0] M3_42 = 11;
    localparam [3:0] IDX1_42 = 1;
    localparam [3:0] IDX2_42 = 4;
    localparam [3:0] IDX3_42 = 8;

    localparam [19:0] MI1_43 = 437;
    localparam [19:0] MI2_43 = 1197;
    localparam [19:0] MI3_43 = 1449;
    localparam [19:0] INV1_43 = 47;
    localparam [19:0] INV2_43 = 1;
    localparam [19:0] INV3_43 = 4;
    localparam [6:0] M1_43 = 63;
    localparam [6:0] M2_43 = 23;
    localparam [6:0] M3_43 = 19;
    localparam [3:0] IDX1_43 = 1;
    localparam [3:0] IDX2_43 = 5;
    localparam [3:0] IDX3_43 = 6;

    localparam [19:0] MI1_44 = 391;
    localparam [19:0] MI2_44 = 1071;
    localparam [19:0] MI3_44 = 1449;
    localparam [19:0] INV1_44 = 34;
    localparam [19:0] INV2_44 = 16;
    localparam [19:0] INV3_44 = 13;
    localparam [6:0] M1_44 = 63;
    localparam [6:0] M2_44 = 23;
    localparam [6:0] M3_44 = 17;
    localparam [3:0] IDX1_44 = 1;
    localparam [3:0] IDX2_44 = 5;
    localparam [3:0] IDX3_44 = 7;

    localparam [19:0] MI1_45 = 253;
    localparam [19:0] MI2_45 = 693;
    localparam [19:0] MI3_45 = 1449;
    localparam [19:0] INV1_45 = 1;
    localparam [19:0] INV2_45 = 8;
    localparam [19:0] INV3_45 = 7;
    localparam [6:0] M1_45 = 63;
    localparam [6:0] M2_45 = 23;
    localparam [6:0] M3_45 = 11;
    localparam [3:0] IDX1_45 = 1;
    localparam [3:0] IDX2_45 = 5;
    localparam [3:0] IDX3_45 = 8;

    localparam [19:0] MI1_46 = 323;
    localparam [19:0] MI2_46 = 1071;
    localparam [19:0] MI3_46 = 1197;
    localparam [19:0] INV1_46 = 8;
    localparam [19:0] INV2_46 = 11;
    localparam [19:0] INV3_46 = 5;
    localparam [6:0] M1_46 = 63;
    localparam [6:0] M2_46 = 19;
    localparam [6:0] M3_46 = 17;
    localparam [3:0] IDX1_46 = 1;
    localparam [3:0] IDX2_46 = 6;
    localparam [3:0] IDX3_46 = 7;

    localparam [19:0] MI1_47 = 209;
    localparam [19:0] MI2_47 = 693;
    localparam [19:0] MI3_47 = 1197;
    localparam [19:0] INV1_47 = 41;
    localparam [19:0] INV2_47 = 17;
    localparam [19:0] INV3_47 = 5;
    localparam [6:0] M1_47 = 63;
    localparam [6:0] M2_47 = 19;
    localparam [6:0] M3_47 = 11;
    localparam [3:0] IDX1_47 = 1;
    localparam [3:0] IDX2_47 = 6;
    localparam [3:0] IDX3_47 = 8;

    localparam [19:0] MI1_48 = 187;
    localparam [19:0] MI2_48 = 693;
    localparam [19:0] MI3_48 = 1071;
    localparam [19:0] INV1_48 = 31;
    localparam [19:0] INV2_48 = 4;
    localparam [19:0] INV3_48 = 3;
    localparam [6:0] M1_48 = 63;
    localparam [6:0] M2_48 = 17;
    localparam [6:0] M3_48 = 11;
    localparam [3:0] IDX1_48 = 1;
    localparam [3:0] IDX2_48 = 7;
    localparam [3:0] IDX3_48 = 8;

    localparam [19:0] MI1_49 = 899;
    localparam [19:0] MI2_49 = 1885;
    localparam [19:0] MI3_49 = 2015;
    localparam [19:0] INV1_49 = 59;
    localparam [19:0] INV2_49 = 5;
    localparam [19:0] INV3_49 = 27;
    localparam [6:0] M1_49 = 65;
    localparam [6:0] M2_49 = 31;
    localparam [6:0] M3_49 = 29;
    localparam [3:0] IDX1_49 = 2;
    localparam [3:0] IDX2_49 = 3;
    localparam [3:0] IDX3_49 = 4;

    localparam [19:0] MI1_50 = 713;
    localparam [19:0] MI2_50 = 1495;
    localparam [19:0] MI3_50 = 2015;
    localparam [19:0] INV1_50 = 32;
    localparam [19:0] INV2_50 = 9;
    localparam [19:0] INV3_50 = 5;
    localparam [6:0] M1_50 = 65;
    localparam [6:0] M2_50 = 31;
    localparam [6:0] M3_50 = 23;
    localparam [3:0] IDX1_50 = 2;
    localparam [3:0] IDX2_50 = 3;
    localparam [3:0] IDX3_50 = 5;

    localparam [19:0] MI1_51 = 589;
    localparam [19:0] MI2_51 = 1235;
    localparam [19:0] MI3_51 = 2015;
    localparam [19:0] INV1_51 = 49;
    localparam [19:0] INV2_51 = 6;
    localparam [19:0] INV3_51 = 1;
    localparam [6:0] M1_51 = 65;
    localparam [6:0] M2_51 = 31;
    localparam [6:0] M3_51 = 19;
    localparam [3:0] IDX1_51 = 2;
    localparam [3:0] IDX2_51 = 3;
    localparam [3:0] IDX3_51 = 6;

    localparam [19:0] MI1_52 = 527;
    localparam [19:0] MI2_52 = 1105;
    localparam [19:0] MI3_52 = 2015;
    localparam [19:0] INV1_52 = 28;
    localparam [19:0] INV2_52 = 14;
    localparam [19:0] INV3_52 = 2;
    localparam [6:0] M1_52 = 65;
    localparam [6:0] M2_52 = 31;
    localparam [6:0] M3_52 = 17;
    localparam [3:0] IDX1_52 = 2;
    localparam [3:0] IDX2_52 = 3;
    localparam [3:0] IDX3_52 = 7;

    localparam [19:0] MI1_53 = 341;
    localparam [19:0] MI2_53 = 715;
    localparam [19:0] MI3_53 = 2015;
    localparam [19:0] INV1_53 = 61;
    localparam [19:0] INV2_53 = 16;
    localparam [19:0] INV3_53 = 6;
    localparam [6:0] M1_53 = 65;
    localparam [6:0] M2_53 = 31;
    localparam [6:0] M3_53 = 11;
    localparam [3:0] IDX1_53 = 2;
    localparam [3:0] IDX2_53 = 3;
    localparam [3:0] IDX3_53 = 8;

    localparam [19:0] MI1_54 = 667;
    localparam [19:0] MI2_54 = 1495;
    localparam [19:0] MI3_54 = 1885;
    localparam [19:0] INV1_54 = 23;
    localparam [19:0] INV2_54 = 20;
    localparam [19:0] INV3_54 = 22;
    localparam [6:0] M1_54 = 65;
    localparam [6:0] M2_54 = 29;
    localparam [6:0] M3_54 = 23;
    localparam [3:0] IDX1_54 = 2;
    localparam [3:0] IDX2_54 = 4;
    localparam [3:0] IDX3_54 = 5;

    localparam [19:0] MI1_55 = 551;
    localparam [19:0] MI2_55 = 1235;
    localparam [19:0] MI3_55 = 1885;
    localparam [19:0] INV1_55 = 21;
    localparam [19:0] INV2_55 = 12;
    localparam [19:0] INV3_55 = 5;
    localparam [6:0] M1_55 = 65;
    localparam [6:0] M2_55 = 29;
    localparam [6:0] M3_55 = 19;
    localparam [3:0] IDX1_55 = 2;
    localparam [3:0] IDX2_55 = 4;
    localparam [3:0] IDX3_55 = 6;

    localparam [19:0] MI1_56 = 493;
    localparam [19:0] MI2_56 = 1105;
    localparam [19:0] MI3_56 = 1885;
    localparam [19:0] INV1_56 = 12;
    localparam [19:0] INV2_56 = 10;
    localparam [19:0] INV3_56 = 8;
    localparam [6:0] M1_56 = 65;
    localparam [6:0] M2_56 = 29;
    localparam [6:0] M3_56 = 17;
    localparam [3:0] IDX1_56 = 2;
    localparam [3:0] IDX2_56 = 4;
    localparam [3:0] IDX3_56 = 7;

    localparam [19:0] MI1_57 = 319;
    localparam [19:0] MI2_57 = 715;
    localparam [19:0] MI3_57 = 1885;
    localparam [19:0] INV1_57 = 54;
    localparam [19:0] INV2_57 = 26;
    localparam [19:0] INV3_57 = 3;
    localparam [6:0] M1_57 = 65;
    localparam [6:0] M2_57 = 29;
    localparam [6:0] M3_57 = 11;
    localparam [3:0] IDX1_57 = 2;
    localparam [3:0] IDX2_57 = 4;
    localparam [3:0] IDX3_57 = 8;

    localparam [19:0] MI1_58 = 437;
    localparam [19:0] MI2_58 = 1235;
    localparam [19:0] MI3_58 = 1495;
    localparam [19:0] INV1_58 = 18;
    localparam [19:0] INV2_58 = 13;
    localparam [19:0] INV3_58 = 3;
    localparam [6:0] M1_58 = 65;
    localparam [6:0] M2_58 = 23;
    localparam [6:0] M3_58 = 19;
    localparam [3:0] IDX1_58 = 2;
    localparam [3:0] IDX2_58 = 5;
    localparam [3:0] IDX3_58 = 6;

    localparam [19:0] MI1_59 = 391;
    localparam [19:0] MI2_59 = 1105;
    localparam [19:0] MI3_59 = 1495;
    localparam [19:0] INV1_59 = 1;
    localparam [19:0] INV2_59 = 1;
    localparam [19:0] INV3_59 = 16;
    localparam [6:0] M1_59 = 65;
    localparam [6:0] M2_59 = 23;
    localparam [6:0] M3_59 = 17;
    localparam [3:0] IDX1_59 = 2;
    localparam [3:0] IDX2_59 = 5;
    localparam [3:0] IDX3_59 = 7;

    localparam [19:0] MI1_60 = 253;
    localparam [19:0] MI2_60 = 715;
    localparam [19:0] MI3_60 = 1495;
    localparam [19:0] INV1_60 = 37;
    localparam [19:0] INV2_60 = 12;
    localparam [19:0] INV3_60 = 10;
    localparam [6:0] M1_60 = 65;
    localparam [6:0] M2_60 = 23;
    localparam [6:0] M3_60 = 11;
    localparam [3:0] IDX1_60 = 2;
    localparam [3:0] IDX2_60 = 5;
    localparam [3:0] IDX3_60 = 8;

    localparam [19:0] MI1_61 = 323;
    localparam [19:0] MI2_61 = 1105;
    localparam [19:0] MI3_61 = 1235;
    localparam [19:0] INV1_61 = 32;
    localparam [19:0] INV2_61 = 13;
    localparam [19:0] INV3_61 = 14;
    localparam [6:0] M1_61 = 65;
    localparam [6:0] M2_61 = 19;
    localparam [6:0] M3_61 = 17;
    localparam [3:0] IDX1_61 = 2;
    localparam [3:0] IDX2_61 = 6;
    localparam [3:0] IDX3_61 = 7;

    localparam [19:0] MI1_62 = 209;
    localparam [19:0] MI2_62 = 715;
    localparam [19:0] MI3_62 = 1235;
    localparam [19:0] INV1_62 = 14;
    localparam [19:0] INV2_62 = 8;
    localparam [19:0] INV3_62 = 4;
    localparam [6:0] M1_62 = 65;
    localparam [6:0] M2_62 = 19;
    localparam [6:0] M3_62 = 11;
    localparam [3:0] IDX1_62 = 2;
    localparam [3:0] IDX2_62 = 6;
    localparam [3:0] IDX3_62 = 8;

    localparam [19:0] MI1_63 = 187;
    localparam [19:0] MI2_63 = 715;
    localparam [19:0] MI3_63 = 1105;
    localparam [19:0] INV1_63 = 8;
    localparam [19:0] INV2_63 = 1;
    localparam [19:0] INV3_63 = 9;
    localparam [6:0] M1_63 = 65;
    localparam [6:0] M2_63 = 17;
    localparam [6:0] M3_63 = 11;
    localparam [3:0] IDX1_63 = 2;
    localparam [3:0] IDX2_63 = 7;
    localparam [3:0] IDX3_63 = 8;

    localparam [19:0] MI1_64 = 667;
    localparam [19:0] MI2_64 = 713;
    localparam [19:0] MI3_64 = 899;
    localparam [19:0] INV1_64 = 2;
    localparam [19:0] INV2_64 = 12;
    localparam [19:0] INV3_64 = 12;
    localparam [6:0] M1_64 = 31;
    localparam [6:0] M2_64 = 29;
    localparam [6:0] M3_64 = 23;
    localparam [3:0] IDX1_64 = 3;
    localparam [3:0] IDX2_64 = 4;
    localparam [3:0] IDX3_64 = 5;

    localparam [19:0] MI1_65 = 551;
    localparam [19:0] MI2_65 = 589;
    localparam [19:0] MI3_65 = 899;
    localparam [19:0] INV1_65 = 22;
    localparam [19:0] INV2_65 = 13;
    localparam [19:0] INV3_65 = 16;
    localparam [6:0] M1_65 = 31;
    localparam [6:0] M2_65 = 29;
    localparam [6:0] M3_65 = 19;
    localparam [3:0] IDX1_65 = 3;
    localparam [3:0] IDX2_65 = 4;
    localparam [3:0] IDX3_65 = 6;

    localparam [19:0] MI1_66 = 493;
    localparam [19:0] MI2_66 = 527;
    localparam [19:0] MI3_66 = 899;
    localparam [19:0] INV1_66 = 10;
    localparam [19:0] INV2_66 = 6;
    localparam [19:0] INV3_66 = 8;
    localparam [6:0] M1_66 = 31;
    localparam [6:0] M2_66 = 29;
    localparam [6:0] M3_66 = 17;
    localparam [3:0] IDX1_66 = 3;
    localparam [3:0] IDX2_66 = 4;
    localparam [3:0] IDX3_66 = 7;

    localparam [19:0] MI1_67 = 319;
    localparam [19:0] MI2_67 = 341;
    localparam [19:0] MI3_67 = 899;
    localparam [19:0] INV1_67 = 7;
    localparam [19:0] INV2_67 = 4;
    localparam [19:0] INV3_67 = 7;
    localparam [6:0] M1_67 = 31;
    localparam [6:0] M2_67 = 29;
    localparam [6:0] M3_67 = 11;
    localparam [3:0] IDX1_67 = 3;
    localparam [3:0] IDX2_67 = 4;
    localparam [3:0] IDX3_67 = 8;

    localparam [19:0] MI1_68 = 437;
    localparam [19:0] MI2_68 = 589;
    localparam [19:0] MI3_68 = 713;
    localparam [19:0] INV1_68 = 21;
    localparam [19:0] INV2_68 = 5;
    localparam [19:0] INV3_68 = 2;
    localparam [6:0] M1_68 = 31;
    localparam [6:0] M2_68 = 23;
    localparam [6:0] M3_68 = 19;
    localparam [3:0] IDX1_68 = 3;
    localparam [3:0] IDX2_68 = 5;
    localparam [3:0] IDX3_68 = 6;

    localparam [19:0] MI1_69 = 391;
    localparam [19:0] MI2_69 = 527;
    localparam [19:0] MI3_69 = 713;
    localparam [19:0] INV1_69 = 18;
    localparam [19:0] INV2_69 = 11;
    localparam [19:0] INV3_69 = 16;
    localparam [6:0] M1_69 = 31;
    localparam [6:0] M2_69 = 23;
    localparam [6:0] M3_69 = 17;
    localparam [3:0] IDX1_69 = 3;
    localparam [3:0] IDX2_69 = 5;
    localparam [3:0] IDX3_69 = 7;

    localparam [19:0] MI1_70 = 253;
    localparam [19:0] MI2_70 = 341;
    localparam [19:0] MI3_70 = 713;
    localparam [19:0] INV1_70 = 25;
    localparam [19:0] INV2_70 = 17;
    localparam [19:0] INV3_70 = 5;
    localparam [6:0] M1_70 = 31;
    localparam [6:0] M2_70 = 23;
    localparam [6:0] M3_70 = 11;
    localparam [3:0] IDX1_70 = 3;
    localparam [3:0] IDX2_70 = 5;
    localparam [3:0] IDX3_70 = 8;

    localparam [19:0] MI1_71 = 323;
    localparam [19:0] MI2_71 = 527;
    localparam [19:0] MI3_71 = 589;
    localparam [19:0] INV1_71 = 12;
    localparam [19:0] INV2_71 = 15;
    localparam [19:0] INV3_71 = 14;
    localparam [6:0] M1_71 = 31;
    localparam [6:0] M2_71 = 19;
    localparam [6:0] M3_71 = 17;
    localparam [3:0] IDX1_71 = 3;
    localparam [3:0] IDX2_71 = 6;
    localparam [3:0] IDX3_71 = 7;

    localparam [19:0] MI1_72 = 209;
    localparam [19:0] MI2_72 = 341;
    localparam [19:0] MI3_72 = 589;
    localparam [19:0] INV1_72 = 27;
    localparam [19:0] INV2_72 = 18;
    localparam [19:0] INV3_72 = 2;
    localparam [6:0] M1_72 = 31;
    localparam [6:0] M2_72 = 19;
    localparam [6:0] M3_72 = 11;
    localparam [3:0] IDX1_72 = 3;
    localparam [3:0] IDX2_72 = 6;
    localparam [3:0] IDX3_72 = 8;

    localparam [19:0] MI1_73 = 187;
    localparam [19:0] MI2_73 = 341;
    localparam [19:0] MI3_73 = 527;
    localparam [19:0] INV1_73 = 1;
    localparam [19:0] INV2_73 = 1;
    localparam [19:0] INV3_73 = 10;
    localparam [6:0] M1_73 = 31;
    localparam [6:0] M2_73 = 17;
    localparam [6:0] M3_73 = 11;
    localparam [3:0] IDX1_73 = 3;
    localparam [3:0] IDX2_73 = 7;
    localparam [3:0] IDX3_73 = 8;

    localparam [19:0] MI1_74 = 437;
    localparam [19:0] MI2_74 = 551;
    localparam [19:0] MI3_74 = 667;
    localparam [19:0] INV1_74 = 15;
    localparam [19:0] INV2_74 = 22;
    localparam [19:0] INV3_74 = 10;
    localparam [6:0] M1_74 = 29;
    localparam [6:0] M2_74 = 23;
    localparam [6:0] M3_74 = 19;
    localparam [3:0] IDX1_74 = 4;
    localparam [3:0] IDX2_74 = 5;
    localparam [3:0] IDX3_74 = 6;

    localparam [19:0] MI1_75 = 391;
    localparam [19:0] MI2_75 = 493;
    localparam [19:0] MI3_75 = 667;
    localparam [19:0] INV1_75 = 27;
    localparam [19:0] INV2_75 = 7;
    localparam [19:0] INV3_75 = 13;
    localparam [6:0] M1_75 = 29;
    localparam [6:0] M2_75 = 23;
    localparam [6:0] M3_75 = 17;
    localparam [3:0] IDX1_75 = 4;
    localparam [3:0] IDX2_75 = 5;
    localparam [3:0] IDX3_75 = 7;

    localparam [19:0] MI1_76 = 253;
    localparam [19:0] MI2_76 = 319;
    localparam [19:0] MI3_76 = 667;
    localparam [19:0] INV1_76 = 18;
    localparam [19:0] INV2_76 = 15;
    localparam [19:0] INV3_76 = 8;
    localparam [6:0] M1_76 = 29;
    localparam [6:0] M2_76 = 23;
    localparam [6:0] M3_76 = 11;
    localparam [3:0] IDX1_76 = 4;
    localparam [3:0] IDX2_76 = 5;
    localparam [3:0] IDX3_76 = 8;

    localparam [19:0] MI1_77 = 323;
    localparam [19:0] MI2_77 = 493;
    localparam [19:0] MI3_77 = 551;
    localparam [19:0] INV1_77 = 22;
    localparam [19:0] INV2_77 = 18;
    localparam [19:0] INV3_77 = 5;
    localparam [6:0] M1_77 = 29;
    localparam [6:0] M2_77 = 19;
    localparam [6:0] M3_77 = 17;
    localparam [3:0] IDX1_77 = 4;
    localparam [3:0] IDX2_77 = 6;
    localparam [3:0] IDX3_77 = 7;

    localparam [19:0] MI1_78 = 209;
    localparam [19:0] MI2_78 = 319;
    localparam [19:0] MI3_78 = 551;
    localparam [19:0] INV1_78 = 5;
    localparam [19:0] INV2_78 = 14;
    localparam [19:0] INV3_78 = 1;
    localparam [6:0] M1_78 = 29;
    localparam [6:0] M2_78 = 19;
    localparam [6:0] M3_78 = 11;
    localparam [3:0] IDX1_78 = 4;
    localparam [3:0] IDX2_78 = 6;
    localparam [3:0] IDX3_78 = 8;

    localparam [19:0] MI1_79 = 187;
    localparam [19:0] MI2_79 = 319;
    localparam [19:0] MI3_79 = 493;
    localparam [19:0] INV1_79 = 9;
    localparam [19:0] INV2_79 = 4;
    localparam [19:0] INV3_79 = 5;
    localparam [6:0] M1_79 = 29;
    localparam [6:0] M2_79 = 17;
    localparam [6:0] M3_79 = 11;
    localparam [3:0] IDX1_79 = 4;
    localparam [3:0] IDX2_79 = 7;
    localparam [3:0] IDX3_79 = 8;

    localparam [19:0] MI1_80 = 323;
    localparam [19:0] MI2_80 = 391;
    localparam [19:0] MI3_80 = 437;
    localparam [19:0] INV1_80 = 1;
    localparam [19:0] INV2_80 = 7;
    localparam [19:0] INV3_80 = 10;
    localparam [6:0] M1_80 = 23;
    localparam [6:0] M2_80 = 19;
    localparam [6:0] M3_80 = 17;
    localparam [3:0] IDX1_80 = 5;
    localparam [3:0] IDX2_80 = 6;
    localparam [3:0] IDX3_80 = 7;

    localparam [19:0] MI1_81 = 209;
    localparam [19:0] MI2_81 = 253;
    localparam [19:0] MI3_81 = 437;
    localparam [19:0] INV1_81 = 12;
    localparam [19:0] INV2_81 = 16;
    localparam [19:0] INV3_81 = 7;
    localparam [6:0] M1_81 = 23;
    localparam [6:0] M2_81 = 19;
    localparam [6:0] M3_81 = 11;
    localparam [3:0] IDX1_81 = 5;
    localparam [3:0] IDX2_81 = 6;
    localparam [3:0] IDX3_81 = 8;

    localparam [19:0] MI1_82 = 187;
    localparam [19:0] MI2_82 = 253;
    localparam [19:0] MI3_82 = 391;
    localparam [19:0] INV1_82 = 8;
    localparam [19:0] INV2_82 = 8;
    localparam [19:0] INV3_82 = 2;
    localparam [6:0] M1_82 = 23;
    localparam [6:0] M2_82 = 17;
    localparam [6:0] M3_82 = 11;
    localparam [3:0] IDX1_82 = 5;
    localparam [3:0] IDX2_82 = 7;
    localparam [3:0] IDX3_82 = 8;

    localparam [19:0] MI1_83 = 187;
    localparam [19:0] MI2_83 = 209;
    localparam [19:0] MI3_83 = 323;
    localparam [19:0] INV1_83 = 6;
    localparam [19:0] INV2_83 = 7;
    localparam [19:0] INV3_83 = 3;
    localparam [6:0] M1_83 = 19;
    localparam [6:0] M2_83 = 17;
    localparam [6:0] M3_83 = 11;
    localparam [3:0] IDX1_83 = 6;
    localparam [3:0] IDX2_83 = 7;
    localparam [3:0] IDX3_83 = 8;

// --- 2. Case 语句生成 (复制到这里) ---
                0: begin
                    Mi0 = MI1_0; Mi1 = MI2_0; Mi2 = MI3_0;
                    inv0 = INV1_0; inv1 = INV2_0; inv2 = INV3_0;
                    r_a = get_residue(IDX1_0);
                    r_b = get_residue(IDX2_0);
                    r_c = get_residue(IDX3_0);
                    M_total = M1_0 * M2_0 * M3_0;
                end
                1: begin
                    Mi0 = MI1_1; Mi1 = MI2_1; Mi2 = MI3_1;
                    inv0 = INV1_1; inv1 = INV2_1; inv2 = INV3_1;
                    r_a = get_residue(IDX1_1);
                    r_b = get_residue(IDX2_1);
                    r_c = get_residue(IDX3_1);
                    M_total = M1_1 * M2_1 * M3_1;
                end
                2: begin
                    Mi0 = MI1_2; Mi1 = MI2_2; Mi2 = MI3_2;
                    inv0 = INV1_2; inv1 = INV2_2; inv2 = INV3_2;
                    r_a = get_residue(IDX1_2);
                    r_b = get_residue(IDX2_2);
                    r_c = get_residue(IDX3_2);
                    M_total = M1_2 * M2_2 * M3_2;
                end
                3: begin
                    Mi0 = MI1_3; Mi1 = MI2_3; Mi2 = MI3_3;
                    inv0 = INV1_3; inv1 = INV2_3; inv2 = INV3_3;
                    r_a = get_residue(IDX1_3);
                    r_b = get_residue(IDX2_3);
                    r_c = get_residue(IDX3_3);
                    M_total = M1_3 * M2_3 * M3_3;
                end
                4: begin
                    Mi0 = MI1_4; Mi1 = MI2_4; Mi2 = MI3_4;
                    inv0 = INV1_4; inv1 = INV2_4; inv2 = INV3_4;
                    r_a = get_residue(IDX1_4);
                    r_b = get_residue(IDX2_4);
                    r_c = get_residue(IDX3_4);
                    M_total = M1_4 * M2_4 * M3_4;
                end
                5: begin
                    Mi0 = MI1_5; Mi1 = MI2_5; Mi2 = MI3_5;
                    inv0 = INV1_5; inv1 = INV2_5; inv2 = INV3_5;
                    r_a = get_residue(IDX1_5);
                    r_b = get_residue(IDX2_5);
                    r_c = get_residue(IDX3_5);
                    M_total = M1_5 * M2_5 * M3_5;
                end
                6: begin
                    Mi0 = MI1_6; Mi1 = MI2_6; Mi2 = MI3_6;
                    inv0 = INV1_6; inv1 = INV2_6; inv2 = INV3_6;
                    r_a = get_residue(IDX1_6);
                    r_b = get_residue(IDX2_6);
                    r_c = get_residue(IDX3_6);
                    M_total = M1_6 * M2_6 * M3_6;
                end
                7: begin
                    Mi0 = MI1_7; Mi1 = MI2_7; Mi2 = MI3_7;
                    inv0 = INV1_7; inv1 = INV2_7; inv2 = INV3_7;
                    r_a = get_residue(IDX1_7);
                    r_b = get_residue(IDX2_7);
                    r_c = get_residue(IDX3_7);
                    M_total = M1_7 * M2_7 * M3_7;
                end
                8: begin
                    Mi0 = MI1_8; Mi1 = MI2_8; Mi2 = MI3_8;
                    inv0 = INV1_8; inv1 = INV2_8; inv2 = INV3_8;
                    r_a = get_residue(IDX1_8);
                    r_b = get_residue(IDX2_8);
                    r_c = get_residue(IDX3_8);
                    M_total = M1_8 * M2_8 * M3_8;
                end
                9: begin
                    Mi0 = MI1_9; Mi1 = MI2_9; Mi2 = MI3_9;
                    inv0 = INV1_9; inv1 = INV2_9; inv2 = INV3_9;
                    r_a = get_residue(IDX1_9);
                    r_b = get_residue(IDX2_9);
                    r_c = get_residue(IDX3_9);
                    M_total = M1_9 * M2_9 * M3_9;
                end
                10: begin
                    Mi0 = MI1_10; Mi1 = MI2_10; Mi2 = MI3_10;
                    inv0 = INV1_10; inv1 = INV2_10; inv2 = INV3_10;
                    r_a = get_residue(IDX1_10);
                    r_b = get_residue(IDX2_10);
                    r_c = get_residue(IDX3_10);
                    M_total = M1_10 * M2_10 * M3_10;
                end
                11: begin
                    Mi0 = MI1_11; Mi1 = MI2_11; Mi2 = MI3_11;
                    inv0 = INV1_11; inv1 = INV2_11; inv2 = INV3_11;
                    r_a = get_residue(IDX1_11);
                    r_b = get_residue(IDX2_11);
                    r_c = get_residue(IDX3_11);
                    M_total = M1_11 * M2_11 * M3_11;
                end
                12: begin
                    Mi0 = MI1_12; Mi1 = MI2_12; Mi2 = MI3_12;
                    inv0 = INV1_12; inv1 = INV2_12; inv2 = INV3_12;
                    r_a = get_residue(IDX1_12);
                    r_b = get_residue(IDX2_12);
                    r_c = get_residue(IDX3_12);
                    M_total = M1_12 * M2_12 * M3_12;
                end
                13: begin
                    Mi0 = MI1_13; Mi1 = MI2_13; Mi2 = MI3_13;
                    inv0 = INV1_13; inv1 = INV2_13; inv2 = INV3_13;
                    r_a = get_residue(IDX1_13);
                    r_b = get_residue(IDX2_13);
                    r_c = get_residue(IDX3_13);
                    M_total = M1_13 * M2_13 * M3_13;
                end
                14: begin
                    Mi0 = MI1_14; Mi1 = MI2_14; Mi2 = MI3_14;
                    inv0 = INV1_14; inv1 = INV2_14; inv2 = INV3_14;
                    r_a = get_residue(IDX1_14);
                    r_b = get_residue(IDX2_14);
                    r_c = get_residue(IDX3_14);
                    M_total = M1_14 * M2_14 * M3_14;
                end
                15: begin
                    Mi0 = MI1_15; Mi1 = MI2_15; Mi2 = MI3_15;
                    inv0 = INV1_15; inv1 = INV2_15; inv2 = INV3_15;
                    r_a = get_residue(IDX1_15);
                    r_b = get_residue(IDX2_15);
                    r_c = get_residue(IDX3_15);
                    M_total = M1_15 * M2_15 * M3_15;
                end
                16: begin
                    Mi0 = MI1_16; Mi1 = MI2_16; Mi2 = MI3_16;
                    inv0 = INV1_16; inv1 = INV2_16; inv2 = INV3_16;
                    r_a = get_residue(IDX1_16);
                    r_b = get_residue(IDX2_16);
                    r_c = get_residue(IDX3_16);
                    M_total = M1_16 * M2_16 * M3_16;
                end
                17: begin
                    Mi0 = MI1_17; Mi1 = MI2_17; Mi2 = MI3_17;
                    inv0 = INV1_17; inv1 = INV2_17; inv2 = INV3_17;
                    r_a = get_residue(IDX1_17);
                    r_b = get_residue(IDX2_17);
                    r_c = get_residue(IDX3_17);
                    M_total = M1_17 * M2_17 * M3_17;
                end
                18: begin
                    Mi0 = MI1_18; Mi1 = MI2_18; Mi2 = MI3_18;
                    inv0 = INV1_18; inv1 = INV2_18; inv2 = INV3_18;
                    r_a = get_residue(IDX1_18);
                    r_b = get_residue(IDX2_18);
                    r_c = get_residue(IDX3_18);
                    M_total = M1_18 * M2_18 * M3_18;
                end
                19: begin
                    Mi0 = MI1_19; Mi1 = MI2_19; Mi2 = MI3_19;
                    inv0 = INV1_19; inv1 = INV2_19; inv2 = INV3_19;
                    r_a = get_residue(IDX1_19);
                    r_b = get_residue(IDX2_19);
                    r_c = get_residue(IDX3_19);
                    M_total = M1_19 * M2_19 * M3_19;
                end
                20: begin
                    Mi0 = MI1_20; Mi1 = MI2_20; Mi2 = MI3_20;
                    inv0 = INV1_20; inv1 = INV2_20; inv2 = INV3_20;
                    r_a = get_residue(IDX1_20);
                    r_b = get_residue(IDX2_20);
                    r_c = get_residue(IDX3_20);
                    M_total = M1_20 * M2_20 * M3_20;
                end
                21: begin
                    Mi0 = MI1_21; Mi1 = MI2_21; Mi2 = MI3_21;
                    inv0 = INV1_21; inv1 = INV2_21; inv2 = INV3_21;
                    r_a = get_residue(IDX1_21);
                    r_b = get_residue(IDX2_21);
                    r_c = get_residue(IDX3_21);
                    M_total = M1_21 * M2_21 * M3_21;
                end
                22: begin
                    Mi0 = MI1_22; Mi1 = MI2_22; Mi2 = MI3_22;
                    inv0 = INV1_22; inv1 = INV2_22; inv2 = INV3_22;
                    r_a = get_residue(IDX1_22);
                    r_b = get_residue(IDX2_22);
                    r_c = get_residue(IDX3_22);
                    M_total = M1_22 * M2_22 * M3_22;
                end
                23: begin
                    Mi0 = MI1_23; Mi1 = MI2_23; Mi2 = MI3_23;
                    inv0 = INV1_23; inv1 = INV2_23; inv2 = INV3_23;
                    r_a = get_residue(IDX1_23);
                    r_b = get_residue(IDX2_23);
                    r_c = get_residue(IDX3_23);
                    M_total = M1_23 * M2_23 * M3_23;
                end
                24: begin
                    Mi0 = MI1_24; Mi1 = MI2_24; Mi2 = MI3_24;
                    inv0 = INV1_24; inv1 = INV2_24; inv2 = INV3_24;
                    r_a = get_residue(IDX1_24);
                    r_b = get_residue(IDX2_24);
                    r_c = get_residue(IDX3_24);
                    M_total = M1_24 * M2_24 * M3_24;
                end
                25: begin
                    Mi0 = MI1_25; Mi1 = MI2_25; Mi2 = MI3_25;
                    inv0 = INV1_25; inv1 = INV2_25; inv2 = INV3_25;
                    r_a = get_residue(IDX1_25);
                    r_b = get_residue(IDX2_25);
                    r_c = get_residue(IDX3_25);
                    M_total = M1_25 * M2_25 * M3_25;
                end
                26: begin
                    Mi0 = MI1_26; Mi1 = MI2_26; Mi2 = MI3_26;
                    inv0 = INV1_26; inv1 = INV2_26; inv2 = INV3_26;
                    r_a = get_residue(IDX1_26);
                    r_b = get_residue(IDX2_26);
                    r_c = get_residue(IDX3_26);
                    M_total = M1_26 * M2_26 * M3_26;
                end
                27: begin
                    Mi0 = MI1_27; Mi1 = MI2_27; Mi2 = MI3_27;
                    inv0 = INV1_27; inv1 = INV2_27; inv2 = INV3_27;
                    r_a = get_residue(IDX1_27);
                    r_b = get_residue(IDX2_27);
                    r_c = get_residue(IDX3_27);
                    M_total = M1_27 * M2_27 * M3_27;
                end
                28: begin
                    Mi0 = MI1_28; Mi1 = MI2_28; Mi2 = MI3_28;
                    inv0 = INV1_28; inv1 = INV2_28; inv2 = INV3_28;
                    r_a = get_residue(IDX1_28);
                    r_b = get_residue(IDX2_28);
                    r_c = get_residue(IDX3_28);
                    M_total = M1_28 * M2_28 * M3_28;
                end
                29: begin
                    Mi0 = MI1_29; Mi1 = MI2_29; Mi2 = MI3_29;
                    inv0 = INV1_29; inv1 = INV2_29; inv2 = INV3_29;
                    r_a = get_residue(IDX1_29);
                    r_b = get_residue(IDX2_29);
                    r_c = get_residue(IDX3_29);
                    M_total = M1_29 * M2_29 * M3_29;
                end
                30: begin
                    Mi0 = MI1_30; Mi1 = MI2_30; Mi2 = MI3_30;
                    inv0 = INV1_30; inv1 = INV2_30; inv2 = INV3_30;
                    r_a = get_residue(IDX1_30);
                    r_b = get_residue(IDX2_30);
                    r_c = get_residue(IDX3_30);
                    M_total = M1_30 * M2_30 * M3_30;
                end
                31: begin
                    Mi0 = MI1_31; Mi1 = MI2_31; Mi2 = MI3_31;
                    inv0 = INV1_31; inv1 = INV2_31; inv2 = INV3_31;
                    r_a = get_residue(IDX1_31);
                    r_b = get_residue(IDX2_31);
                    r_c = get_residue(IDX3_31);
                    M_total = M1_31 * M2_31 * M3_31;
                end
                32: begin
                    Mi0 = MI1_32; Mi1 = MI2_32; Mi2 = MI3_32;
                    inv0 = INV1_32; inv1 = INV2_32; inv2 = INV3_32;
                    r_a = get_residue(IDX1_32);
                    r_b = get_residue(IDX2_32);
                    r_c = get_residue(IDX3_32);
                    M_total = M1_32 * M2_32 * M3_32;
                end
                33: begin
                    Mi0 = MI1_33; Mi1 = MI2_33; Mi2 = MI3_33;
                    inv0 = INV1_33; inv1 = INV2_33; inv2 = INV3_33;
                    r_a = get_residue(IDX1_33);
                    r_b = get_residue(IDX2_33);
                    r_c = get_residue(IDX3_33);
                    M_total = M1_33 * M2_33 * M3_33;
                end
                34: begin
                    Mi0 = MI1_34; Mi1 = MI2_34; Mi2 = MI3_34;
                    inv0 = INV1_34; inv1 = INV2_34; inv2 = INV3_34;
                    r_a = get_residue(IDX1_34);
                    r_b = get_residue(IDX2_34);
                    r_c = get_residue(IDX3_34);
                    M_total = M1_34 * M2_34 * M3_34;
                end
                35: begin
                    Mi0 = MI1_35; Mi1 = MI2_35; Mi2 = MI3_35;
                    inv0 = INV1_35; inv1 = INV2_35; inv2 = INV3_35;
                    r_a = get_residue(IDX1_35);
                    r_b = get_residue(IDX2_35);
                    r_c = get_residue(IDX3_35);
                    M_total = M1_35 * M2_35 * M3_35;
                end
                36: begin
                    Mi0 = MI1_36; Mi1 = MI2_36; Mi2 = MI3_36;
                    inv0 = INV1_36; inv1 = INV2_36; inv2 = INV3_36;
                    r_a = get_residue(IDX1_36);
                    r_b = get_residue(IDX2_36);
                    r_c = get_residue(IDX3_36);
                    M_total = M1_36 * M2_36 * M3_36;
                end
                37: begin
                    Mi0 = MI1_37; Mi1 = MI2_37; Mi2 = MI3_37;
                    inv0 = INV1_37; inv1 = INV2_37; inv2 = INV3_37;
                    r_a = get_residue(IDX1_37);
                    r_b = get_residue(IDX2_37);
                    r_c = get_residue(IDX3_37);
                    M_total = M1_37 * M2_37 * M3_37;
                end
                38: begin
                    Mi0 = MI1_38; Mi1 = MI2_38; Mi2 = MI3_38;
                    inv0 = INV1_38; inv1 = INV2_38; inv2 = INV3_38;
                    r_a = get_residue(IDX1_38);
                    r_b = get_residue(IDX2_38);
                    r_c = get_residue(IDX3_38);
                    M_total = M1_38 * M2_38 * M3_38;
                end
                39: begin
                    Mi0 = MI1_39; Mi1 = MI2_39; Mi2 = MI3_39;
                    inv0 = INV1_39; inv1 = INV2_39; inv2 = INV3_39;
                    r_a = get_residue(IDX1_39);
                    r_b = get_residue(IDX2_39);
                    r_c = get_residue(IDX3_39);
                    M_total = M1_39 * M2_39 * M3_39;
                end
                40: begin
                    Mi0 = MI1_40; Mi1 = MI2_40; Mi2 = MI3_40;
                    inv0 = INV1_40; inv1 = INV2_40; inv2 = INV3_40;
                    r_a = get_residue(IDX1_40);
                    r_b = get_residue(IDX2_40);
                    r_c = get_residue(IDX3_40);
                    M_total = M1_40 * M2_40 * M3_40;
                end
                41: begin
                    Mi0 = MI1_41; Mi1 = MI2_41; Mi2 = MI3_41;
                    inv0 = INV1_41; inv1 = INV2_41; inv2 = INV3_41;
                    r_a = get_residue(IDX1_41);
                    r_b = get_residue(IDX2_41);
                    r_c = get_residue(IDX3_41);
                    M_total = M1_41 * M2_41 * M3_41;
                end
                42: begin
                    Mi0 = MI1_42; Mi1 = MI2_42; Mi2 = MI3_42;
                    inv0 = INV1_42; inv1 = INV2_42; inv2 = INV3_42;
                    r_a = get_residue(IDX1_42);
                    r_b = get_residue(IDX2_42);
                    r_c = get_residue(IDX3_42);
                    M_total = M1_42 * M2_42 * M3_42;
                end
                43: begin
                    Mi0 = MI1_43; Mi1 = MI2_43; Mi2 = MI3_43;
                    inv0 = INV1_43; inv1 = INV2_43; inv2 = INV3_43;
                    r_a = get_residue(IDX1_43);
                    r_b = get_residue(IDX2_43);
                    r_c = get_residue(IDX3_43);
                    M_total = M1_43 * M2_43 * M3_43;
                end
                44: begin
                    Mi0 = MI1_44; Mi1 = MI2_44; Mi2 = MI3_44;
                    inv0 = INV1_44; inv1 = INV2_44; inv2 = INV3_44;
                    r_a = get_residue(IDX1_44);
                    r_b = get_residue(IDX2_44);
                    r_c = get_residue(IDX3_44);
                    M_total = M1_44 * M2_44 * M3_44;
                end
                45: begin
                    Mi0 = MI1_45; Mi1 = MI2_45; Mi2 = MI3_45;
                    inv0 = INV1_45; inv1 = INV2_45; inv2 = INV3_45;
                    r_a = get_residue(IDX1_45);
                    r_b = get_residue(IDX2_45);
                    r_c = get_residue(IDX3_45);
                    M_total = M1_45 * M2_45 * M3_45;
                end
                46: begin
                    Mi0 = MI1_46; Mi1 = MI2_46; Mi2 = MI3_46;
                    inv0 = INV1_46; inv1 = INV2_46; inv2 = INV3_46;
                    r_a = get_residue(IDX1_46);
                    r_b = get_residue(IDX2_46);
                    r_c = get_residue(IDX3_46);
                    M_total = M1_46 * M2_46 * M3_46;
                end
                47: begin
                    Mi0 = MI1_47; Mi1 = MI2_47; Mi2 = MI3_47;
                    inv0 = INV1_47; inv1 = INV2_47; inv2 = INV3_47;
                    r_a = get_residue(IDX1_47);
                    r_b = get_residue(IDX2_47);
                    r_c = get_residue(IDX3_47);
                    M_total = M1_47 * M2_47 * M3_47;
                end
                48: begin
                    Mi0 = MI1_48; Mi1 = MI2_48; Mi2 = MI3_48;
                    inv0 = INV1_48; inv1 = INV2_48; inv2 = INV3_48;
                    r_a = get_residue(IDX1_48);
                    r_b = get_residue(IDX2_48);
                    r_c = get_residue(IDX3_48);
                    M_total = M1_48 * M2_48 * M3_48;
                end
                49: begin
                    Mi0 = MI1_49; Mi1 = MI2_49; Mi2 = MI3_49;
                    inv0 = INV1_49; inv1 = INV2_49; inv2 = INV3_49;
                    r_a = get_residue(IDX1_49);
                    r_b = get_residue(IDX2_49);
                    r_c = get_residue(IDX3_49);
                    M_total = M1_49 * M2_49 * M3_49;
                end
                50: begin
                    Mi0 = MI1_50; Mi1 = MI2_50; Mi2 = MI3_50;
                    inv0 = INV1_50; inv1 = INV2_50; inv2 = INV3_50;
                    r_a = get_residue(IDX1_50);
                    r_b = get_residue(IDX2_50);
                    r_c = get_residue(IDX3_50);
                    M_total = M1_50 * M2_50 * M3_50;
                end
                51: begin
                    Mi0 = MI1_51; Mi1 = MI2_51; Mi2 = MI3_51;
                    inv0 = INV1_51; inv1 = INV2_51; inv2 = INV3_51;
                    r_a = get_residue(IDX1_51);
                    r_b = get_residue(IDX2_51);
                    r_c = get_residue(IDX3_51);
                    M_total = M1_51 * M2_51 * M3_51;
                end
                52: begin
                    Mi0 = MI1_52; Mi1 = MI2_52; Mi2 = MI3_52;
                    inv0 = INV1_52; inv1 = INV2_52; inv2 = INV3_52;
                    r_a = get_residue(IDX1_52);
                    r_b = get_residue(IDX2_52);
                    r_c = get_residue(IDX3_52);
                    M_total = M1_52 * M2_52 * M3_52;
                end
                53: begin
                    Mi0 = MI1_53; Mi1 = MI2_53; Mi2 = MI3_53;
                    inv0 = INV1_53; inv1 = INV2_53; inv2 = INV3_53;
                    r_a = get_residue(IDX1_53);
                    r_b = get_residue(IDX2_53);
                    r_c = get_residue(IDX3_53);
                    M_total = M1_53 * M2_53 * M3_53;
                end
                54: begin
                    Mi0 = MI1_54; Mi1 = MI2_54; Mi2 = MI3_54;
                    inv0 = INV1_54; inv1 = INV2_54; inv2 = INV3_54;
                    r_a = get_residue(IDX1_54);
                    r_b = get_residue(IDX2_54);
                    r_c = get_residue(IDX3_54);
                    M_total = M1_54 * M2_54 * M3_54;
                end
                55: begin
                    Mi0 = MI1_55; Mi1 = MI2_55; Mi2 = MI3_55;
                    inv0 = INV1_55; inv1 = INV2_55; inv2 = INV3_55;
                    r_a = get_residue(IDX1_55);
                    r_b = get_residue(IDX2_55);
                    r_c = get_residue(IDX3_55);
                    M_total = M1_55 * M2_55 * M3_55;
                end
                56: begin
                    Mi0 = MI1_56; Mi1 = MI2_56; Mi2 = MI3_56;
                    inv0 = INV1_56; inv1 = INV2_56; inv2 = INV3_56;
                    r_a = get_residue(IDX1_56);
                    r_b = get_residue(IDX2_56);
                    r_c = get_residue(IDX3_56);
                    M_total = M1_56 * M2_56 * M3_56;
                end
                57: begin
                    Mi0 = MI1_57; Mi1 = MI2_57; Mi2 = MI3_57;
                    inv0 = INV1_57; inv1 = INV2_57; inv2 = INV3_57;
                    r_a = get_residue(IDX1_57);
                    r_b = get_residue(IDX2_57);
                    r_c = get_residue(IDX3_57);
                    M_total = M1_57 * M2_57 * M3_57;
                end
                58: begin
                    Mi0 = MI1_58; Mi1 = MI2_58; Mi2 = MI3_58;
                    inv0 = INV1_58; inv1 = INV2_58; inv2 = INV3_58;
                    r_a = get_residue(IDX1_58);
                    r_b = get_residue(IDX2_58);
                    r_c = get_residue(IDX3_58);
                    M_total = M1_58 * M2_58 * M3_58;
                end
                59: begin
                    Mi0 = MI1_59; Mi1 = MI2_59; Mi2 = MI3_59;
                    inv0 = INV1_59; inv1 = INV2_59; inv2 = INV3_59;
                    r_a = get_residue(IDX1_59);
                    r_b = get_residue(IDX2_59);
                    r_c = get_residue(IDX3_59);
                    M_total = M1_59 * M2_59 * M3_59;
                end
                60: begin
                    Mi0 = MI1_60; Mi1 = MI2_60; Mi2 = MI3_60;
                    inv0 = INV1_60; inv1 = INV2_60; inv2 = INV3_60;
                    r_a = get_residue(IDX1_60);
                    r_b = get_residue(IDX2_60);
                    r_c = get_residue(IDX3_60);
                    M_total = M1_60 * M2_60 * M3_60;
                end
                61: begin
                    Mi0 = MI1_61; Mi1 = MI2_61; Mi2 = MI3_61;
                    inv0 = INV1_61; inv1 = INV2_61; inv2 = INV3_61;
                    r_a = get_residue(IDX1_61);
                    r_b = get_residue(IDX2_61);
                    r_c = get_residue(IDX3_61);
                    M_total = M1_61 * M2_61 * M3_61;
                end
                62: begin
                    Mi0 = MI1_62; Mi1 = MI2_62; Mi2 = MI3_62;
                    inv0 = INV1_62; inv1 = INV2_62; inv2 = INV3_62;
                    r_a = get_residue(IDX1_62);
                    r_b = get_residue(IDX2_62);
                    r_c = get_residue(IDX3_62);
                    M_total = M1_62 * M2_62 * M3_62;
                end
                63: begin
                    Mi0 = MI1_63; Mi1 = MI2_63; Mi2 = MI3_63;
                    inv0 = INV1_63; inv1 = INV2_63; inv2 = INV3_63;
                    r_a = get_residue(IDX1_63);
                    r_b = get_residue(IDX2_63);
                    r_c = get_residue(IDX3_63);
                    M_total = M1_63 * M2_63 * M3_63;
                end
                64: begin
                    Mi0 = MI1_64; Mi1 = MI2_64; Mi2 = MI3_64;
                    inv0 = INV1_64; inv1 = INV2_64; inv2 = INV3_64;
                    r_a = get_residue(IDX1_64);
                    r_b = get_residue(IDX2_64);
                    r_c = get_residue(IDX3_64);
                    M_total = M1_64 * M2_64 * M3_64;
                end
                65: begin
                    Mi0 = MI1_65; Mi1 = MI2_65; Mi2 = MI3_65;
                    inv0 = INV1_65; inv1 = INV2_65; inv2 = INV3_65;
                    r_a = get_residue(IDX1_65);
                    r_b = get_residue(IDX2_65);
                    r_c = get_residue(IDX3_65);
                    M_total = M1_65 * M2_65 * M3_65;
                end
                66: begin
                    Mi0 = MI1_66; Mi1 = MI2_66; Mi2 = MI3_66;
                    inv0 = INV1_66; inv1 = INV2_66; inv2 = INV3_66;
                    r_a = get_residue(IDX1_66);
                    r_b = get_residue(IDX2_66);
                    r_c = get_residue(IDX3_66);
                    M_total = M1_66 * M2_66 * M3_66;
                end
                67: begin
                    Mi0 = MI1_67; Mi1 = MI2_67; Mi2 = MI3_67;
                    inv0 = INV1_67; inv1 = INV2_67; inv2 = INV3_67;
                    r_a = get_residue(IDX1_67);
                    r_b = get_residue(IDX2_67);
                    r_c = get_residue(IDX3_67);
                    M_total = M1_67 * M2_67 * M3_67;
                end
                68: begin
                    Mi0 = MI1_68; Mi1 = MI2_68; Mi2 = MI3_68;
                    inv0 = INV1_68; inv1 = INV2_68; inv2 = INV3_68;
                    r_a = get_residue(IDX1_68);
                    r_b = get_residue(IDX2_68);
                    r_c = get_residue(IDX3_68);
                    M_total = M1_68 * M2_68 * M3_68;
                end
                69: begin
                    Mi0 = MI1_69; Mi1 = MI2_69; Mi2 = MI3_69;
                    inv0 = INV1_69; inv1 = INV2_69; inv2 = INV3_69;
                    r_a = get_residue(IDX1_69);
                    r_b = get_residue(IDX2_69);
                    r_c = get_residue(IDX3_69);
                    M_total = M1_69 * M2_69 * M3_69;
                end
                70: begin
                    Mi0 = MI1_70; Mi1 = MI2_70; Mi2 = MI3_70;
                    inv0 = INV1_70; inv1 = INV2_70; inv2 = INV3_70;
                    r_a = get_residue(IDX1_70);
                    r_b = get_residue(IDX2_70);
                    r_c = get_residue(IDX3_70);
                    M_total = M1_70 * M2_70 * M3_70;
                end
                71: begin
                    Mi0 = MI1_71; Mi1 = MI2_71; Mi2 = MI3_71;
                    inv0 = INV1_71; inv1 = INV2_71; inv2 = INV3_71;
                    r_a = get_residue(IDX1_71);
                    r_b = get_residue(IDX2_71);
                    r_c = get_residue(IDX3_71);
                    M_total = M1_71 * M2_71 * M3_71;
                end
                72: begin
                    Mi0 = MI1_72; Mi1 = MI2_72; Mi2 = MI3_72;
                    inv0 = INV1_72; inv1 = INV2_72; inv2 = INV3_72;
                    r_a = get_residue(IDX1_72);
                    r_b = get_residue(IDX2_72);
                    r_c = get_residue(IDX3_72);
                    M_total = M1_72 * M2_72 * M3_72;
                end
                73: begin
                    Mi0 = MI1_73; Mi1 = MI2_73; Mi2 = MI3_73;
                    inv0 = INV1_73; inv1 = INV2_73; inv2 = INV3_73;
                    r_a = get_residue(IDX1_73);
                    r_b = get_residue(IDX2_73);
                    r_c = get_residue(IDX3_73);
                    M_total = M1_73 * M2_73 * M3_73;
                end
                74: begin
                    Mi0 = MI1_74; Mi1 = MI2_74; Mi2 = MI3_74;
                    inv0 = INV1_74; inv1 = INV2_74; inv2 = INV3_74;
                    r_a = get_residue(IDX1_74);
                    r_b = get_residue(IDX2_74);
                    r_c = get_residue(IDX3_74);
                    M_total = M1_74 * M2_74 * M3_74;
                end
                75: begin
                    Mi0 = MI1_75; Mi1 = MI2_75; Mi2 = MI3_75;
                    inv0 = INV1_75; inv1 = INV2_75; inv2 = INV3_75;
                    r_a = get_residue(IDX1_75);
                    r_b = get_residue(IDX2_75);
                    r_c = get_residue(IDX3_75);
                    M_total = M1_75 * M2_75 * M3_75;
                end
                76: begin
                    Mi0 = MI1_76; Mi1 = MI2_76; Mi2 = MI3_76;
                    inv0 = INV1_76; inv1 = INV2_76; inv2 = INV3_76;
                    r_a = get_residue(IDX1_76);
                    r_b = get_residue(IDX2_76);
                    r_c = get_residue(IDX3_76);
                    M_total = M1_76 * M2_76 * M3_76;
                end
                77: begin
                    Mi0 = MI1_77; Mi1 = MI2_77; Mi2 = MI3_77;
                    inv0 = INV1_77; inv1 = INV2_77; inv2 = INV3_77;
                    r_a = get_residue(IDX1_77);
                    r_b = get_residue(IDX2_77);
                    r_c = get_residue(IDX3_77);
                    M_total = M1_77 * M2_77 * M3_77;
                end
                78: begin
                    Mi0 = MI1_78; Mi1 = MI2_78; Mi2 = MI3_78;
                    inv0 = INV1_78; inv1 = INV2_78; inv2 = INV3_78;
                    r_a = get_residue(IDX1_78);
                    r_b = get_residue(IDX2_78);
                    r_c = get_residue(IDX3_78);
                    M_total = M1_78 * M2_78 * M3_78;
                end
                79: begin
                    Mi0 = MI1_79; Mi1 = MI2_79; Mi2 = MI3_79;
                    inv0 = INV1_79; inv1 = INV2_79; inv2 = INV3_79;
                    r_a = get_residue(IDX1_79);
                    r_b = get_residue(IDX2_79);
                    r_c = get_residue(IDX3_79);
                    M_total = M1_79 * M2_79 * M3_79;
                end
                80: begin
                    Mi0 = MI1_80; Mi1 = MI2_80; Mi2 = MI3_80;
                    inv0 = INV1_80; inv1 = INV2_80; inv2 = INV3_80;
                    r_a = get_residue(IDX1_80);
                    r_b = get_residue(IDX2_80);
                    r_c = get_residue(IDX3_80);
                    M_total = M1_80 * M2_80 * M3_80;
                end
                81: begin
                    Mi0 = MI1_81; Mi1 = MI2_81; Mi2 = MI3_81;
                    inv0 = INV1_81; inv1 = INV2_81; inv2 = INV3_81;
                    r_a = get_residue(IDX1_81);
                    r_b = get_residue(IDX2_81);
                    r_c = get_residue(IDX3_81);
                    M_total = M1_81 * M2_81 * M3_81;
                end
                82: begin
                    Mi0 = MI1_82; Mi1 = MI2_82; Mi2 = MI3_82;
                    inv0 = INV1_82; inv1 = INV2_82; inv2 = INV3_82;
                    r_a = get_residue(IDX1_82);
                    r_b = get_residue(IDX2_82);
                    r_c = get_residue(IDX3_82);
                    M_total = M1_82 * M2_82 * M3_82;
                end
                83: begin
                    Mi0 = MI1_83; Mi1 = MI2_83; Mi2 = MI3_83;
                    inv0 = INV1_83; inv1 = INV2_83; inv2 = INV3_83;
                    r_a = get_residue(IDX1_83);
                    r_b = get_residue(IDX2_83);
                    r_c = get_residue(IDX3_83);
                    M_total = M1_83 * M2_83 * M3_83;
                end
// --- 生成完毕 ---
