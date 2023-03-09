import 'package:sqflite/sqflite.dart';

import '../clients/database_client.dart';
import '../models/topic.dart';

abstract class TopicRepository {
  Future<List<Topic>> getTopics();
  Future<String> getDetial(int id);
}

class TopicRepositoryDatabase extends TopicRepository{
  TopicRepositoryDatabase(this.databaseClient);
  DatabaseClient databaseClient;

  final _topicTable = 'topic';
  final _columnID = 'id';
  final _columnName = 'name';
  final _columnDetail = 'detail';

  @override
  Future<List<Topic>> getTopics() async {
    Database database = await databaseClient.database;
    final maps = await database.query(
      _topicTable,
      columns: [_columnID, _columnName],
    );
    return maps.map((map) => Topic.fromMap(map)).toList();
  }

  @override
  Future<String> getDetial(int id) async {
    Database database = await databaseClient.database;
    final maps = await database.query(
      _topicTable,
      columns: [_columnDetail],
      where: '$_columnID = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.first[_columnDetail] as String;
  }
}
