import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constants/api_constatnts.dart';
import '../controller/movie_cubit.dart';
import '../controller/tv_cubit.dart';
import '../screens/movie_screens/movie_details.dart';
import '../screens/tv_screens/tv_details.dart';

defaultAppbar(context, {required text}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(text),
    centerTitle: true,
    elevation: 0.5,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new)),
  );
}

defaultText({required String text, double? size, fontWeight, color}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

defaultRowAddress({text1, text2, Function? function}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        defaultText(
          text: text1,
          size: 18.0,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            function!();
          },
          child: Row(
            children: [
              defaultText(text: text2, size: 15.0),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

defaultCarouselSlider(context, {required items, required text}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[100]!,
                  Colors.grey[100]!,
                  Colors.grey[100]!,
                  Colors.transparent,
                ]).createShader(bounds);
          },
          child: CarouselSlider(
            items: items,
            options: CarouselOptions(
              height: 500.0,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 7.5,
            backgroundColor: Colors.red.withOpacity(.8),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ],
      ),
    ],
  );
}

// Movie screen..
moviePopular(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 170.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {

                  MovieCubit.get(context).getMovieDetails(
                      movieId:
                      MovieCubit.get(context).popularModel!.list[index].id);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BuildCondition(
                      condition: MovieCubit.get(context).detailsModel != null,
                      builder: (context) => MovieDetailsScreen(
                          movieId: MovieCubit.get(context)
                              .popularModel!
                              .list[index]
                              .id),
                      fallback: (context) => defaultCircularProgress(),
                    );
                  }));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                      image: NetworkImage(
                          '${AppConstants.baseImageUrl}${MovieCubit.get(context).popularModel!.list[index].posterPath}')),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemCount: MovieCubit.get(context).popularModel!.list.length),
    ),
  );
}
movieTopRated(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 170.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {

                  MovieCubit.get(context).getMovieDetails(
                      movieId: MovieCubit.get(context)
                          .topRatedModel!
                          .list[index]
                          .id);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BuildCondition(
                      condition: MovieCubit.get(context).detailsModel != null,
                      builder: (context) => MovieDetailsScreen(
                        movieId: MovieCubit.get(context)
                            .topRatedModel!
                            .list[index]
                            .id,
                      ),
                      fallback: (context) => defaultCircularProgress(),
                    );
                  }));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                      image: NetworkImage(
                          '${AppConstants.baseImageUrl}${MovieCubit.get(context).topRatedModel!.list[index].posterPath}')),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemCount: MovieCubit.get(context).topRatedModel!.list.length),
    ),
  );
}

//Tv screen.
tvPopular(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 170.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  TvCubit.get(context).getTvDetailsData(
                      tvId:
                          TvCubit.get(context).tvPopularModel!.list[index].id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return BuildCondition(
                              condition: TvCubit.get(context).tvDetailsModel != null,
                              builder: (context)=>TvDetailsScreen(
                                tvId: TvCubit.get(context)
                                    .tvPopularModel!
                                    .list[index]
                                    .id,
                              ),
                              fallback: (context)=>defaultCircularProgress(),
                            );
                          }
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                      image: NetworkImage(
                          '${AppConstants.baseImageUrl}${TvCubit.get(context).tvPopularModel!.list[index].posterPath}')),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemCount: TvCubit.get(context).tvPopularModel!.list.length),
    ),
  );
}

tvTopRated(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 170.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  TvCubit.get(context).getTvDetailsData(tvId: TvCubit.get(context).tvTopRatedModel!.list[index].id);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TvDetailsScreen(tvId:TvCubit.get(context).tvTopRatedModel!.list[index].id,)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                      image: NetworkImage(
                          '${AppConstants.baseImageUrl}${TvCubit.get(context).tvTopRatedModel!.list[index].posterPath}')),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          itemCount: TvCubit.get(context).tvTopRatedModel!.list.length),
    ),
  );
}

defaultCircularProgress() {
  return const Center(
      child: CircularProgressIndicator(
    color: Colors.red,
    backgroundColor: Colors.black,
  ));
}

// See more page .
seeMoreImage(context, index, model) {
  return ClipRRect(
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.circular(10.0),
    child: SizedBox(
      width: 100.0,
      height: 150.0,
      child: Image(
        image: NetworkImage('${AppConstants.baseImageUrl}$model'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

seeMoreTitle(context, index, model) {
  return defaultText(text: '$model', size: 20.0, fontWeight: FontWeight.w600);
}

seeMoreDateAndVote(context, index, modelDate, modelVote) {
  return Row(
    children: [
      Container(
          color: Colors.red,
          width: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(DateFormat.y().format(DateTime.parse('$modelDate'))),
          )),
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
      Text('$modelVote'),
    ],
  );
}

seeMoreOverView(context, index, model) {
  return Text(
    '$model',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

defaultBottomSheet(context, widget) {
  return showBottomSheet(
      context: context,
      builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height - 100.0, child: widget));
}

//Details of movie.
imageDetails(model) {
  return SizedBox(
      height: 550.0,
      width: double.infinity,
      child: Image(
        image: NetworkImage('${AppConstants.baseImageUrl}$model'),
        fit: BoxFit.cover,
      ));
}

titleDetails(model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: defaultText(text: '$model', size: 22.0, fontWeight: FontWeight.bold),
  );
}

releaseDateDetails(model) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5.0)),
      width: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Center(
          child: defaultText(
              text: DateFormat.y().format(DateTime.parse('$model')),
              fontWeight: FontWeight.w600),
        ),
      ));
}

overViewDetails(model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    child: Text(
      '$model',
      style: const TextStyle(fontSize: 18.0, wordSpacing: 0.8),
    ),
  );
}

genresDetails(model,context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        const Text('Genres: '),
        Text('${model.genres!.map((e) {
          return e.name;
        })}'),
      ],
    ),
  );
}
