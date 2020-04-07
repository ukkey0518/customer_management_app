// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String nameReading;
  final String sex;
  Customer(
      {@required this.id,
      @required this.name,
      @required this.nameReading,
      @required this.sex});
  factory Customer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Customer(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      nameReading: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}name_reading']),
      sex: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sex']),
    );
  }
  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameReading: serializer.fromJson<String>(json['nameReading']),
      sex: serializer.fromJson<String>(json['sex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameReading': serializer.toJson<String>(nameReading),
      'sex': serializer.toJson<String>(sex),
    };
  }

  @override
  CustomersCompanion createCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      nameReading: nameReading == null && nullToAbsent
          ? const Value.absent()
          : Value(nameReading),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
    );
  }

  Customer copyWith({int id, String name, String nameReading, String sex}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        nameReading: nameReading ?? this.nameReading,
        sex: sex ?? this.sex,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameReading: $nameReading, ')
          ..write('sex: $sex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(nameReading.hashCode, sex.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameReading == this.nameReading &&
          other.sex == this.sex);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameReading;
  final Value<String> sex;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameReading = const Value.absent(),
    this.sex = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String nameReading,
    @required String sex,
  })  : name = Value(name),
        nameReading = Value(nameReading),
        sex = Value(sex);
  CustomersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> nameReading,
      Value<String> sex}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameReading: nameReading ?? this.nameReading,
      sex: sex ?? this.sex,
    );
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  final GeneratedDatabase _db;
  final String _alias;
  $CustomersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameReadingMeta =
      const VerificationMeta('nameReading');
  GeneratedTextColumn _nameReading;
  @override
  GeneratedTextColumn get nameReading =>
      _nameReading ??= _constructNameReading();
  GeneratedTextColumn _constructNameReading() {
    return GeneratedTextColumn(
      'name_reading',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  GeneratedTextColumn _sex;
  @override
  GeneratedTextColumn get sex => _sex ??= _constructSex();
  GeneratedTextColumn _constructSex() {
    return GeneratedTextColumn(
      'sex',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, nameReading, sex];
  @override
  $CustomersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'customers';
  @override
  final String actualTableName = 'customers';
  @override
  VerificationContext validateIntegrity(CustomersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.nameReading.present) {
      context.handle(_nameReadingMeta,
          nameReading.isAcceptableValue(d.nameReading.value, _nameReadingMeta));
    } else if (isInserting) {
      context.missing(_nameReadingMeta);
    }
    if (d.sex.present) {
      context.handle(_sexMeta, sex.isAcceptableValue(d.sex.value, _sexMeta));
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Customer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CustomersCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.nameReading.present) {
      map['name_reading'] = Variable<String, StringType>(d.nameReading.value);
    }
    if (d.sex.present) {
      map['sex'] = Variable<String, StringType>(d.sex.value);
    }
    return map;
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CustomersTable _customers;
  $CustomersTable get customers => _customers ??= $CustomersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [customers];
}
