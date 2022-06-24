class MiningModel{
  final String dateTime,amount;
  MiningModel({this.dateTime, this.amount});
  factory MiningModel.fromMap(Map<String, dynamic> json) =>MiningModel(
    amount :json['amount'],
    dateTime : json['dateTime'],
  );
  Map<String,dynamic> toMap(){
    return{
      "amount" :amount,
      "dateTime" : dateTime,
    };
  }
}