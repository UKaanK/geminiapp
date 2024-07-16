import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminialapp/models/message.dart';
import 'package:geminialapp/utilites/themenotifier.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key:key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Message> _messages = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello", isUser: false),
    Message(text: "Great", isUser: true),
    Message(text: "excellent", isUser: false)
  ];
  TextEditingController _controller=TextEditingController();

  callGeminiModel()async{

    try {
      if(_controller.text.isNotEmpty){
        _messages.add(Message(text: _controller.text, isUser: true));
      }
       final model = GenerativeModel(model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
    final prompt = _controller.text.trim();
    final content=[Content.text(prompt)];
    final response = await model.generateContent(content);


    setState(() {
      _messages.add(Message(text: response.text!, isUser: false));
    });
    _controller.clear();
    } catch (e) {
      print("Error"+e.toString());
    }

   
  }
  
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/gemini.png',width: 30,),
                SizedBox(width: 10,),
                Text('Gemini Gpt', style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            GestureDetector(
                child: (currentTheme == ThemeMode.dark) ? Icon(Icons.light_mode, color: Theme.of(context).colorScheme.secondary,) : Icon(Icons.dark_mode,  color: Theme.of(context).colorScheme.primary,),
              onTap: (){
                  ref.read(themeProvider.notifier).toggleTheme();
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context,index){
                final message =_messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser?Alignment.centerRight:Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isUser ?
                         Theme.of(context).colorScheme.primary:
                          Theme.of(context).colorScheme.secondary,
                        borderRadius: message.isUser ?
                        BorderRadius.only(
                          topLeft:Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          ):
                        BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          )
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser? Colors.white:Colors.black
                        ),
                        )),
                  ),
                );
              }
              ),
          ),
        
          Padding(
            padding: const EdgeInsets.only(bottom:32.0,left:16,right:16,top:16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Write your message",
                        hintStyle: TextStyle(color: Colors.black,),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward,color: Colors.blue,),
                        onTap: () => callGeminiModel(),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}