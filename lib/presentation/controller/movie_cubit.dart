import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/movie_details_model.dart';
import '../../models/movie_model.dart';
import '../../shared/constants/api_constatnts.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';
import '../screens/movie_screens/movie.dart';
import '../screens/tv_screens/tv.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(InitialState());

  static MovieCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    const MovieScreen(),
    const TvScreen(),
  ];

  int switchIndex = 1;

  void toggleSwitch() {
    if (switchIndex == 1) {
      switchIndex = 0;
      lang = 'en';
    } else if(switchIndex == 0) {
      switchIndex = 1;
      lang = 'ar';
    }
    CachedHelper.saveData(key: 'lang', value: lang).then((value){
      getNowPlayingData();
      getPopularData();
      getTopRatedData();
    });
    emit(ToggleSwitchState());
  }

  MovieModel? nowPlayingModel;

  void getNowPlayingData({language='ar'}) {
    emit(GetLoadingNowPlayingMovieData());
    DioHelper.getData(url: AppConstants.movieNowPlaying, lang: lang!)
        .then((value) {
      nowPlayingModel = MovieModel.fromJson(value.data);
      emit(GetSuccessNowPlayingMovieData());
    }).catchError((error) {
      emit(GetErrorNowPlayingMovieData(error.toString()));
    });
  }

  MovieModel? popularModel;

  void getPopularData({language}) {
    emit(GetLoadingPopularMovieData());
    DioHelper.getData(url: AppConstants.moviePopular, lang: lang!).then((value) {
      popularModel = MovieModel.fromJson(value.data);
      emit(GetSuccessPopularMovieData());
    }).catchError((error) {
      emit(GetErrorPopularMovieData(error.toString()));
    });
  }

  MovieModel? topRatedModel;

  void getTopRatedData({language}) {
    emit(GetLoadingTopRatedMovieData());
    DioHelper.getData(url: AppConstants.movieTopRated, lang: lang!)
        .then((value) {
      topRatedModel = MovieModel.fromJson(value.data);
      emit(GetSuccessTopRatedMovieData());
    }).catchError((error) {
      emit(GetErrorTopRatedMovieData(error.toString()));
    });
  }

  DetailsModel? detailsModel;

  void getMovieDetails({movieId}) {
    emit(GetLoadingDetailsMovieData());
    DioHelper.getData(
            url:
                'https://api.themoviedb.org/3/movie/$movieId?api_key=6b95535dcef0dd4e6401b7cf552c8865',
            lang: lang!)
        .then((value) {
      detailsModel = DetailsModel.fromJson(value.data);
      emit(GetSuccessDetailsMovieData());
    }).catchError((error) {
      emit(GetErrorDetailsMovieData(error.toString()));
      print(error.toString());
    });
  }
}
