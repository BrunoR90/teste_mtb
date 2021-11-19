import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teste_mtb/models/mtb_model.dart';

import 'mtb_repository.dart';

class MtbRepositoryImpl implements MtbRepository {
  @override
  Future<MtbModel> findImage() async {
    final dio = Dio();
    const param1 = 'DEV FLUTTER';

    final authBytes = utf8.encode('CANDIDATO:DEV_TESTE@587');
    final tokenAuth = base64Encode(authBytes);

    final result = await dio.get(
      'http://mtb.no-ip.org:5190/mtb/v0100/api/RetornaPopUpTeste/$param1',
      options: Options(
        headers: {
          'authorization': 'Basic $tokenAuth',
        },
        contentType: 'application/json'
      ),
    );

    return MtbModel.fromMap(result.data);
  }
}
