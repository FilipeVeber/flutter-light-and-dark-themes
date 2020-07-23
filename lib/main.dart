import 'package:flutter/material.dart';
import 'package:flutter_light_and_dark_themes/Provider/DarkThemeProvider.dart';
import 'package:flutter_light_and_dark_themes/Styles.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeProvider.darkTheme =
        await themeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, DarkThemeProvider value, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.darkTheme, context),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void toggleTheme(value) {}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Light and dark themes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Center(
              child: themeProvider.darkTheme
                  ? IconButton(
                      icon: Icon(Icons.wb_sunny),
                      onPressed: () {
                        setState(() {
                          themeProvider.darkTheme = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.brightness_2),
                      onPressed: () {
                        setState(() {
                          themeProvider.darkTheme = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
