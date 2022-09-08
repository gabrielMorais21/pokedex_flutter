import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/core/database/database_helper.dart';
import 'package:pokedex_flutter/features/pokedex/presentation/bloc/pokedex_bloc.dart';

import '../../../../injection_container.dart' as di;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter BloC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) => di.sl<PokedexBloc>(),
          child: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<DataConnectionStatus>? listener;
  var Internetstatus = "Unknown";

  @override
  void initState() {
    super.initState();
    CheckInternet();

    BlocProvider.of<PokedexBloc>(context).add(LoadingSucessPokemonEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listener?.cancel();
    super.dispose();
  }

  CheckInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus = "Connected to the internet";
          print('Data connection is available.');
          setState(() {});
          break;
        case DataConnectionStatus.disconnected:
          Internetstatus = "No Data Connection";
          print('You are disconnected from the internet.');
          setState(() {});
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocListener<PokedexBloc, PokedexState>(
          listener: (context, state) {
            if (state is ErrorState) {}
          },
          child: _blocBuilder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 10,
          onPressed: () => {}),
    );
  }

  _blocBuilder() {
    return BlocBuilder<PokedexBloc, PokedexState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Center(
            child: Text("Initial"),
          );
        } else if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedSucessState) {
          return Column(
            children: <Widget>[
              Text(
                "$Internetstatus",
                style: TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 20),
              ),
              Text("Total pokemons:${state.pokemons.length}"),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.pokemons.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.blue,
                      ),
                      child: ListTile(
                        title: Text(state.pokemons[index].name),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.deepPurple,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {},
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is ErrorState) {
          return Center(child: Text("Error"));
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'nothing data :(',
              ),
            ],
          ),
        );
      },
    );
  }
}
