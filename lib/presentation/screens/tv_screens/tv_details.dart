import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../shared/constants/api_constatnts.dart';
import '../../components/components.dart';
import '../../controller/tv_cubit.dart';
import '../../controller/tv_state.dart';

class TvDetailsScreen extends StatelessWidget {
  const TvDetailsScreen({Key? key, this.tvId}) : super(key: key);

  final tvId;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TvCubit,TvStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return Scaffold(
          body: BuildCondition(
            condition: TvCubit.get(context).tvDetailsModel != null ,
            builder: (context)=>SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: 550.0,
                          width: double.infinity,
                          child: Image(
                            image: NetworkImage('${AppConstants.baseImageUrl}${TvCubit.get(context).tvDetailsModel!.pathImage}'),
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultText(text: '${TvCubit.get(context).tvDetailsModel!.name}', size: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.red, borderRadius: BorderRadius.circular(5.0)),
                            width: 70,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Center(child: defaultText(
                                  text: DateFormat.y().format(DateTime.parse('${TvCubit.get(context).tvDetailsModel!.lastAirDate}')),
                                  fontWeight: FontWeight.w600)),
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
                        Text('${TvCubit.get(context).tvDetailsModel!.voteAverage}'),
                        const SizedBox(
                          width: 20.0,
                        ),
                        defaultText(text:'( Season ${TvCubit.get(context).tvDetailsModel!.numberOfSeasons} )',size: 16.0),
                      ],
                    ),
                  ),
                  overViewDetails(TvCubit.get(context).tvDetailsModel!.overView),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: defaultText(size: 14.0,text:'Genres: ${TvCubit.get(context).tvDetailsModel!.genres!.map((e) {
                      return e.name;
                    })}'),
                  )
                ],
              ),
            ),
            fallback: (context)=>defaultCircularProgress(),
          ),
        );
      } ,
    );
  }
}
