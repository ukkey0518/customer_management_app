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
  final String visitReasonJson;
  Customer(
      {@required this.id,
      @required this.name,
      @required this.nameReading,
      @required this.isGenderFemale,
      this.birth,
      this.visitReasonJson});
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
      visitReasonJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visit_reason_json']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || nameReading != null) {
      map['name_reading'] = Variable<String>(nameReading);
    }
    if (!nullToAbsent || isGenderFemale != null) {
      map['is_gender_female'] = Variable<bool>(isGenderFemale);
    }
    if (!nullToAbsent || birth != null) {
      map['birth'] = Variable<DateTime>(birth);
    }
    if (!nullToAbsent || visitReasonJson != null) {
      map['visit_reason_json'] = Variable<String>(visitReasonJson);
    }
    return map;
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
      visitReasonJson: serializer.fromJson<String>(json['visitReasonJson']),
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
      'visitReasonJson': serializer.toJson<String>(visitReasonJson),
    };
  }

  Customer copyWith(
          {int id,
          String name,
          String nameReading,
          bool isGenderFemale,
          DateTime birth,
          String visitReasonJson}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        nameReading: nameReading ?? this.nameReading,
        isGenderFemale: isGenderFemale ?? this.isGenderFemale,
        birth: birth ?? this.birth,
        visitReasonJson: visitReasonJson ?? this.visitReasonJson,
      );
  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameReading: $nameReading, ')
          ..write('isGenderFemale: $isGenderFemale, ')
          ..write('birth: $birth, ')
          ..write('visitReasonJson: $visitReasonJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              nameReading.hashCode,
              $mrjc(isGenderFemale.hashCode,
                  $mrjc(birth.hashCode, visitReasonJson.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameReading == this.nameReading &&
          other.isGenderFemale == this.isGenderFemale &&
          other.birth == this.birth &&
          other.visitReasonJson == this.visitReasonJson);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameReading;
  final Value<bool> isGenderFemale;
  final Value<DateTime> birth;
  final Value<String> visitReasonJson;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameReading = const Value.absent(),
    this.isGenderFemale = const Value.absent(),
    this.birth = const Value.absent(),
    this.visitReasonJson = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String nameReading,
    @required bool isGenderFemale,
    this.birth = const Value.absent(),
    this.visitReasonJson = const Value.absent(),
  })  : name = Value(name),
        nameReading = Value(nameReading),
        isGenderFemale = Value(isGenderFemale);
  static Insertable<Customer> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> nameReading,
    Expression<bool> isGenderFemale,
    Expression<DateTime> birth,
    Expression<String> visitReasonJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameReading != null) 'name_reading': nameReading,
      if (isGenderFemale != null) 'is_gender_female': isGenderFemale,
      if (birth != null) 'birth': birth,
      if (visitReasonJson != null) 'visit_reason_json': visitReasonJson,
    });
  }

  CustomersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> nameReading,
      Value<bool> isGenderFemale,
      Value<DateTime> birth,
      Value<String> visitReasonJson}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameReading: nameReading ?? this.nameReading,
      isGenderFemale: isGenderFemale ?? this.isGenderFemale,
      birth: birth ?? this.birth,
      visitReasonJson: visitReasonJson ?? this.visitReasonJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameReading.present) {
      map['name_reading'] = Variable<String>(nameReading.value);
    }
    if (isGenderFemale.present) {
      map['is_gender_female'] = Variable<bool>(isGenderFemale.value);
    }
    if (birth.present) {
      map['birth'] = Variable<DateTime>(birth.value);
    }
    if (visitReasonJson.present) {
      map['visit_reason_json'] = Variable<String>(visitReasonJson.value);
    }
    return map;
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

  final VerificationMeta _visitReasonJsonMeta =
      const VerificationMeta('visitReasonJson');
  GeneratedTextColumn _visitReasonJson;
  @override
  GeneratedTextColumn get visitReasonJson =>
      _visitReasonJson ??= _constructVisitReasonJson();
  GeneratedTextColumn _constructVisitReasonJson() {
    return GeneratedTextColumn(
      'visit_reason_json',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, nameReading, isGenderFemale, birth, visitReasonJson];
  @override
  $CustomersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'customers';
  @override
  final String actualTableName = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_reading')) {
      context.handle(
          _nameReadingMeta,
          nameReading.isAcceptableOrUnknown(
              data['name_reading'], _nameReadingMeta));
    } else if (isInserting) {
      context.missing(_nameReadingMeta);
    }
    if (data.containsKey('is_gender_female')) {
      context.handle(
          _isGenderFemaleMeta,
          isGenderFemale.isAcceptableOrUnknown(
              data['is_gender_female'], _isGenderFemaleMeta));
    } else if (isInserting) {
      context.missing(_isGenderFemaleMeta);
    }
    if (data.containsKey('birth')) {
      context.handle(
          _birthMeta, birth.isAcceptableOrUnknown(data['birth'], _birthMeta));
    }
    if (data.containsKey('visit_reason_json')) {
      context.handle(
          _visitReasonJsonMeta,
          visitReasonJson.isAcceptableOrUnknown(
              data['visit_reason_json'], _visitReasonJsonMeta));
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
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(_db, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String name;
  Employee({@required this.id, @required this.name});
  factory Employee.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Employee(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Employee copyWith({int id, String name}) => Employee(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Employee && other.id == this.id && other.name == this.name);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> name;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<Employee> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  EmployeesCompanion copyWith({Value<int> id, Value<String> name}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  final GeneratedDatabase _db;
  final String _alias;
  $EmployeesTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $EmployeesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'employees';
  @override
  final String actualTableName = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Employee.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(_db, alias);
  }
}

class VisitReason extends DataClass implements Insertable<VisitReason> {
  final int id;
  final String reason;
  VisitReason({@required this.id, @required this.reason});
  factory VisitReason.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return VisitReason(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      reason:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}reason']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    return map;
  }

  factory VisitReason.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitReason(
      id: serializer.fromJson<int>(json['id']),
      reason: serializer.fromJson<String>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reason': serializer.toJson<String>(reason),
    };
  }

  VisitReason copyWith({int id, String reason}) => VisitReason(
        id: id ?? this.id,
        reason: reason ?? this.reason,
      );
  @override
  String toString() {
    return (StringBuffer('VisitReason(')
          ..write('id: $id, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, reason.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitReason &&
          other.id == this.id &&
          other.reason == this.reason);
}

class VisitReasonsCompanion extends UpdateCompanion<VisitReason> {
  final Value<int> id;
  final Value<String> reason;
  const VisitReasonsCompanion({
    this.id = const Value.absent(),
    this.reason = const Value.absent(),
  });
  VisitReasonsCompanion.insert({
    this.id = const Value.absent(),
    @required String reason,
  }) : reason = Value(reason);
  static Insertable<VisitReason> custom({
    Expression<int> id,
    Expression<String> reason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reason != null) 'reason': reason,
    });
  }

  VisitReasonsCompanion copyWith({Value<int> id, Value<String> reason}) {
    return VisitReasonsCompanion(
      id: id ?? this.id,
      reason: reason ?? this.reason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    return map;
  }
}

class $VisitReasonsTable extends VisitReasons
    with TableInfo<$VisitReasonsTable, VisitReason> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitReasonsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _reasonMeta = const VerificationMeta('reason');
  GeneratedTextColumn _reason;
  @override
  GeneratedTextColumn get reason => _reason ??= _constructReason();
  GeneratedTextColumn _constructReason() {
    return GeneratedTextColumn(
      'reason',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, reason];
  @override
  $VisitReasonsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'visit_reasons';
  @override
  final String actualTableName = 'visit_reasons';
  @override
  VerificationContext validateIntegrity(Insertable<VisitReason> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason'], _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitReason map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitReason.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitReasonsTable createAlias(String alias) {
    return $VisitReasonsTable(_db, alias);
  }
}

class MenuCategory extends DataClass implements Insertable<MenuCategory> {
  final int id;
  final String name;
  final int color;
  MenuCategory({@required this.id, @required this.name, @required this.color});
  factory MenuCategory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MenuCategory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    return map;
  }

  factory MenuCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MenuCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  MenuCategory copyWith({int id, String name, int color}) => MenuCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('MenuCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, color.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MenuCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class MenuCategoriesCompanion extends UpdateCompanion<MenuCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  const MenuCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  MenuCategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required int color,
  })  : name = Value(name),
        color = Value(color);
  static Insertable<MenuCategory> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<int> color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  MenuCategoriesCompanion copyWith(
      {Value<int> id, Value<String> name, Value<int> color}) {
    return MenuCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }
}

