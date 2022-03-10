import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HttpClientApi(),
    );
  }
}
class HttpClientApi extends StatefulWidget {
  const HttpClientApi({ Key? key }) : super(key: key);

  @override
  State<HttpClientApi> createState() => _HttpClientApiState();
}

class _HttpClientApiState extends State<HttpClientApi> {
  
   Future request()async{
     try{
        HttpClient httpClient=HttpClient();
        HttpClientRequest request=await httpClient.getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        request.headers.add('token', 'tokenstring');
        HttpClientResponse response=await request.close();
        var data = await response.transform(const Utf8Decoder()).join();        
       // debugPrint(data);       
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            content: Container(
            color: const Color.fromARGB(255, 162, 164, 179),            
            child: Text(data),
          )));
        httpClient.close();        
        }
        catch(e){'Request fail$e';}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text('Api using HttpClient'),
            ),
            body: Column(
              children: [               
                Center(child: ElevatedButton(onPressed: (){                  
                      request();
                },child: const Text('Get Data'),)),
              ],
            ),
    );
  }
}