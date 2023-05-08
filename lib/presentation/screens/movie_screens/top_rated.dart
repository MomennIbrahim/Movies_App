import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/constants/constants.dart';
import '../../components/components.dart';
import '../../controller/movie_cubit.dart';
import '../../controller/movie_state.dart';
import 'movie_details.dart';

class MovieTopRatedScreen extends StatelessWidget {
  const MovieTopRatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = MovieCubit.get(context).topRatedModel!.list;
    return BlocConsumer<MovieCubit,MovieStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return Scaffold(
          appBar: defaultAppbar(context, text: lang=='en'?'Top Rated Movie':'أعلي التقيمات'),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildCondition(
              condition: MovieCubit.get(context).topRatedModel != null,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        MovieCubit.get(context).getMovieDetails(movieId: model[index].id);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BuildCondition(
                          condition: MovieCubit.get(context).detailsModel != null,
                          builder: (context)=>MovieDetailsScreen(movieId: model[index].id,),
                          fallback: (context)=>defaultCircularProgress(),
                        )));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5)
                        ),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.grey.shade800,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: lang=='en'?TextDirection.ltr:TextDirection.rtl,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                seeMoreImage(context,index,'${model[index].posterPath}'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: seeMoreTitle(context, index,model[index].title) ,
                                      ),
                                      const SizedBox(height: 7.5,),
                                      seeMoreDateAndVote(context,index,model[index].releaseDate,model[index].voteRange),
                                      const SizedBox(height: 7.5),
                                      SizedBox(
                                        width: 200,
                                        child: seeMoreOverView(context,index,model[index].overView) ,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index)=> const SizedBox(),
                  itemCount: MovieCubit.get(context).topRatedModel!.list.length
              ),
              fallback: (context)=> defaultCircularProgress(),
            ),
          ),
        );
      } ,
    );
  }
}
