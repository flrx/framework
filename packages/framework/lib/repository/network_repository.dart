import 'package:dio/dio.dart';
import 'package:flrx/flrx.dart';
import 'package:grammer/grammer.dart';

mixin NetworkRepository<T extends DataModel> on Repository<T> {
  Dio get dio => Application.get<Dio>();

  String get entityUrlPath => entityUrlPathForType(T);

  String entityUrlPathForType(Type type) {
    return Grammer(type.toString().toLowerCase()).toPlural().first;
  }

  @override
  Future<T> create(T entity) async {
    final result = await dio.post(entityUrlPath, data: entity.toJson());
    final value = deserializeSingleEntity(result.data);

    return value;
  }

  @override
  Future<void> delete(int id) async {
    await dio.delete('$entityUrlPath/$id');
  }

  @override
  Future<T> get(int id) {
    return dio.get('$entityUrlPath/$id').then((result) {
      return deserializeSingleEntity(result.data);
    });
  }

  @override
  Future<List<T>> getAll() {
    return dio.get(entityUrlPath).then((result) {
      return deserializeEntityList(result.data);
    });
  }

  @override
  Future<T> update(T entity) {
    return dio
        .put('$entityUrlPath/${entity.id}', data: entity.toJson())
        .then((result) {
      return deserializeSingleEntity(result.data);
    });
  }

  @override
  Future<List<T>> getAllForRelation<S extends DataModel>(S entity) {
    return getAllForRelationById(entity.id!);
  }

  @override
  Future<List<T>> getAllForRelationById<S>(int id) {
    var relationEntityPath = entityUrlPathForType(S);
    var finalPath = '$relationEntityPath/$id/$entityUrlPath';

    return dio.get(finalPath).then((result) {
      return deserializeEntityList(result.data);
    });
  }

  T deserializeSingleEntity(dynamic data);

  List<T> deserializeEntityList(dynamic data);

  T fromJson(Map<String, dynamic> json);
}
