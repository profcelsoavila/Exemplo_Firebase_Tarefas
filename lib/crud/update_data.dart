import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateRecord extends StatefulWidget {
  //variável para armazenar a chave de um registro do banco de dados
  //A chave do registro é gerada automaticamente no banco de dados
  final String projetoKey;
  //o método contrutor necessita da chave do registro do banco de dados
  const UpdateRecord({Key? key, required this.projetoKey}) : super(key: key);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  //campo de entrada de dados
  final nomeProjetoController = TextEditingController();
  final etapaController = TextEditingController();
  final dataEntregaController = TextEditingController();
  final statusController = TextEditingController();
// referência ao banco de dados
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    //aponta para o elemento projetos do banco de dados
    dbRef = FirebaseDatabase.instance.ref().child('projetos');
    getTaskData();
  }

  void getTaskData() async {
    //obtém os dados do projeto através de seua chave no banco de dados
    DataSnapshot snapshot = await dbRef.child(widget.projetoKey).get();
//mapeia os dados do snpashot para serem exibidos nos campos de formulário
    Map projetos = snapshot.value as Map;
//carrega os dados mapeados para os campos de formulário
    nomeProjetoController.text = projetos['nome'];
    etapaController.text = projetos['etapa'];
    dataEntregaController.text = projetos['data_entrega'];
    statusController.text = projetos['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar tarefa'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Atualizando tarefa no Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
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
                height: 30,
              ),
              TextField(
                controller: etapaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Etapa',
                  hintText: 'Digite a etapa do projeto',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: dataEntregaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data da Entrega',
                  hintText: 'Digite a data da entrega da etapa',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: statusController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status',
                  hintText: 'Digite o status da tarefa',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  //mapeia os dados dos campos de formulário
                  Map<String, String> projetos = {
                    'nome': nomeProjetoController.text,
                    'etapa': etapaController.text,
                    'data_entrega': dataEntregaController.text,
                    'status': statusController.text
                  };
                  //atualiza no banco de dados, na chave do registro correspondente e retorna para a tela anterior
                  setState(() {
                    dbRef
                        .child(widget.projetoKey)
                        .update(projetos)
                        .then((value) => {Navigator.pop(context)});
                  });
                },
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
                child: const Text('Atualizar tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
