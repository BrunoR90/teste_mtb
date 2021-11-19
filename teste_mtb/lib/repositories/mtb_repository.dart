
import 'package:teste_mtb/models/mtb_model.dart';

abstract class MtbRepository {
  Future<MtbModel> findImage();
}