import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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
      home: MyContact(),
    );
  }
}

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  var a = 1;
  var name = ['장원영', '안유진', '가을', '이서', '레이'];
  var like = [0,0,0,0,0];

  // 주소록에서 이름 얻어오기
  getContact() async{
    List<Contact> contacts = await
      FlutterContacts.getContacts(withProperties: true);
    print(contacts);
  }

  getPermission() async{
    var status = await Permission.contacts.status;
    if(status.isGranted){
      print('주소록 가져오는거 허락됨');
      getContact();
    } else {
      print('주소록 가져오는거 거절함');
      Permission.contacts.request();
    }
    if(status.isPermanentlyDenied){
      openAppSettings();
    }
  }


  // 장원영 좋아요 수 증가(showDialog에서...)
  addJangLike(){
    setState(() {
      like[0] = like[0] + 2;
    });
  }

  // 텍스트 필드에서 입력받은 내용을 리스트에 추가
  addMember(newMember){
    setState(() {
      name.add(newMember);
      like.add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Ive Contact List'),
        actions: [
          IconButton(
            onPressed: (){
              getPermission();
            },
            icon: Icon(Icons.contacts)
          )
        ],
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
                addMember : addMember,
              )
          );
        })
    );
  }
}

class DialogUI extends StatelessWidget{
  DialogUI({super.key, this.jangLike, this.addJangLike, this.addMember});
  // 부모가 전달한 값을 받는 변수(리액트 props)
  final jangLike;
  final addJangLike;
  final addMember;

  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: inputData,
            ),
            TextButton(
              onPressed: (){
                // 누르면 장원영 좋아요 2 증가
                addJangLike();
                Navigator.pop(context);
              },
              child: Text('장원영 좋아요 수? ${jangLike}')),
            TextButton(
              onPressed: (){
                // 추가 기능
                addMember(inputData.text);
                Navigator.pop(context);
              },
              child: Text('추가하기')),
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

