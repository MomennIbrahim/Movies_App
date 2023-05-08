import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/presentation/screens/movie_screens/popular.dart';
import 'package:movie_application/presentation/screens/movie_screens/top_rated.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../shared/constants/api_constatnts.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/network/local/shared_preference.dart';
import '../../components/components.dart';
import '../../controller/movie_cubit.dart';
import '../../controller/movie_state.dart';
import 'movie_details.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: BuildCondition(
          condition: MovieCubit.get(context).nowPlayingModel != null &&
              MovieCubit.get(context).popularModel != null &&
              MovieCubit.get(context).topRatedModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Directionality(
                textDirection: lang=='en'?TextDirection.ltr:TextDirection.rtl,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        defaultCarouselSlider(context,
                            text:lang == 'en'? 'NOW PLAYING':'يشاهد الآن',
                            items: MovieCubit.get(context)
                                .nowPlayingModel!
                                .list
                                .map((e) {
                              return GestureDetector(
                                onTap: () {

                                  MovieCubit.get(context)
                                      .getMovieDetails(movieId: e.id);

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return BuildCondition(
                                          condition:
                                          MovieCubit.get(context).detailsModel !=
                                              null,
                                          builder: (context) =>
                                              MovieDetailsScreen(movieId: e.id),
                                          fallback: (context) =>
                                              defaultCircularProgress(),
                                        );
                                      }));
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        child: Image(
                                          image: NetworkImage(
                                              '${AppConstants.baseImageUrl}${e.posterPath!}'),
                                          fit: BoxFit.cover,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 80.0),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text('${e.title}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()),
                        defaultRowAddress(
                            text1:lang == 'en'? 'Popular':'شائع',
                            text2: lang == 'en'? 'See More':'مشاهدة المزيد',
                            function: () {
                              defaultBottomSheet(context, const PopularScreen());
                            }),
                        moviePopular(context),
                        defaultRowAddress(
                            text1:lang == 'en'? 'Top Rated':'أعلى التقييمات',
                            text2: lang == 'en'? 'See More':'مشاهدة المزيد',
                            function: () {
                              defaultBottomSheet(
                                  context, const MovieTopRatedScreen());
                            }),
                        movieTopRated(context),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 10.0),
                      child: ToggleSwitch(
                        animate: true,
                        minWidth: 50.0,
                        initialLabelIndex: lang == 'en'?0:1,
                        minHeight: 40.0,
                        fontSize: 16.0,
                        totalSwitches: 2,
                        cornerRadius: 20.0,
                        onToggle: (value){
                          MovieCubit.get(context).toggleSwitch(context);
                          CachedHelper.saveData(key: 'lang', value: lang).then((value){
                            MovieCubit.get(context).getNowPlayingData();
                            MovieCubit.get(context).getPopularData();
                            MovieCubit.get(context).getTopRatedData();
                          });
                        },
                        labels: const ['EN','AR'],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => defaultCircularProgress(),
        ));
      },
    );
  }
}

