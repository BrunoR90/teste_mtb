import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teste_mtb/models/mtb_model.dart';
import 'package:teste_mtb/repositories/mtb_repository.dart';
import 'package:teste_mtb/repositories/mtb_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MtbRepository _repository = MtbRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTB Teste'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final model = await _repository.findImage();

              if (model.returnCode != '1') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(model.returnMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                _showDialogImage(model);
              }
            } catch (e, s) {
              log('Erro ao buscar imagem', error: e, stackTrace: s);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Erro ao buscar imagem'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Buscar Imagem'),
        ),
      ),
    );
  }

  void _showDialogImage(MtbModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('MTB Teste'),
          content: Image.memory(model.image),
        );
      },
    );
  }
}
