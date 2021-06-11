import 'package:flutter/material.dart';
import 'package:practicadeformulario/pages/new_comment_page.dart';
import 'package:practicadeformulario/models/comment_models.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica'),
      ),
      body: FutureBuilder(
        future: traerInformacion(),
        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final comments = snapshot.data;
            return listaComentario(comments);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list_alt_rounded),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewCommentPage()));
        },
      ),
    );
  }

  ListView listaComentario(List<Comment> comments) {
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = comments[index];
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.comment,
                  size: 38,
                ),
                title: Text(
                  comment.email,
                ),
                subtitle: Text(comment.name),
                trailing: Icon(
                  Icons.send_outlined,
                ),
              ),
              Divider()
            ],
          );
        });
  }

  Future<List<Comment>> traerInformacion() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final comment = commentFromJson(response.body);
      return comment;
    } else {
      return null;
    }
  }
}
