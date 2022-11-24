import 'package:flutter/material.dart';
import 'cat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          primarySwatch: Colors.red,
          useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Cat> futureCat;

  @override
  void initState() {
    super.initState();
    loadNewCat();
  }

  void loadNewCat() {
    futureCat = fetchNonExistentCat();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return FutureBuilder<Cat>(
      future: futureCat,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(snapshot.data!.name),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: loadNewCat,
                tooltip: 'Generate a new Cat',
                child: const Icon(Icons.pets),
              ),
              body: SingleChildScrollView(child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.memory(snapshot.data!.imageBuffer),
                      ),
                      Card(
                        child: Padding(padding: const EdgeInsets.all(16.0), child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                          Text("${snapshot.data!.name}'s Personality is", textAlign: TextAlign.left),
                          Text(snapshot.data!.personality, textScaleFactor: 2, textAlign: TextAlign.right),
                        ]))
                      ),
                      Card(
                        child: Padding(padding: const EdgeInsets.all(16.0), child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                          Text("${snapshot.data!.name}'s Favourite activities are", textAlign: TextAlign.left),
                          ...snapshot.data!.favouriteActivities.map((a) => Text(a, textScaleFactor: 2, textAlign: TextAlign.right))
                        ]))
                      ),
                      Card(
                        child: Padding(padding: const EdgeInsets.all(16.0), child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                          Text("${snapshot.data!.name}'s Disliked activities are", textAlign: TextAlign.left),
                          ...snapshot.data!.dislikedActivities.map((a) => Text(a, textScaleFactor: 2, textAlign: TextAlign.right))
                        ]))
                      ),
                    ],
                  ))));
        }

        return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            )),
            floatingActionButton: FloatingActionButton(
              onPressed: loadNewCat,
              tooltip: 'Generate a new Cat',
              child: const Icon(Icons.pets),
            ),
          );
      },
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
