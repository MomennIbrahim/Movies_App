import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/presentation/screens/tv_screens/tv_details.dart';

import '../../components/components.dart';
import '../../controller/tv_cubit.dart';
import '../../controller/tv_state.dart';

class TvPopularScreen extends StatelessWidget {
  const TvPopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var model = TvCubit.get(context).tvPopularModel!.list;

    return BlocConsumer<TvCubit,TvStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return Scaffold(
          appBar: defaultAppbar(context, text: 'Popular Tvs'),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildCondition(
              condition: TvCubit.get(context).tvPopularModel != null,
              builder:(context)=>ListView.separated(
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        TvCubit.get(context).getTvDetailsData(tvId: model[index].id);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TvDetailsScreen(tvId: model[index].id,)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5)
                        ),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.grey.shade800,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                      child: seeMoreTitle(context, index,model[index].name) ,
                                    ),
                                    const SizedBox(height: 7.5,),
                                    seeMoreDateAndVote(context,index,model[index].firstAirData,model[index].voteAverage),
                                    const SizedBox(height: 7.5),
                                    SizedBox(
                                      width: 200,
                                      child: seeMoreOverView(context,index,model[index].overview) ,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index)=> const SizedBox(),
                  itemCount: TvCubit.get(context).tvPopularModel!.list.length
              ),
              fallback:(context)=> defaultCircularProgress() ,
            ),
          ),
        );
      } ,
    );
  }
}
