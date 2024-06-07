library;

/// ***********************************************************************************
///                                           SIZE
/// ***********************************************************************************

Map<String, dynamic> allSizes = {
  "success": true,
  "message": "predefined fetched successfully",
  "data": {
    "ring": {
      // "colors": [
      //   {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
      //   {"id": "W", "value": "W", "label": "W (White)"},
      //   {"id": "P", "value": "P", "label": "P (Pink)"}
      // ],
      "size": [
        {"id": "4", "value": "4", "label": "4 (S4 | CP-6 | P-04)"},
        {"id": "4.5", "value": "4.5", "label": "4.5 (S4.5 CP-7 | P-05)"},
        {"id": "5", "value": "5", "label": "5 (S5 P-5)"},
        {"id": "5.5", "value": "5.5", "label": "5.5 (S5.5 | P-5)"},
        {"id": "6", "value": "6", "label": "6 (S6 | CP-8 | P-6 | 45.9 (mm))"},
        {"id": "6.5", "value": "6.5", "label": "6.5 (S6.5 | P-6.5)"},
        {"id": "7", "value": "7", "label": "7 (S7 CP-9 | P-6.5 | 47.1 (mm))"},
        {"id": "7.5", "value": "7.5", "label": "7.5 (S7.5 P-7)"},
        {"id": "8", "value": "8", "label": "8 (S8 CP-10 | P-7.5 48.1 (mm))"},
        {"id": "8.5", "value": "8.5", "label": "8.5 (S8.5 | P-8)"},
        {"id": "9", "value": "9", "label": "9 (S9 CP-11 | P-8.5 | 49.0 (mm))"},
        {"id": "9.5", "value": "9.5", "label": "9.5 (S9.5 | P-9)"},
        {"id": "10", "value": "10", "label": "10 (S10 | CP-12 | P-9.5 | 50.0 (mm))"},
        {"id": "10.5", "value": "10.5", "label": "10.5 (S10.5 | CP-12 | P-10)"},
        {"id": "11", "value": "11", "label": "11 (S11 CP-13 | P-10 | 50.9 (mm))"},
        {"id": "11.5", "value": "11.5", "label": "11.5 (S11.5 | P10.5)"},
        {"id": "12", "value": "12", "label": "12 (S12 | CP-14 | P-10.5 | 51.8 (mm))"},
        {"id": "12.5", "value": "12.5", "label": "12.5 (S12.5 P-11)"},
        {"id": "13", "value": "13", "label": "13 (S13 CP-15 | P11.5 | 52.8 (mm))"},
        {"id": "13.5", "value": "13.5", "label": "13.5 (S13.5 P-12)"},
        {"id": "14", "value": "14", "label": "14 (S14 | CP-16 | P12.5 | 54.0 (mm))"},
        {"id": "14.5", "value": "14.5", "label": "14.5 (S14.5 P-13)"},
        {"id": "15", "value": "15", "label": "15 (S15 CP-17 | P13.5 | 55.0 (mm))"},
        {"id": "15.5", "value": "15.5", "label": "15.5 (S15.5 P-14)"},
        {"id": "16", "value": "16", "label": "16 (S16 | CP-18 | P14.5 | 55.9 (mm))"},
        {"id": "16.5", "value": "16.5", "label": "16.5 (S16.5 | P-15)"},
        {"id": "17", "value": "17", "label": "17 (S17 CP-19 | P15.5 | 56.9 (mm))"},
        {"id": "17.5", "value": "17.5", "label": "17.5 (S17.5 P-16)"},
        {"id": "18", "value": "18", "label": "18 (S18 | CP-20 | P16.5 | 57.8 (mm))"},
        {"id": "18.5", "value": "18.5", "label": "18.5 (S18.5 | P-17)"},
        {"id": "19", "value": "19", "label": "19 (S19 CP-21 | P17.5 | 59.1 (mm))"},
        {"id": "19.5", "value": "19.5", "label": "19.5 (S19.5 | P-18)"},
        {"id": "20", "value": "20", "label": "20 (S20 | CP-22 | P18.5 | 60.0 (mm))"},
        {"id": "20.5", "value": "20.5", "label": "20.5 (S20.5 | P-19)"},
        {"id": "21", "value": "21", "label": "21 (S21 CP-22.5 | P-19.5 | 60.9 (mm))"},
        {"id": "21.5", "value": "21.5", "label": "21.5 (S21.5 | P-20)"},
        {"id": "22", "value": "22", "label": "22 (S22 | CP-23 | P20.5 | 61.9 (mm))"},
        {"id": "22.5", "value": "22.5", "label": "22.5 (S22.5 | S-24 | P-20.5)"},
        {"id": "23", "value": "23", "label": "23 (S23 | CP-24 | P-20.5 | 62.8 (mm))"},
        {"id": "23.5", "value": "23.5", "label": "23.5 (S23.5 | P-21)"},
        {"id": "24", "value": "24", "label": "24 (S24 CP-25 | P21.5 63.8 (mm))"},
        {"id": "24.5", "value": "24.5", "label": "24.5 (S24.5 | P-22)"},
        {"id": "25", "value": "25", "label": "25 (S25 CP-26 | P22.5 | 64.7 (mm))"},
        {"id": "25.5", "value": "25.5", "label": "25.5 (S25.5 | P-23)"},
        {"id": "26", "value": "26", "label": "26 (S26 | CP-27 | P23.5 | 66.0 (mm))"},
        {"id": "26.5", "value": "26.5", "label": "26.5 (S26.5 | P-24)"},
        {"id": "27", "value": "27", "label": "27 (S27 CP-27.5 | P-24.5 | 66.9 (mm))"},
        {"id": "27.5", "value": "27.5", "label": "27.5 (S27.5 | P-25)"},
        {"id": "28", "value": "28", "label": "28 (S28 | CP-28 | P-25.5 | 67.9 (mm))"},
        {"id": "28.5", "value": "28.5", "label": "28.5 (S28.5 | CP-29 | P-26)"},
        {"id": "29", "value": "29", "label": "29 (S29 | CP-30 | P-26.5 | 69.1 (mm))"},
        {"id": "29.5", "value": "29.5", "label": "29.5 (S29.5 | P-27)"},
        {"id": "30", "value": "30", "label": "30 (S30 | CP-30.5 | P-27.5 | 70.1 (mm))"},
        {"id": "31", "value": "31", "label": "31 (S31)"},
        {"id": "32", "value": "32", "label": "32 (S32)"},
        {"id": "33", "value": "33", "label": "33 (S33)"}
      ],
    },
    // "ear_ring": {
    //   "size": [
    //     {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
    //     {"id": "SS", "value": "SS", "label": "SS (SS | South Screw)"}
    //   ],
    // },
    // "bangles": {
    //   "size": [
    //     {"id": "2.0", "value": "2.0", "label": "2.0 (B2 | 50.8 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.1", "value": "2.1", "label": "2.1 (B2.1 | 52.4 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.2", "value": "2.2", "label": "2.2 (B2.2 | 54.0 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.3", "value": "2.3", "label": "2.3 (B2.3 | 55.6 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.4", "value": "2.4", "label": "2.4 (B2.4 | 57.2 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.5", "value": "2.5", "label": "2.5 (B2.5 | 58.7 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.6", "value": "2.6", "label": "2.6 (B2.6 | 60.3 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.7", "value": "2.7", "label": "2.7 (B2.7 | 61.9 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.8", "value": "2.8", "label": "2.8 (B2.8 | 63.5 (mm) Bangle Size - Diameter)"},
    //     {"id": "2.9", "value": "2.9", "label": "2.9 (B2.9 | 65.1 (mm) Bangle Size - Diameter)"}
    //   ],
    // },
    // "nose_pin": {
    //   "size": [
    //     {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
    //     {"id": "RSWB", "value": "RSWB", "label": "RSWB (RSWB | Regular Screw - WB)"},
    //     {"id": "RSWB6", "value": "RSWB6", "label": "RSWB6 (RSWB6 | Regular Screw - WB 6.0 (mm))"},
    //     {"id": "SS", "value": "SS", "label": "SS (SS South Screw)"},
    //     {"id": "SSWB6", "value": "SSWB6", "label": "SSWB6 (SSWB9 | South Screw - WB 6.0 (mm))"},
    //     {"id": "SSWB7", "value": "SSWB7", "label": "SSWB7 (SSWB7 | South Screw - WB 7.0 (mm))"},
    //     {"id": "SSWB8", "value": "SSWB8", "label": "SSWB8 (SSWB8 | South Screw - WB 8.0 (mm))"},
    //     {"id": "SSWB9", "value": "SSWB9", "label": "SSWB9 (SSWB9 | South Screw - WB 9.0 (mm))"}
    //   ],
    // },
    // "bracelet": {
    //   "size": [
    //     {"id": "6", "value": "6", "label": "6 (B6 (152.4 MM ))"},
    //     {"id": "6.25", "value": "6.25", "label": "6.25 (B6.25 (158.75 MM))"},
    //     {"id": "6.5", "value": "6.5", "label": "6.5 (B6.50 (165.1 MM ))"},
    //     {"id": "6.75", "value": "6.75", "label": "6.75 (B6.75 (171.45 MM))"},
    //     {"id": "7", "value": "7", "label": "7 (B7 (177.8 MM ))"},
    //     {"id": "7.25", "value": "7.25", "label": "7.25 (B7.25 (184.15 MM))"},
    //     {"id": "7.5", "value": "7.5", "label": "7.5 (B7.50 (190.5 MM))"},
    //     {"id": "8", "value": "8", "label": "8 (B8 (203.2 MM ))"},
    //     {"id": "8.25", "value": "8.25", "label": "8.25 (Β8.25 (209.55 MM))"},
    //     {"id": "8.5", "value": "8.5", "label": "8.5 (B8.50)"},
    //     {"id": "5.5", "value": "5.5", "label": "5.5 (B5.5 (139.7 MM))"},
    //     {"id": "5", "value": "5", "label": "5 (B5 (127 MM ))"}
    //   ],
    // },

    // "diamond": {
    //   "size": [
    //     {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
    //     {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
    //     {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
    //     {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
    //   ],
    // }
  }
};

