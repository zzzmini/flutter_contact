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
  var like = [0,0,0,0,0];

  // 장원영 좋아요 수 증가(showDialog에서...)
  addJangLike(){
    setState(() {
      like[0] = like[0] + 2;
    });
  }

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
          itemCount: name.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: Image.asset('assets/profile.JPG'),
              title: Text(name[index]),
              trailing: TextButton(
                onPressed: (){
                  // 좋아요 증가시키기
                  setState(() {
                    like[index]++;
                  });
                },
                child: Text('❤ ${like[index]}',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20
                  ) ,
                )
              ),
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

          // Dialog 창 띄우기
          showDialog(
            context: context,
            builder: (context)=>
              DialogUI(
                jangLike: like[0],
                addJangLike : addJangLike,
              )
          );
        })
    );
  }
}

class DialogUI extends StatelessWidget{
  const DialogUI({super.key, this.jangLike, this.addJangLike});
  // 부모가 전달한 값을 받는 변수(리액트 props)
  final jangLike;
  final addJangLike;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(),
            TextButton(
              onPressed: (){
                // 누르면 장원영 좋아요 2 증가
                addJangLike();
                Navigator.pop(context);
              },
              child: Text('장원영 좋아요 수? ${jangLike}')),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('돌아가기'))
          ],
        ),
      ),
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

