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
  final bool isGenderFemale;
  final DateTime birth;
  Customer(
      {@required this.id,
      @required this.name,
      @required this.nameReading,
      @required this.isGenderFemale,
      this.birth});
  factory Customer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Customer(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      nameReading: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}name_reading']),
      isGenderFemale: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_gender_female']),
      birth:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}birth']),
    );
  }
  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameReading: serializer.fromJson<String>(json['nameReading']),
      isGenderFemale: serializer.fromJson<bool>(json['isGenderFemale']),
      birth: serializer.fromJson<DateTime>(json['birth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameReading': serializer.toJson<String>(nameReading),
      'isGenderFemale': serializer.toJson<bool>(isGenderFemale),
      'birth': serializer.toJson<DateTime>(birth),
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
      isGenderFemale: isGenderFemale == null && nullToAbsent
          ? const Value.absent()
          : Value(isGenderFemale),
      birth:
          birth == null && nullToAbsent ? const Value.absent() : Value(birth),
    );
  }

  Customer copyWith(
          {int id,
          String name,
          String nameReading,
          bool isGenderFemale,
          DateTime birth}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        nameReading: nameReading ?? this.nameReading,
        isGenderFemale: isGenderFemale ?? this.isGenderFemale,
        birth: birth ?? this.birth,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameReading: $nameReading, ')
          ..write('isGenderFemale: $isGenderFemale, ')
          ..write('birth: $birth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(nameReading.hashCode,
              $mrjc(isGenderFemale.hashCode, birth.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameReading == this.nameReading &&
          other.isGenderFemale == this.isGenderFemale &&
          other.birth == this.birth);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameReading;
  final Value<bool> isGenderFemale;
  final Value<DateTime> birth;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameReading = const Value.absent(),
    this.isGenderFemale = const Value.absent(),
    this.birth = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String nameReading,
    @required bool isGenderFemale,
    this.birth = const Value.absent(),
  })  : name = Value(name),
        nameReading = Value(nameReading),
        isGenderFemale = Value(isGenderFemale);
  CustomersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> nameReading,
      Value<bool> isGenderFemale,
      Value<DateTime> birth}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameReading: nameReading ?? this.nameReading,
      isGenderFemale: isGenderFemale ?? this.isGenderFemale,
      birth: birth ?? this.birth,
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

  final VerificationMeta _isGenderFemaleMeta =
      const VerificationMeta('isGenderFemale');
  GeneratedBoolColumn _isGenderFemale;
  @override
  GeneratedBoolColumn get isGenderFemale =>
      _isGenderFemale ??= _constructIsGenderFemale();
  GeneratedBoolColumn _constructIsGenderFemale() {
    return GeneratedBoolColumn(
      'is_gender_female',
      $tableName,
      false,
    );
  }

  final VerificationMeta _birthMeta = const VerificationMeta('birth');
  GeneratedDateTimeColumn _birth;
  @override
  GeneratedDateTimeColumn get birth => _birth ??= _constructBirth();
  GeneratedDateTimeColumn _constructBirth() {
    return GeneratedDateTimeColumn(
      'birth',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, nameReading, isGenderFemale, birth];
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
    if (d.isGenderFemale.present) {
      context.handle(
          _isGenderFemaleMeta,
          isGenderFemale.isAcceptableValue(
              d.isGenderFemale.value, _isGenderFemaleMeta));
    } else if (isInserting) {
      context.missing(_isGenderFemaleMeta);
    }
    if (d.birth.present) {
      context.handle(
          _birthMeta, birth.isAcceptableValue(d.birth.value, _birthMeta));
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
    if (d.isGenderFemale.present) {
      map['is_gender_female'] =
          Variable<bool, BoolType>(d.isGenderFemale.value);
    }
    if (d.birth.present) {
      map['birth'] = Variable<DateTime, DateTimeType>(d.birth.value);
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
