import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  //campos para entrada de dados
  final nomeProjetoController = TextEditingController();
  final etapaController = TextEditingController();
  final dataEntregaController = TextEditingController();
  final statusController = TextEditingController();
//referência ao banco de dados
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    //aponta para o nó projetos
    dbRef = FirebaseDatabase.instance.ref().child('projetos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar tarefa'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Inserindo dados no Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: nomeProjetoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do projeto',
                  hintText: 'Digite o nome do projeto',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: etapaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Etapa',
                  hintText: 'Digite a etapa da tarefa',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: dataEntregaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data da Entrega',
                  hintText: 'Digite a data da entrega da tarefa',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: statusController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status',
                  hintText: 'Digite o status atual da tarefa',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  //mapeia os dados de entrada do formulário
                  Map<String, String> projetos = {
                    'nome': nomeProjetoController.text,
                    'etapa': etapaController.text,
                    'data_entrega':dataEntregaController.text,
                    'status': statusController.text
                  };

                  //envi os dados para o banco de dados e retorna para a tela inicial
                  dbRef.push().set(projetos).then((value) {
                    Navigator.pop(context);
                  });
                },
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
                child: const Text('Inserir Dados'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
