class TvDetailsModel{
  int? id;
  String? name;
  int? numberOfSeasons;
  String? pathImage;
  String? lastAirDate;
  String? overView;
  dynamic voteAverage;
  List<TvGenresModel>? genres;

  TvDetailsModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    numberOfSeasons = json['number_of_seasons'];
    name = json['name'];
    pathImage = json['poster_path'];
    lastAirDate = json['last_air_date'];
    overView = json['overview'];
    voteAverage = json['vote_average'];
    if(json['genres'] != null){
      genres = <TvGenresModel>[];
      json['genres'].forEach((e){
        genres!.add(TvGenresModel.fromJson(e));
      });
    }
  }
}

class TvGenresModel{
  String? name;

  TvGenresModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
  }
}