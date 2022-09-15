import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool reRender = true;

  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFFFFFFF)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
      ),
    );
  }

  _renderContent(context) {
    String text = 'Click';
    return Column(
      children: [
        __renderCart(context, '1', FlipCardController()),
        __renderCart(context, '2', FlipCardController()),
        __renderCart(context, '3', FlipCardController()),
        __renderCart(context, '4', FlipCardController()),
        GestureDetector(
          onTap: () {
            _reRender();
          },
          child: Text('$text $reRender', style: TextStyle(fontSize: 20, color: Colors.black),),
        )
      ],
    );
  }

  Widget __renderCart(BuildContext context, String key, FlipCardController controller) {
    return Row(
      children: [
        FlipCard(
          key: Key('1'),
          controller: controller,
          direction: FlipDirection.HORIZONTAL,
          side: CardSide.FRONT,
          speed: 1000,
          onFlipDone: (status) {
            print(status);
          },
          front: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xFF006666),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Front', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          back: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xFF006666),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Back', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            controller.toggleCard();
          },
          child: Text('Flip', style: TextStyle(fontSize: 20, color: Colors.black),),
        )
      ],
    );
  }

  _reRender() {
    setState(() {
      reRender = !reRender;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('FlipCard'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              _renderAppBar(context),
              _renderContent(context)
            ],
          )
        ],
      ),
    );
  }
}
