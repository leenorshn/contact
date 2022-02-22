import 'package:contact/api/post_api.dart';
import 'package:contact/models/post.dart';
import 'package:contact/servicee/contact.dart';
import 'package:contact/servicee/contact_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  await PostApi().getPost();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.blueGrey[100]),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contact"),
      ),
      body: StreamBuilder<List<Post>?>(
          stream: PostApi().getPost().asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 140,
                left: 16,
                right: 16,
              ),
              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return Card(
                  elevation: 0.7,
                  margin: const EdgeInsets.only(top: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    title: Text(post.title),
                    leading: Text(post.id.toString()),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post.body,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ContactProvider().createContact(
              Contact(name: "Victor shukuru", phone: "09781`54329"));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
