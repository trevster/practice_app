import 'package:first_app/config.dart';
import 'package:first_app/database/database.dart';
import 'package:first_app/features/task_page/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

final MyDatabase database = MyDatabase();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.grey[400]),
            headline5: TextStyle(color: Colors.grey[400]),
            headline6: TextStyle(color: Colors.grey[400]),
            subtitle2: TextStyle(color: Colors.grey[400]),
            subtitle1: TextStyle(color: Colors.grey[400]),
            caption: TextStyle(color: Colors.grey[400]),
            bodyText1: TextStyle(color: Colors.grey[400]),
            bodyText2: TextStyle(color: Colors.grey[400]),
          )),
      home: MyHomePage(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Go to Page 2'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: TextButton(
          child: Text('Back to Page 1'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;

  final List<Widget> _pageOptions = <Widget>[
    FirstRoute(),
    TaskView(),
    PinchZoom(
      child: Image.network('http://placekitten.com/200/300'),
    ),
    AspectRatio(
      aspectRatio: 200 / 300,
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: InteractiveViewer(
          panEnabled: false,
          child: Image.network('http://placekitten.com/200/300'),
        ),
      ),
    ),
    ImageZoom(),
  ];

  final List<Widget> _titlePage = <Widget>[
    homeTitle,
    Text('Explore'),
    Text('Pinch Zoom'),
    Text('Interactive Viewer'),
    Text('Image Zoom'),
  ];

  static Widget get homeTitle {
    switch (Config.appFlavor) {
      case Flavor.DEVELOPMENT:
        return Text('Development');
      case Flavor.TESTING:
        return Text('Testing');
      case Flavor.LIVE:
        return Text('Live');
      default:
        return Text('Home');
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('halo'),
    //   ),
    //   body: Material(
    //     elevation: 1,
    //     child: ImageZoom(),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: _titlePage.elementAt(_selectedPage),
      ),
      body: Material(
        elevation: 100,
        child: Center(
          child: _pageOptions.elementAt(_selectedPage),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Icon(
              Icons.explore,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'PinchZoom',
            icon: Icon(
              Icons.pin,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Interactive Viewer',
            icon: Icon(
              Icons.image,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Interactive Viewer',
            icon: Icon(
              Icons.ten_k,
              color: Colors.grey,
            ),
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onNavBarTapped,
        fixedColor: Colors.lightBlueAccent,
      ),
    );
  }
}

class ImageZoom extends StatefulWidget {
  const ImageZoom({Key? key}) : super(key: key);

  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 700,
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                    height: 200,
                    child: Container(
                      color: Colors.blue,
                    )),
                SizedBox(
                    height: 300,
                    child: Container(
                      color: Colors.grey,
                    )),
                SizedBox(
                    height: 200,
                    child: Container(
                      color: Colors.green,
                    )),
              ],
            ),
          ),
          Positioned(
            top: 200,
            right: 0,
            left: 0,
            height: 300,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              panEnabled: false,
              child: Image.network('http://placekitten.com/200/300'),
            ),
          ),
        ],
      ),
    );
  }
}
