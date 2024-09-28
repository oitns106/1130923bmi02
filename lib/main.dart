import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context)=>S.of(context).title1,
      //title: 'Flutter Demo',
      //theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //  useMaterial3: true,
      //),
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.light(
          primary: Colors.amber,
          secondary: Colors.pinkAccent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
          titleTextStyle: TextStyle(color: Colors.deepPurpleAccent,
            fontSize: 20,),
          iconTheme: IconThemeData(color: Colors.grey,),
          toolbarTextStyle: TextStyle(color: Colors.deepPurpleAccent,
            fontSize: 20,),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: BeveledRectangleBorder(),    //斜面圆角矩形
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        colorScheme: ColorScheme.dark(primary: Colors.purple,
          secondary: Colors.red,
        ),
      ),
      home: const Screen1(),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  String image1='assets/main.png';
  bool isEnter=false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (isEnter==false) {
        isEnter=true;
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title1)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (isEnter==false) {
                  isEnter = true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage(title: 'Flutter Demo Home Page')));
                }
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 5,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: AssetImage(image1)),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('${S.of(context).firstTitle}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30,
                fontFamily: "kai",
                color: Colors.amber,
                fontWeight: FontWeight.bold,),),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                if (isEnter==false) {
                  isEnter = true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage(title: 'Flutter Demo Home Page')));
                }
              },
              child: Text('${S.of(context).firstButton}'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final heightController=TextEditingController();
  final weightController=TextEditingController();
  double? result1;
  var status;
  bool validateh=false, validatew=false;
  bool visible1=true;

  @override
  void dispose() {
    super.dispose();
    heightController.dispose();
    weightController.dispose();
  }

  void calculateBMI() {
    setState(() {
      double h=double.parse(heightController.text)/100;
      double w=double.parse(weightController.text);
      result1=w/(h*h);
      if (result1!<18.5) status="${S.of(context).status01}";
      else if (result1!>24) status="${S.of(context).status03}";
      else status="${S.of(context).status02}";
    });
  }

  Color? getTextColor(var s1) {
    if (s1=="${S.of(context).status02}") return Colors.green;
    else if (s1=="${S.of(context).status01}") return Colors.amber;
    else return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '${S.of(context).height1}',
                hintText: 'cm',
                errorText: validateh? '${S.of(context).error_text}': null,
                icon: Icon(Icons.trending_up),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '${S.of(context).weight1}',
                hintText: 'Kg',
                errorText: validatew? '${S.of(context).error_text}': null,
                icon: Icon(Icons.trending_down),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: Text('${S.of(context).button1}',
                style: TextStyle(fontFamily: "kai", color: Colors.brown),),
              onPressed: () {
                setState(() {
                  heightController.text.isEmpty? validateh=true : validateh=false;
                  weightController.text.isEmpty? validatew=true : validatew=false;
                  visible1=(validateh||validatew)? false:true;
                  if (visible1) calculateBMI();
                  else {
                    result1=null;
                    status=null;
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: Text("${S.of(context).warning}"),
                        content: Text("${S.of(context).popup_message}"),
                        actions: [
                          TextButton(
                            onPressed: ()=>Navigator.pop(context),
                            child: Text("OK"),),
                        ],
                      );
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 22),),
            ),
            SizedBox(height: 20,),


            Visibility(
              visible: visible1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result1==null? "":"${S.of(context).status00}=${result1!.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.blueAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5,),
                    RichText(text: TextSpan(style:TextStyle(color: Colors.blueAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                      children:[
                        TextSpan(text: status==null? "":"${S.of(context).status00}"),
                        TextSpan(text: status==null? "":"$status",
                          style:TextStyle(color: getTextColor(status),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              ),
            ),

//          Text(status==null? "":"您的狀態為：${status}",       //同一顏色
//               style: TextStyle(color: Colors.blue,
//                                fontSize: 22,
//                                fontWeight: FontWeight.w500),
//          ),
          ],
        ),
      ),
    );
  }
}
