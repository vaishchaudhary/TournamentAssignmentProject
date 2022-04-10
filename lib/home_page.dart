import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_design/home_page_bloc.dart';
import 'package:tournament_design/tournament_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageBloc _homePageBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _homePageBloc,
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomePageLoadedState)
            return content(state.tournamentData);
          else {
            return Center(child: Text('Error while fetching Data'));
          }
        },
      ),
    );
  }

  Widget content(TournamentData tournamentData) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _header(),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tournamentData.data?.tournaments?.length ?? 0,
                itemBuilder: (context, index) {
                  Tournaments? data = tournamentData.data?.tournaments?[index];
                  return Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Stack(
                          children: [
                            Image.network(data!.coverUrl!,fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width -20.0,
                              height: 200.0,
                            ),
                            Positioned(
                              bottom: 0.0,
                              child:Container(
                                padding: EdgeInsets.all(15.0),
                                width: MediaQuery.of(context).size.width -20.0,
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Text(data.name!,
                                          style: TextStyle(fontSize: 18.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10.0),
                                     Text(data.gameName!,
                                         style: TextStyle(fontSize: 14.0,
                                             fontWeight: FontWeight.w500,
                                             color: Colors.black54)),
                                   ],
                                ),
                              )
                            )
                          ],
                        ),
                      )
                  );
                })
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    _homePageBloc.loadHomeData();
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.storage),
            Expanded(
                child: Text('FlyingWolf',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center))
          ],
        ),
        const SizedBox(height: 30.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 40.0, backgroundImage: AssetImage('assets/logo.jpeg')),
            const SizedBox(width: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Text('Simon Baker',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                const SizedBox(height: 10.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '2250   ',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: 'Elo Rating',
                        style: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.amber.shade600,
                  Colors.deepPurple.shade400,
                  Colors.red.shade800,
                ],
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  // color: Colors.amber.shade600,
                  child: Text('34\nTournaments\nplayed',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text('09\nTournaments\nWon',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text('29%\nWinning\npercentage',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Text('Recommanded for you',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
