import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class Data {
  final String title;
  final String description;
  final String imageUrl;
  final IconData iconData;

  Data({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.iconData,
  });
}

class PView extends StatefulWidget {
  const PView({Key? key}) : super(key: key);

  @override
  _PViewState createState() => _PViewState();
}

class _PViewState extends State<PView> {
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentIndex < 3) _currentIndex++;
      _controller.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  final List<Data> myData = [
    Data(
        title: 'Title 1',
        description:
            'sfsdf sdf sdfs df sdf s fsfsdf sdf sdfs df sdf s fsfsdf sdf sdfs df sdf s f',
        imageUrl: 'images/q1.jpg',
        iconData: Icons.add_box),
    Data(
        title: 'Title 2',
        description:
            'sfsdf sdf sdfs df sdf s f sfsdf sdf sdfs df sdf s sfsdf sdf sdfs df sdf s ff',
        imageUrl: 'images/q2.jpg',
        iconData: Icons.usb_rounded),
    Data(
        title: 'Title 3',
        description: 'sfsdf sdf sdfs df sdf s f sfsdf sdf sdfs df sdf s f',
        imageUrl: 'images/q3.jpg',
        iconData: Icons.place),
    Data(
        title: 'Title 4',
        description: 'sfsdf sdf sdfs df sdf s f sfsdf sdf sdfs df sdf s f',
        imageUrl: 'images/q4.jpg',
        iconData: Icons.help),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/a': (ctx) => const MyHomePage(title: 'Flutter Demo Home Page'),
          '/b': (ctx) => const MyHomePage(title: 'Flutter Demo Home Page'),
        },
        home: Scaffold(
          body: Stack(children: [
            Builder(
              builder: (ctx) => PageView(
                controller: _controller,
                children: myData
                    .map((item) => Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage(item.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.iconData, size: 130),
                              SizedBox(height: 50),
                              Text(item.title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35)),
                              SizedBox(height: 10),
                              Text(
                                item.description,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ))
                    .toList(),
                onPageChanged: (val) {
                  setState(() {
                    _currentIndex = val;
                    if (_currentIndex == 3) {
                      Future.delayed(
                        Duration(seconds: 3),
                        () => Navigator.of(ctx).pushNamed('/a'),
                      );
                    }
                  });
                },
              ),
            ),
            Indicator(_currentIndex),
            Builder(
                builder: (ctx) => Align(
                      alignment: Alignment(0, 0.9),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          child: const Text(
                            'GEt STARTED',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pushReplacementNamed('/a');
                          },
                        ),
                      ),
                    ))
          ]),
        ));
  }
}

class Indicator extends StatelessWidget {
  final int index;
  const Indicator(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(0, index == 0 ? Colors.green : Colors.amber),
          buildContainer(1, index == 1 ? Colors.green : Colors.amber),
          buildContainer(2, index == 2 ? Colors.green : Colors.amber),
          buildContainer(3, index == 3 ? Colors.green : Colors.amber),
        ],
      ),
    );
  }

  Widget buildContainer(int i, Color tcolor) {
    return index == i
        ? Icon(Icons.local_pizza)
        : Container(
            margin: const EdgeInsets.all(10),
            height: 15,
            width: 15,
            decoration: BoxDecoration(color: tcolor, shape: BoxShape.circle),
          );
  }
}