List earringsSizes = [
  {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
  {"id": "SS", "value": "SS", "label": "SS (SS | South Screw)"}
];

List banglesSizes = [
  {"id": "2.0", "value": "2.0", "label": "2.0 (B2 | 50.8 (mm) Bangle Size - Diameter)"},
  {"id": "2.1", "value": "2.1", "label": "2.1 (B2.1 | 52.4 (mm) Bangle Size - Diameter)"},
  {"id": "2.2", "value": "2.2", "label": "2.2 (B2.2 | 54.0 (mm) Bangle Size - Diameter)"},
  {"id": "2.3", "value": "2.3", "label": "2.3 (B2.3 | 55.6 (mm) Bangle Size - Diameter)"},
  {"id": "2.4", "value": "2.4", "label": "2.4 (B2.4 | 57.2 (mm) Bangle Size - Diameter)"},
  {"id": "2.5", "value": "2.5", "label": "2.5 (B2.5 | 58.7 (mm) Bangle Size - Diameter)"},
  {"id": "2.6", "value": "2.6", "label": "2.6 (B2.6 | 60.3 (mm) Bangle Size - Diameter)"},
  {"id": "2.7", "value": "2.7", "label": "2.7 (B2.7 | 61.9 (mm) Bangle Size - Diameter)"},
  {"id": "2.8", "value": "2.8", "label": "2.8 (B2.8 | 63.5 (mm) Bangle Size - Diameter)"},
  {"id": "2.9", "value": "2.9", "label": "2.9 (B2.9 | 65.1 (mm) Bangle Size - Diameter)"}
];

List nosePinSizes = [
  {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
  {"id": "RSWB", "value": "RSWB", "label": "RSWB (RSWB | Regular Screw - WB)"},
  {"id": "RSWB6", "value": "RSWB6", "label": "RSWB6 (RSWB6 | Regular Screw - WB 6.0 (mm))"},
  {"id": "SS", "value": "SS", "label": "SS (SS South Screw)"},
  {"id": "SSWB6", "value": "SSWB6", "label": "SSWB6 (SSWB9 | South Screw - WB 6.0 (mm))"},
  {"id": "SSWB7", "value": "SSWB7", "label": "SSWB7 (SSWB7 | South Screw - WB 7.0 (mm))"},
  {"id": "SSWB8", "value": "SSWB8", "label": "SSWB8 (SSWB8 | South Screw - WB 8.0 (mm))"},
  {"id": "SSWB9", "value": "SSWB9", "label": "SSWB9 (SSWB9 | South Screw - WB 9.0 (mm))"}
];

List braceletsSizes = [
  {"id": "6", "value": "6", "label": "6 (B6 (152.4 MM ))"},
  {"id": "6.25", "value": "6.25", "label": "6.25 (B6.25 (158.75 MM))"},
  {"id": "6.5", "value": "6.5", "label": "6.5 (B6.50 (165.1 MM ))"},
  {"id": "6.75", "value": "6.75", "label": "6.75 (B6.75 (171.45 MM))"},
  {"id": "7", "value": "7", "label": "7 (B7 (177.8 MM ))"},
  {"id": "7.25", "value": "7.25", "label": "7.25 (B7.25 (184.15 MM))"},
  {"id": "7.5", "value": "7.5", "label": "7.5 (B7.50 (190.5 MM))"},
  {"id": "8", "value": "8", "label": "8 (B8 (203.2 MM ))"},
  {"id": "8.25", "value": "8.25", "label": "8.25 (Β8.25 (209.55 MM))"},
  {"id": "8.5", "value": "8.5", "label": "8.5 (B8.50)"},
  {"id": "5.5", "value": "5.5", "label": "5.5 (B5.5 (139.7 MM))"},
  {"id": "5", "value": "5", "label": "5 (B5 (127 MM ))"}
];

/// ***********************************************************************************
///                                           COLOR
/// ***********************************************************************************

Map<String, dynamic> colors = {
  "success": true,
  "message": "Colors fetched successfully",
  "data": {
    "colors": [
      {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
      {"id": "W", "value": "W", "label": "W (White)"},
      {"id": "P", "value": "P", "label": "P (Pink)"}
    ],
  }
};

/// ***********************************************************************************
///                                        DIAMOND TYPES
/// ***********************************************************************************

Map<String, dynamic> diamondTypes = {
  "success": true,
  "message": "diamond fetched successfully",
  "data": {
    "diamonds": [
      {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
      {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
      {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
      {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
    ],
  }
};
