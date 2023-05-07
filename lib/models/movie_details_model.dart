class DetailsModel{
   int? id;
   int? runTime;
   String? title;
   String? pathImage;
   String? releaseDate;
   String? overView;
   dynamic voteRange;
   List<GenresModel>? genres;
   DetailsModel.fromJson(Map<String,dynamic> json){
      id = json['id'];
      runTime = json['runtime'];
      title = json['title'];
      pathImage = json['poster_path'];
      releaseDate = json['release_date'];
      overView = json['overview'];
      voteRange = json['vote_average'];
      if(json['genres'] != null){
         genres = <GenresModel>[];
         json['genres'].forEach((e){
            genres!.add(GenresModel.fromJson(e));
         });
      }
   }
}
class GenresModel{
   String? name;

   GenresModel.fromJson(Map<String,dynamic> json){
      name = json['name'];
   }
}