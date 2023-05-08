import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../../controller/movie_cubit.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key, this.movieId}) : super(key: key);

  final movieId;

  @override
  Widget build(BuildContext context) {
    var model = MovieCubit.get(context).detailsModel!;
    return Scaffold(
      body: BuildCondition(
        condition: MovieCubit.get(context).detailsModel != null,
        builder: (context) => SingleChildScrollView(
          child: Directionality(
              textDirection: MovieCubit.get(context).switchIndex == 0
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      imageDetails(model.pathImage),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 50.0),
                        child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                  titleDetails(model.title),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        releaseDateDetails(model.releaseDate),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15.0,
                        ),
                        const SizedBox(
                          width: 2.5,
                        ),
                        Text('${model.voteRange}'),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text('(${model.runTime} min)'),
                      ],
                    ),
                  ),
                  overViewDetails(model.overView),
                  genresDetails(model, context),
                ],
              )),
        ),
        fallback: (context) => defaultCircularProgress(),
      ),
    );
  }
}
