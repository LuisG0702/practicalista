import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practicadeformulario/models/comment_models.dart';

// ignore: must_be_immutable
class NewCommentPage extends StatelessWidget {
  final comentario = new Comment(postId: '1', body: 'jeje');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nuevo comentario'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Divider(),
              TextField(
                  autofocus: true,
                  onChanged: (newValue) {
                    comentario.name = newValue;
                  },
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ('Nombre'),
                    prefixIcon: Icon(Icons.person),
                  )),
              Divider(),
              TextField(
                  onChanged: (newValue) {
                    comentario.email = newValue;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ('correo electronico'),
                    prefixIcon: Icon(Icons.email),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    print(comentario.toJson());
                    await registrarComentario(comentario.toJson());
                  },
                  child: Text('GUARDAR'))
            ],
          ),
        ),
      ),
    );
  }

  Future<Comment> registrarComentario(Map json) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    final response = await http.post(
      url,
      body: json,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return null;
  }
}
