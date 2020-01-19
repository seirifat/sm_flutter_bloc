import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_flutter/blocs/random_bloc.dart';
import 'package:sm_flutter/blocs/user_bloc.dart';
import 'package:sm_flutter/modules/user/random_page.dart';
import 'package:sm_flutter/services/states.dart';
import 'package:sm_flutter/widgets/user_card.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Random random = Random();
  UserBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey, title: Text("MVVM Bloc Flutter")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Random User"),
            onPressed: () {
              _bloc.add(GetDetailUserEvent(random.nextInt(10) + 1));
            },
          ),
          _userBlocBuilder()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  BlocBuilder _userBlocBuilder() {
    return BlocBuilder<UserBloc, ServiceState>(
        builder: (context, serviceState) {
      if (serviceState is DidLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (serviceState is DidSuccessState) {
        return InkWell(
            onTap: () {
              _pushRandomPage();
            },
            child: UserCard(serviceState.result));
      } else if (serviceState is DidFailureState) {
        return Container(child: Text(serviceState.error));
      }
      // Init
      return Container();
    });
  }

  void _pushRandomPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<RandomBloc>(create: (BuildContext context) => RandomBloc()),
          BlocProvider<ResetBloc>(create: (BuildContext context) => ResetBloc())
        ],
        child: RandomPage(),
      );
    }));
  }
}
