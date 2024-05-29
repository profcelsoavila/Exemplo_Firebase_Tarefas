import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:app_tarefas_fb/crud/update_data.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  //referência que aponta para o nó projetos
  //Usada para retornar todos os dados do nó projetos
  Query dbRef = FirebaseDatabase.instance.ref().child('projetos');
  //referência usada para apontar para um nó específico de projetos
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('projetos');

  //widget usado para listar todos os projetos cadastrados em Cards
  //para a criação deste widget, é necessário passar o mapeamento do projeto e a chave do registro
  Widget listItem({required Map projetos, required String key}) {
    return Card(
      margin: const EdgeInsets.all(10),
      //lista para os dados de cada registro
      child: ListTile(
        leading: Icon(Icons.assignment, color: Theme.of(context).primaryColor),
        title: Text(projetos['nome']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Etapa: ' + projetos['etapa']),
            Text('Data de Entrega: ' + projetos['data_entrega']),
            Text('Status: ' + projetos['status']),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateRecord(projetoKey: key)));
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                  reference.child(key).remove();
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.red[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta de tarefas'),
        ),
        body:SizedBox(
          height: double.infinity,
          //widget para carregar os dados em uma pequena animação
          child: FirebaseAnimatedList(
            //consulta todos os registros do banco de dados
            query: dbRef,
            //percorre cada item da lista, armazenadndo-os em um snapshot
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              //mapeia o snapshot obtido
              Map projeto = snapshot.value as Map;
              //faz key receber a chave do registro, se for vazia, atribui espaço em branco
              String key = snapshot.key ?? '';
              //retorna listItem com os dados obtidos
              return listItem(projetos: projeto, key: key);
            },
          ),
        ));
  }
}
