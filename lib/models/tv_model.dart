class TvModel{
  List<TvDataModel> list = [];
  TvModel.fromJson(Map<String,dynamic> json){
    json['results'].forEach((e){
      list.add(TvDataModel.fromJson(e));
    });
  }
}

class TvDataModel{
  int? id;
  dynamic voteAverage;
  String? firstAirData;
  String? name;
  String? overview;
  String? posterPath;

  TvDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    voteAverage = json['vote_average'];
    firstAirData = json['first_air_date'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
  }
}