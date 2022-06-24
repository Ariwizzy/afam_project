class DbModel{
  final String tittle,content,imageUrl,minsRead,dateTime,newsId;
  final int id;

  DbModel({this.newsId, this.tittle, this.content, this.imageUrl, this.minsRead, this.dateTime, this.id});
  factory DbModel.fromMap(Map<String, dynamic> json) =>DbModel(
    tittle :json['tittle'],
    dateTime : json['dateTime'],
    newsId: json['newsId'],
    id: json['id'],
    content :json['content'],
    imageUrl: json['imageUrl'],
    minsRead : json['minsRead'],
  );
  Map<String,dynamic> toMap(){
    return{
      "tittle" :tittle,
      "dateTime" : dateTime,
      'newsId'  :newsId,
      "id" : id,
      "content" : content,
      "imageUrl" : imageUrl,
      "minsRead" : minsRead,
    };
  }
}
