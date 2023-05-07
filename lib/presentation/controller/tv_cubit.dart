import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/presentation/controller/tv_state.dart';
import '../../models/tv_details_model.dart';
import '../../models/tv_model.dart';
import '../../shared/constants/api_constatnts.dart';
import '../../shared/network/remote/remote.dart';

class TvCubit extends Cubit<TvStates> {
  TvCubit() : super(InitialState());

  static TvCubit get(context) => BlocProvider.of(context);

  TvModel? tvOnAirModel;

  void getTvOnAirData() {
    emit(GetLoadingTvOnAirData());
    DioHelper.getData(
        url: AppConstants.tvOnAir,
    )
        .then((value) {
      tvOnAirModel = TvModel.fromJson(value.data);
      emit(GetSuccessTvOnAirData());
    })
        .catchError((error) {
      emit(GetErrorTvOnAirData(error.toString()));
      print(error.toString());
    });
  }

  TvModel? tvPopularModel;

  void getTvPopularData(){

    emit(GetLoadingTvPopularData());
    DioHelper.getData(
        url: AppConstants.tvPopular,
        ).then((value) {
      tvPopularModel = TvModel.fromJson(value.data);
      emit(GetSuccessTvPopularData());
    })
        .catchError((error) {
      emit(GetErrorTvPopularData(error.toString()));
      print(error.toString());
    });
  }

  TvModel? tvTopRatedModel;

  void getTvTopRatedData(){

    emit(GetLoadingTvTopRatedData());
    DioHelper.getData(
        url: AppConstants.tvTopRated
      ,).then((value) {
      tvTopRatedModel = TvModel.fromJson(value.data);
      emit(GetSuccessTvTopRatedData());
    })
        .catchError((error) {
      emit(GetErrorTvTopRatedData(error.toString()));
      print(error.toString());
    });
  }

  TvDetailsModel? tvDetailsModel;

  void getTvDetailsData({required tvId}){

    emit(GetLoadingTvDetailsData());

    DioHelper.getData(
        url:
        'https://api.themoviedb.org/3/tv/$tvId?api_key=6b95535dcef0dd4e6401b7cf552c8865')
        .then((value) {
      tvDetailsModel = TvDetailsModel.fromJson(value.data);
      print(tvDetailsModel!.id);
      emit(GetSuccessTvDetailsData());
    }).catchError((error) {
      emit(GetErrorTvDetailsData(error.toString()));
      print(error.toString());
    });
  }
}
