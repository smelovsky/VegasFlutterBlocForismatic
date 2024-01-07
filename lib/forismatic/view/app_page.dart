import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_flutter_bloc_forismatic/forismatic/forismatic.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => AppBloc(),
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forismatic'),
        actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), tooltip: 'Exit', onPressed: (){
          exit(0);
        })],
      ),
      body: Stack(
        children: [
          //AppBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Center(child: AppUrl()),
              ),
              AppActions(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Center(child: AppResult()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppUrl extends StatelessWidget {
  const AppUrl({super.key});

  @override
  Widget build(BuildContext context) {

    final url = context.select((AppBloc bloc) => bloc.state.url);

    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {

        return Column(
          children: <Widget>[

            Container(
                child: Text('URL', style: TextStyle(fontSize: 20.0,color: Colors.blue)),
                padding: EdgeInsets.all(10.0)
            ),
            Text(url),

          ],
        );
      },
    );

  }
}

class AppResult extends StatelessWidget {
  const AppResult({super.key});

  @override
  Widget build(BuildContext context) {

    final forismatic = context.select((AppBloc bloc) => bloc.state.forismatic);
    final author = context.select((AppBloc bloc) => bloc.state.author);
    final error = context.select((AppBloc bloc) => bloc.state.error);

    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {

        return Column(
          children: <Widget>[

            ...switch (state) {
              AppStateInitial() =>
              [

              ],
              AppStateResult() =>
              [
                Container(
                    child: Text('Forismatic',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                    padding: EdgeInsets.all(10.0)
                ),
                Text(forismatic),
                Container(
                    child: Text('Author',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                    padding: EdgeInsets.all(10.0)
                ),
                Text(author),
              ],
              AppStateError() =>
              [
                Container(
                    child: Text('Error',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                    padding: EdgeInsets.all(10.0)
                ),
                Text(error),
              ],
            }
          ],

        );
      },
    );
  }
}

class AppActions extends StatelessWidget {
  const AppActions({super.key});

  @override
  Widget build(BuildContext context) {

    final lang = context.select((AppBloc bloc) => bloc.state.lang);

    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {

        return Column(
          children: <Widget>[

            Row(
              children: <Widget>[
                Expanded( child:
                RadioListTile(
                  title: const Text('Eng'),
                  value: 0,
                  groupValue: lang,
                  onChanged: (int? value) {
                    context.read<AppBloc>().add(AppEventSetLang(lang: value!));
                  },
                ),
                ),
                Expanded( child:
                RadioListTile(
                  title: const Text('Rus'),
                  value: 1,
                  groupValue: lang,
                  onChanged: (int? value) {
                    context.read<AppBloc>().add(AppEventSetLang(lang: value!));
                  },
                ),
                ),
              ],
            ),

            SizedBox(height: 20.0),
            ElevatedButton(child: Text('Send request GET'), onPressed: () {
              context.read<AppBloc>().add(AppEventSendRequestGet());
              }
            ),

          ],
        );
      },
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.green.shade500,
            ],
          ),
        ),
      ),
    );
  }
}