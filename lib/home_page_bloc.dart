import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_design/home_page_repository.dart';
import 'package:tournament_design/tournament_response.dart';

class HomePageBloc extends Cubit<HomePageState>{
  HomePageRepository _homePageRepository = HomePageRepository();
  HomePageBloc() : super(HomePageLoadingState());

  Future<void> loadHomeData() async {
    emit(HomePageLoadingState());
    try{
      TournamentData tournamentData = await _homePageRepository.getTournamentListData();
      emit(HomePageLoadedState(tournamentData));
    }catch(exp){
      emit(HomePageErrorState());
    }
  }
}

class HomePageState{}
class HomePageLoadingState extends HomePageState{}
class HomePageLoadedState extends HomePageState{
  final TournamentData tournamentData;

  HomePageLoadedState(this.tournamentData);
}
class HomePageErrorState extends HomePageState{}
