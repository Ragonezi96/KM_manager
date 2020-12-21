// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumo.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ConsumoDao _consumoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Consumo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `valorcombustivel` REAL, `kmatual` INTEGER, `litrosabastecidos` REAL, `date` TEXT, `concluido` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ConsumoDao get consumoDao {
    return _consumoDaoInstance ??= _$ConsumoDao(database, changeListener);
  }
}

class _$ConsumoDao extends ConsumoDao {
  _$ConsumoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _consumoInsertionAdapter = InsertionAdapter(
            database,
            'Consumo',
            (Consumo item) => <String, dynamic>{
                  'id': item.id,
                  'valorcombustivel': item.valorcombustivel,
                  'kmatual': item.kmatual,
                  'litrosabastecidos': item.litrosabastecidos,
                  'date': item.date,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                }),
        _consumoUpdateAdapter = UpdateAdapter(
            database,
            'Consumo',
            ['id'],
            (Consumo item) => <String, dynamic>{
                  'id': item.id,
                  'valorcombustivel': item.valorcombustivel,
                  'kmatual': item.kmatual,
                  'litrosabastecidos': item.litrosabastecidos,
                  'date': item.date,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                }),
        _consumoDeletionAdapter = DeletionAdapter(
            database,
            'Consumo',
            ['id'],
            (Consumo item) => <String, dynamic>{
                  'id': item.id,
                  'valorcombustivel': item.valorcombustivel,
                  'kmatual': item.kmatual,
                  'litrosabastecidos': item.litrosabastecidos,
                  'date': item.date,
                  'concluido':
                      item.concluido == null ? null : (item.concluido ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Consumo> _consumoInsertionAdapter;

  final UpdateAdapter<Consumo> _consumoUpdateAdapter;

  final DeletionAdapter<Consumo> _consumoDeletionAdapter;

  @override
  Future<List<Consumo>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Consumo order by date, valorcombustivel',
        mapper: (Map<String, dynamic> row) => Consumo(
            id: row['id'] as int,
            valorcombustivel: row['valorcombustivel'] as double,
            litrosabastecidos: row['litrosabastecidos'] as double,
            kmatual: row['kmatual'] as int,
            date: row['date'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<Consumo> getConsumoById(int id) async {
    return _queryAdapter.query('SELECT * from Consumo where id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Consumo(
            id: row['id'] as int,
            valorcombustivel: row['valorcombustivel'] as double,
            litrosabastecidos: row['litrosabastecidos'] as double,
            kmatual: row['kmatual'] as int,
            date: row['date'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<List<Consumo>> getKM() async {
    return _queryAdapter.queryList('SELECT * FROM Consumo order by kmatual',
        mapper: (Map<String, dynamic> row) => Consumo(
            id: row['id'] as int,
            valorcombustivel: row['valorcombustivel'] as double,
            litrosabastecidos: row['litrosabastecidos'] as double,
            kmatual: row['kmatual'] as int,
            date: row['date'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<List<Consumo>> getLiters() async {
    return _queryAdapter.queryList(
        'SELECT SUM(litrosabastecidos)- (SELECT litrosabastecidos FROM Consumo WHERE id = (SELECT MAX(id) FROM Consumo )) from Consumo',
        mapper: (Map<String, dynamic> row) => Consumo(
            id: row['id'] as int,
            valorcombustivel: row['valorcombustivel'] as double,
            litrosabastecidos: row['litrosabastecidos'] as double,
            kmatual: row['kmatual'] as int,
            date: row['date'] as String,
            concluido: row['concluido'] == null
                ? null
                : (row['concluido'] as int) != 0));
  }

  @override
  Future<int> insertConsumo(Consumo p) {
    return _consumoInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateConsumo(Consumo p) {
    return _consumoUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteConsumo(Consumo p) {
    return _consumoDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
