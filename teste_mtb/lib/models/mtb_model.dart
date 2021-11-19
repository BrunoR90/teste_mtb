import 'dart:convert';

import 'package:archive/archive.dart';


class MtbModel {
  
  String returnCode;
  String returnMessage;
  dynamic image;

  MtbModel({
    required this.returnCode,
    required this.returnMessage,
    required this.image,
  });


  Map<String, dynamic> toMap() {
    return {
      'returnCode': returnCode,
      'returnMessage': returnMessage,
      'image': image,
    };
  }

  factory MtbModel.fromMap(Map<String, dynamic> map) {
    final mtb = map['mtb'];
    final codRet = mtb['codret']; 
    dynamic image;
    if(codRet == "1"){
      final listImages = mtb['retornapopupteste'];
      final fileImageZipBase64 = listImages.first['POPUP'];
      final fileImageZipBytes = base64.decode(fileImageZipBase64);
      final fileZip = ZipDecoder().decodeBytes(fileImageZipBytes);
      image = fileZip.first.content;
    }
    
    return MtbModel(
      returnCode: codRet ?? '',
      returnMessage: mtb['msgret'] ?? '',
      image: image,
    );
  }

  String toJson() => json.encode(toMap());

  factory MtbModel.fromJson(String source) => MtbModel.fromMap(json.decode(source));
}
