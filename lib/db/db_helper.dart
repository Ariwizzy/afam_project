import 'package:afam_project/model/db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static Database _db;
  static const String ID = 'id';
  static const String TITTLE = 'tittle';
  static const String NEWSID = 'newsId';
  static const String DATETIME = 'dateTime';
  static const String IMAGEURL = 'imageUrl';
  static const String CONTENT = 'content';
  static const String TABLE = 'quotes';
  static const String MINSREAD = 'minsRead';
  static const String DB_NAME = 'flutter_dev.db';

  // check the db available or not and return the value
  Future<Database> get fetchMyDatabase async {
    if (_db != null) {
      return _db;
    }
    _db = await _initializeDb();
    return _db;
  }

  // intialize the database
  _initializeDb() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _createMyTable);
    return db;
  }

  //create my table if not available
  _createMyTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITTLE TEXT, $IMAGEURL TEXT, $DATETIME TEXT, $CONTENT TEXT, $NEWSID TEXT, $MINSREAD TEXT)");
  }

  // Save the Quote once user clicked the button
  saveQuote(DbModel quote) async {
    var dbClient = await fetchMyDatabase;
    await dbClient.insert(TABLE, quote.toMap());
    print("done");
  }

  // Close the connection to database
  Future closeDbConnection() async {
    var dbClient = await fetchMyDatabase;
    dbClient.close();
  }

  // Fetch the Saved Quotes from Table
  Future<List<DbModel>> fetchSavedQuotes() async {
    var dbClient = await fetchMyDatabase;
    List<Map> maps =
    await dbClient.query(TABLE, columns: [ID, TITTLE, IMAGEURL,CONTENT,DATETIME,MINSREAD,NEWSID]);
    List<DbModel> quotes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        quotes.add(DbModel.fromMap(maps[i]));
      }
    }
    return quotes;
  }

  Future<int> deleteQuoteFromFavorite(int id) async {
    var dbClient = await fetchMyDatabase;
    print("done");
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }
}