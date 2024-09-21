import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../exports.dart';

/// Ok Status Massage Green Color.
void printOkStatus(dynamic text) => _printColoredMessage(text, '\x1B[92m');

/// Yellow Massage Yellow Color.
void printYellow(dynamic text) => _printColoredMessage(text, '\x1B[93m');

/// Warning Massage Red Color.
void printWarning(dynamic text) => _printColoredMessage(text, '\x1B[91m');

/// Error Massage Red Color.
void printErrors({dynamic errText, dynamic type}) => Platform.isIOS ? log("$type: $errText") : debugPrint("\x1B[97m${type.toString()}\x1B[0m \x1B[91m${errText.toString()}\x1B[0m", wrapWidth: 99999);

/// Print Massage Green and White Color.
void printMess(dynamic title, {dynamic data}) => Platform.isIOS ? log("$title: $data") : debugPrint("\x1B[97m${title.toString()}:\x1B[0m \x1B[92m${data.toString()}\x1B[0m", wrapWidth: 99999);

/// Action Massage Blue Color.
void printAction(dynamic text) => _printColoredMessage(text, '\x1B[101m');

/// Cancel Massage Gray Color.
void printCancel(dynamic text) => _printColoredMessage(text, '\x1B[96m');

/// Title Message.
void printTitle(dynamic text) => Platform.isIOS ? log(text.toString()) : debugPrint("\x1B[40m-=-=-=-=-=-=-=-= ${text.toString()} -=-=-=-=-=-=-=-=\x1B[0m", wrapWidth: 99999);

/// Date Message.
void printDate(dynamic date) => Platform.isIOS ? log(date.toString()) : debugPrint("\x1B[96m-=-=-=Date=-=-= ${date.toString()} -=-=-=Date=-=-=\x1B[0m", wrapWidth: 99999);

/// SubTitle Massage Red color.
void printWhite(dynamic text) => _printColoredMessage(text, '\x1B[97m');

/// Prints text in blue color.
void printBlue(dynamic text) => _printColoredMessage(text, '\x1B[94m');

/// Prints text in purple color.
void printPurple(dynamic text) => _printColoredMessage(text, '\x1B[95m');

void printData({dynamic key, dynamic value}) => Platform.isIOS ? log("$key: $value") : debugPrint('\x1B[97m${key.toString()}:\x1B[0m' ' ${key.toString().contains("warning") ? "\x1B[91m${value.toString()}\x1B[0m" : "\x1B[92m${value.toString()}\x1B[0m"}', wrapWidth: 99999);

void printAPIData(dynamic text) => _printColoredMessage(text, '\x1B[100m');

/// List Massage colors.
void printLoop(List? list, {String? title, bool? isJsonList}) {
  if (list == null) {
    return printWhite('${!isValEmpty(title) ? title : "List"} is Null');
  }
  debugPrint('\x1B[97m${title ?? "List"} of length:\x1B[0m \x1B[92m${list.length.toInt()}\x1B[97m');
  for (var i = 0; i < list.length; i++) {
    isJsonList != false ? debugPrint('\x1B[97mIndex[\x1B[0m\x1B[92m${i.toString()}\x1B[97m]:\x1B[0m\x1B[0m \x1B[96m${list[i].toString()}\x1B[0m', wrapWidth: 99999) : debugPrint('\x1B[97mIndex[\x1B[0m\x1B[92m${i.toString()}\x1B[97m]:\x1B[0m\x1B[0m \x1B[96m${jsonEncode(list[i]).toString()}\x1B[0m', wrapWidth: 99999);
  }
  //! Random Color
  // for (var i = 0; i < list.length; i++) {
  //   isJsonList == false ? debugPrint('\x1B[9${i + 2}m${list[i].toString()}\x1B[0m', wrapWidth: 99999) : debugPrint('\x1B[9${i + 2}m${jsonEncode(list[i]).toString()}\x1B[0m', wrapWidth: 99999);
  // }
}

/// Internal function to print colored messages based on platform.
void _printColoredMessage(dynamic text, String colorCode) {
  if (Platform.isIOS) {
    debugPrint(text.toString(), wrapWidth: 99999);
  } else {
    debugPrint('$colorCode$text\x1B[0m', wrapWidth: 99999);
  }
}
