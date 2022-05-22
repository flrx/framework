import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flrx/repository/data_model.dart';
import 'package:flrx/repository/repository.dart';

mixin FakeRepository<T extends DataModel> on Repository<T> {
  FixtureFactory<T> get fixtureFactory;

  int get numberOfEntities => 10;

  @override
  Future<T> create(T entity) => Future.value(entity);

  @override
  Future<void> delete(int id) => Future.value();

  @override
  Future<T> get(int id) async => fixtureFactory.makeSingle();

  @override
  Future<List<T>> getAll() async => fixtureFactory.makeMany(numberOfEntities);

  @override
  Future<List<T>> getAllForRelation<S extends DataModel>(S entity) => getAll();

  @override
  Future<List<T>> getAllForRelationById<S>(int id) => getAll();

  @override
  Future<T> update(T entity) => Future.value(entity);
}
