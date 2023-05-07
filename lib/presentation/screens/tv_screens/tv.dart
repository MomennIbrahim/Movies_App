import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/presentation/screens/tv_screens/tv_details.dart';
import 'package:movie_application/presentation/screens/tv_screens/tv_popular_screen.dart';
import 'package:movie_application/presentation/screens/tv_screens/tv_top_rated.dart';
import '../../../shared/constants/api_constatnts.dart';
import '../../components/components.dart';
import '../../controller/tv_cubit.dart';
import '../../controller/tv_state.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TvCubit, TvStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: BuildCondition(
          condition: TvCubit.get(context).tvOnAirModel != null &&
              TvCubit.get(context).tvPopularModel != null &&
              TvCubit.get(context).tvTopRatedModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  defaultCarouselSlider(context,
                      text: 'ON THE AIR',
                      items: TvCubit.get(context).tvOnAirModel!.list.map((e) {
                        return GestureDetector(
                          onTap: () {
                            TvCubit.get(context).getTvDetailsData(tvId: e.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TvDetailsScreen(tvId: e.id)));
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: Image(
                                image: NetworkImage(
                                    '${AppConstants.baseImageUrl}${e.posterPath!}'),
                                fit: BoxFit.cover,
                              )),
                        );
                      }).toList()),
                  defaultRowAddress(
                      text1: 'Popular',
                      text2: 'See More',
                      function: () {
                        defaultBottomSheet(context, const TvPopularScreen());
                      }),
                  tvPopular(context),
                  defaultRowAddress(
                    text1: 'Top Rated',
                    text2: 'See More',
                    function: () {
                      defaultBottomSheet(context, const TvTopRatedScreen());
                    },
                  ),
                  tvTopRated(context),
                ],
              ),
            );
          },
          fallback: (context) => defaultCircularProgress(),
        ));
      },
    );
  }
}
