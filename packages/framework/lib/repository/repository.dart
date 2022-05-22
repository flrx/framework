import 'package:flrx/repository/data_model.dart';

abstract class Repository<T extends DataModel> {
  Future<T> get(int id);

  Future<List<T>> getAll();

  Future<T> create(T entity);

  Future<T> update(T entity);

  Future<void> delete(int id);

  Future<List<T>> getAllForRelation<S extends DataModel>(S entity);

  Future<List<T>> getAllForRelationById<S>(int id);
}
