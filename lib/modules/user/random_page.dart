import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_flutter/blocs/random_bloc.dart';

class RandomPage extends StatefulWidget {
  RandomPage({Key key}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final Random random = Random();
  RandomBloc _randomBloc;
  ResetBloc _resetBloc;

  @override
  void initState() {
    super.initState();
    _randomBloc = BlocProvider.of<RandomBloc>(context);
    _resetBloc = BlocProvider.of<ResetBloc>(context);
    // _randomBloc.add(random.nextInt(101));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey, title: Text("Random Number")),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            _randomTextBlocBuilder(),
            _resetTextBlocBuilder(),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Random'),
                  onPressed: () {
                    _randomBloc.add(random.nextInt(101));
                  },
                ),
                SizedBox(width: 24),
                RaisedButton(
                  child: Text('Reset'),
                  onPressed: () {
                    _resetBloc.add(RandomBlocEnum.reset);
                  },
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    _resetBloc.close();
    _randomBloc.close();
    super.dispose();
  }

  BlocBuilder _randomTextBlocBuilder() {
    return BlocBuilder<RandomBloc, String>(builder: (context, randomString) {
      return Text(
        randomString,
        style: TextStyle(fontSize: 32),
      );
    });
  }

  BlocBuilder _resetTextBlocBuilder() {
    return BlocBuilder<ResetBloc, String>(builder: (context, resetString) {
      return Material(
        child:
            Container(child: Text(resetString, style: TextStyle(fontSize: 32))),
      );
    });
  }
}
