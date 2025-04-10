import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ive Member List',
      home: Contact(),
    );
  }
}

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var a = 1;
  var name = ['장원영', '안유진', '가을', '이서', '레이'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Ive Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              leading: Image.asset('assets/profile.JPG'),
              title: Text('$index번째 홍길동'),
            );
          }
        ),
      ),
      bottomNavigationBar:
        Bottom(),
      floatingActionButton:
        FloatingActionButton(
        child: Text(a.toString()),
        onPressed: (){
          setState(() {
            a++;
          });
          print('a = $a');
        })
    );
  }
}

class Bottom extends StatelessWidget{
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.phone),
          Icon(Icons.message),
          Icon(Icons.contact_page)
        ],
      ),
    );
  }

}