class $MenuCategoriesTable extends MenuCategories
    with TableInfo<$MenuCategoriesTable, MenuCategory> {
  final GeneratedDatabase _db;
  final String _alias;
  $MenuCategoriesTable(this._db, [this._alias]);
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

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  $MenuCategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'menu_categories';
  @override
  final String actualTableName = 'menu_categories';
  @override
  VerificationContext validateIntegrity(Insertable<MenuCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuCategory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MenuCategory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MenuCategoriesTable createAlias(String alias) {
    return $MenuCategoriesTable(_db, alias);
  }
}

class Menu extends DataClass implements Insertable<Menu> {
  final int id;
  final String menuCategoryJson;
  final String name;
  final int price;
  Menu(
      {@required this.id,
      @required this.menuCategoryJson,
      @required this.name,
      @required this.price});
  factory Menu.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Menu(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      menuCategoryJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}menu_category_json']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || menuCategoryJson != null) {
      map['menu_category_json'] = Variable<String>(menuCategoryJson);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    return map;
  }

  factory Menu.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Menu(
      id: serializer.fromJson<int>(json['id']),
      menuCategoryJson: serializer.fromJson<String>(json['menuCategoryJson']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuCategoryJson': serializer.toJson<String>(menuCategoryJson),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
    };
  }

  Menu copyWith({int id, String menuCategoryJson, String name, int price}) =>
      Menu(
        id: id ?? this.id,
        menuCategoryJson: menuCategoryJson ?? this.menuCategoryJson,
        name: name ?? this.name,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Menu(')
          ..write('id: $id, ')
          ..write('menuCategoryJson: $menuCategoryJson, ')
          ..write('name: $name, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(menuCategoryJson.hashCode, $mrjc(name.hashCode, price.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Menu &&
          other.id == this.id &&
          other.menuCategoryJson == this.menuCategoryJson &&
          other.name == this.name &&
          other.price == this.price);
}

class MenusCompanion extends UpdateCompanion<Menu> {
  final Value<int> id;
  final Value<String> menuCategoryJson;
  final Value<String> name;
  final Value<int> price;
  const MenusCompanion({
    this.id = const Value.absent(),
    this.menuCategoryJson = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
  });
  MenusCompanion.insert({
    this.id = const Value.absent(),
    @required String menuCategoryJson,
    @required String name,
    @required int price,
  })  : menuCategoryJson = Value(menuCategoryJson),
        name = Value(name),
        price = Value(price);
  static Insertable<Menu> custom({
    Expression<int> id,
    Expression<String> menuCategoryJson,
    Expression<String> name,
    Expression<int> price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuCategoryJson != null) 'menu_category_json': menuCategoryJson,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
    });
  }

  MenusCompanion copyWith(
      {Value<int> id,
      Value<String> menuCategoryJson,
      Value<String> name,
      Value<int> price}) {
    return MenusCompanion(
      id: id ?? this.id,
      menuCategoryJson: menuCategoryJson ?? this.menuCategoryJson,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuCategoryJson.present) {
      map['menu_category_json'] = Variable<String>(menuCategoryJson.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    return map;
  }
}

class $MenusTable extends Menus with TableInfo<$MenusTable, Menu> {
  final GeneratedDatabase _db;
  final String _alias;
  $MenusTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _menuCategoryJsonMeta =
      const VerificationMeta('menuCategoryJson');
  GeneratedTextColumn _menuCategoryJson;
  @override
  GeneratedTextColumn get menuCategoryJson =>
      _menuCategoryJson ??= _constructMenuCategoryJson();
  GeneratedTextColumn _constructMenuCategoryJson() {
    return GeneratedTextColumn(
      'menu_category_json',
      $tableName,
      false,
    );
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

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, menuCategoryJson, name, price];
  @override
  $MenusTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'menus';
  @override
  final String actualTableName = 'menus';
  @override
  VerificationContext validateIntegrity(Insertable<Menu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('menu_category_json')) {
      context.handle(
          _menuCategoryJsonMeta,
          menuCategoryJson.isAcceptableOrUnknown(
              data['menu_category_json'], _menuCategoryJsonMeta));
    } else if (isInserting) {
      context.missing(_menuCategoryJsonMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Menu map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Menu.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MenusTable createAlias(String alias) {
    return $MenusTable(_db, alias);
  }
}

class VisitHistory extends DataClass implements Insertable<VisitHistory> {
  final int id;
  final DateTime date;
  final String customerJson;
  final String employeeJson;
  final String menuListJson;
  VisitHistory(
      {@required this.id,
      @required this.date,
      @required this.customerJson,
      @required this.employeeJson,
      @required this.menuListJson});
  factory VisitHistory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return VisitHistory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      customerJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_json']),
      employeeJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_json']),
      menuListJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}menu_list_json']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || customerJson != null) {
      map['customer_json'] = Variable<String>(customerJson);
    }
    if (!nullToAbsent || employeeJson != null) {
      map['employee_json'] = Variable<String>(employeeJson);
    }
    if (!nullToAbsent || menuListJson != null) {
      map['menu_list_json'] = Variable<String>(menuListJson);
    }
    return map;
  }

  factory VisitHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitHistory(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerJson: serializer.fromJson<String>(json['customerJson']),
      employeeJson: serializer.fromJson<String>(json['employeeJson']),
      menuListJson: serializer.fromJson<String>(json['menuListJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'customerJson': serializer.toJson<String>(customerJson),
      'employeeJson': serializer.toJson<String>(employeeJson),
      'menuListJson': serializer.toJson<String>(menuListJson),
    };
  }

  VisitHistory copyWith(
          {int id,
          DateTime date,
          String customerJson,
          String employeeJson,
          String menuListJson}) =>
      VisitHistory(
        id: id ?? this.id,
        date: date ?? this.date,
        customerJson: customerJson ?? this.customerJson,
        employeeJson: employeeJson ?? this.employeeJson,
        menuListJson: menuListJson ?? this.menuListJson,
      );
  @override
  String toString() {
    return (StringBuffer('VisitHistory(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('customerJson: $customerJson, ')
          ..write('employeeJson: $employeeJson, ')
          ..write('menuListJson: $menuListJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          date.hashCode,
          $mrjc(customerJson.hashCode,
              $mrjc(employeeJson.hashCode, menuListJson.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitHistory &&
          other.id == this.id &&
          other.date == this.date &&
          other.customerJson == this.customerJson &&
          other.employeeJson == this.employeeJson &&
          other.menuListJson == this.menuListJson);
}

class VisitHistoriesCompanion extends UpdateCompanion<VisitHistory> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> customerJson;
  final Value<String> employeeJson;
  final Value<String> menuListJson;
  const VisitHistoriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.customerJson = const Value.absent(),
    this.employeeJson = const Value.absent(),
    this.menuListJson = const Value.absent(),
  });
  VisitHistoriesCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime date,
    @required String customerJson,
    @required String employeeJson,
    @required String menuListJson,
  })  : date = Value(date),
        customerJson = Value(customerJson),
        employeeJson = Value(employeeJson),
        menuListJson = Value(menuListJson);
  static Insertable<VisitHistory> custom({
    Expression<int> id,
    Expression<DateTime> date,
    Expression<String> customerJson,
    Expression<String> employeeJson,
    Expression<String> menuListJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (customerJson != null) 'customer_json': customerJson,
      if (employeeJson != null) 'employee_json': employeeJson,
      if (menuListJson != null) 'menu_list_json': menuListJson,
    });
  }

  VisitHistoriesCompanion copyWith(
      {Value<int> id,
      Value<DateTime> date,
      Value<String> customerJson,
      Value<String> employeeJson,
      Value<String> menuListJson}) {
    return VisitHistoriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      customerJson: customerJson ?? this.customerJson,
      employeeJson: employeeJson ?? this.employeeJson,
      menuListJson: menuListJson ?? this.menuListJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (customerJson.present) {
      map['customer_json'] = Variable<String>(customerJson.value);
    }
    if (employeeJson.present) {
      map['employee_json'] = Variable<String>(employeeJson.value);
    }
    if (menuListJson.present) {
      map['menu_list_json'] = Variable<String>(menuListJson.value);
    }
    return map;
  }
}

class $VisitHistoriesTable extends VisitHistories
    with TableInfo<$VisitHistoriesTable, VisitHistory> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitHistoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _customerJsonMeta =
      const VerificationMeta('customerJson');
  GeneratedTextColumn _customerJson;
  @override
  GeneratedTextColumn get customerJson =>
      _customerJson ??= _constructCustomerJson();
  GeneratedTextColumn _constructCustomerJson() {
    return GeneratedTextColumn(
      'customer_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _employeeJsonMeta =
      const VerificationMeta('employeeJson');
  GeneratedTextColumn _employeeJson;
  @override
  GeneratedTextColumn get employeeJson =>
      _employeeJson ??= _constructEmployeeJson();
  GeneratedTextColumn _constructEmployeeJson() {
    return GeneratedTextColumn(
      'employee_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _menuListJsonMeta =
      const VerificationMeta('menuListJson');
  GeneratedTextColumn _menuListJson;
  @override
  GeneratedTextColumn get menuListJson =>
      _menuListJson ??= _constructMenuListJson();
  GeneratedTextColumn _constructMenuListJson() {
    return GeneratedTextColumn(
      'menu_list_json',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, date, customerJson, employeeJson, menuListJson];
  @override
  $VisitHistoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'visit_histories';
  @override
  final String actualTableName = 'visit_histories';
  @override
  VerificationContext validateIntegrity(Insertable<VisitHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('customer_json')) {
      context.handle(
          _customerJsonMeta,
          customerJson.isAcceptableOrUnknown(
              data['customer_json'], _customerJsonMeta));
    } else if (isInserting) {
      context.missing(_customerJsonMeta);
    }
    if (data.containsKey('employee_json')) {
      context.handle(
          _employeeJsonMeta,
          employeeJson.isAcceptableOrUnknown(
              data['employee_json'], _employeeJsonMeta));
    } else if (isInserting) {
      context.missing(_employeeJsonMeta);
    }
    if (data.containsKey('menu_list_json')) {
      context.handle(
          _menuListJsonMeta,
          menuListJson.isAcceptableOrUnknown(
              data['menu_list_json'], _menuListJsonMeta));
    } else if (isInserting) {
      context.missing(_menuListJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitHistory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitHistory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitHistoriesTable createAlias(String alias) {
    return $VisitHistoriesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CustomersTable _customers;
  $CustomersTable get customers => _customers ??= $CustomersTable(this);
  $EmployeesTable _employees;
  $EmployeesTable get employees => _employees ??= $EmployeesTable(this);
  $VisitReasonsTable _visitReasons;
  $VisitReasonsTable get visitReasons =>
      _visitReasons ??= $VisitReasonsTable(this);
  $MenuCategoriesTable _menuCategories;
  $MenuCategoriesTable get menuCategories =>
      _menuCategories ??= $MenuCategoriesTable(this);
  $MenusTable _menus;
  $MenusTable get menus => _menus ??= $MenusTable(this);
  $VisitHistoriesTable _visitHistories;
  $VisitHistoriesTable get visitHistories =>
      _visitHistories ??= $VisitHistoriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        customers,
        employees,
        visitReasons,
        menuCategories,
        menus,
        visitHistories
      ];
}
