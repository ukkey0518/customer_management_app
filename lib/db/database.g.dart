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

class SalesItem extends DataClass implements Insertable<SalesItem> {
  final int id;
  final DateTime date;
  final int customerId;
  final int menuId;
  final int stuffId;
  final int discountId;
  final int price;
  SalesItem(
      {@required this.id,
      @required this.date,
      @required this.customerId,
      @required this.menuId,
      @required this.stuffId,
      @required this.discountId,
      @required this.price});
  factory SalesItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SalesItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      customerId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      menuId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}menu_id']),
      stuffId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}stuff_id']),
      discountId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}discount_id']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  factory SalesItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SalesItem(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerId: serializer.fromJson<int>(json['customerId']),
      menuId: serializer.fromJson<int>(json['menuId']),
      stuffId: serializer.fromJson<int>(json['stuffId']),
      discountId: serializer.fromJson<int>(json['discountId']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'customerId': serializer.toJson<int>(customerId),
      'menuId': serializer.toJson<int>(menuId),
      'stuffId': serializer.toJson<int>(stuffId),
      'discountId': serializer.toJson<int>(discountId),
      'price': serializer.toJson<int>(price),
    };
  }

  @override
  SalesItemsCompanion createCompanion(bool nullToAbsent) {
    return SalesItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      menuId:
          menuId == null && nullToAbsent ? const Value.absent() : Value(menuId),
      stuffId: stuffId == null && nullToAbsent
          ? const Value.absent()
          : Value(stuffId),
      discountId: discountId == null && nullToAbsent
          ? const Value.absent()
          : Value(discountId),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  SalesItem copyWith(
          {int id,
          DateTime date,
          int customerId,
          int menuId,
          int stuffId,
          int discountId,
          int price}) =>
      SalesItem(
        id: id ?? this.id,
        date: date ?? this.date,
        customerId: customerId ?? this.customerId,
        menuId: menuId ?? this.menuId,
        stuffId: stuffId ?? this.stuffId,
        discountId: discountId ?? this.discountId,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('SalesItem(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('menuId: $menuId, ')
          ..write('stuffId: $stuffId, ')
          ..write('discountId: $discountId, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          date.hashCode,
          $mrjc(
              customerId.hashCode,
              $mrjc(
                  menuId.hashCode,
                  $mrjc(stuffId.hashCode,
                      $mrjc(discountId.hashCode, price.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SalesItem &&
          other.id == this.id &&
          other.date == this.date &&
          other.customerId == this.customerId &&
          other.menuId == this.menuId &&
          other.stuffId == this.stuffId &&
          other.discountId == this.discountId &&
          other.price == this.price);
}

class SalesItemsCompanion extends UpdateCompanion<SalesItem> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> customerId;
  final Value<int> menuId;
  final Value<int> stuffId;
  final Value<int> discountId;
  final Value<int> price;
  const SalesItemsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.customerId = const Value.absent(),
    this.menuId = const Value.absent(),
    this.stuffId = const Value.absent(),
    this.discountId = const Value.absent(),
    this.price = const Value.absent(),
  });
  SalesItemsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime date,
    @required int customerId,
    @required int menuId,
    @required int stuffId,
    @required int discountId,
    @required int price,
  })  : date = Value(date),
        customerId = Value(customerId),
        menuId = Value(menuId),
        stuffId = Value(stuffId),
        discountId = Value(discountId),
        price = Value(price);
  SalesItemsCompanion copyWith(
      {Value<int> id,
      Value<DateTime> date,
      Value<int> customerId,
      Value<int> menuId,
      Value<int> stuffId,
      Value<int> discountId,
      Value<int> price}) {
    return SalesItemsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      menuId: menuId ?? this.menuId,
      stuffId: stuffId ?? this.stuffId,
      discountId: discountId ?? this.discountId,
      price: price ?? this.price,
    );
  }
}

class $SalesItemsTable extends SalesItems
    with TableInfo<$SalesItemsTable, SalesItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $SalesItemsTable(this._db, [this._alias]);
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

  final VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  GeneratedIntColumn _customerId;
  @override
  GeneratedIntColumn get customerId => _customerId ??= _constructCustomerId();
  GeneratedIntColumn _constructCustomerId() {
    return GeneratedIntColumn(
      'customer_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  GeneratedIntColumn _menuId;
  @override
  GeneratedIntColumn get menuId => _menuId ??= _constructMenuId();
  GeneratedIntColumn _constructMenuId() {
    return GeneratedIntColumn(
      'menu_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _stuffIdMeta = const VerificationMeta('stuffId');
  GeneratedIntColumn _stuffId;
  @override
  GeneratedIntColumn get stuffId => _stuffId ??= _constructStuffId();
  GeneratedIntColumn _constructStuffId() {
    return GeneratedIntColumn(
      'stuff_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _discountIdMeta = const VerificationMeta('discountId');
  GeneratedIntColumn _discountId;
  @override
  GeneratedIntColumn get discountId => _discountId ??= _constructDiscountId();
  GeneratedIntColumn _constructDiscountId() {
    return GeneratedIntColumn(
      'discount_id',
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
  List<GeneratedColumn> get $columns =>
      [id, date, customerId, menuId, stuffId, discountId, price];
  @override
  $SalesItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sales_items';
  @override
  final String actualTableName = 'sales_items';
  @override
  VerificationContext validateIntegrity(SalesItemsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (d.customerId.present) {
      context.handle(_customerIdMeta,
          customerId.isAcceptableValue(d.customerId.value, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (d.menuId.present) {
      context.handle(
          _menuIdMeta, menuId.isAcceptableValue(d.menuId.value, _menuIdMeta));
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (d.stuffId.present) {
      context.handle(_stuffIdMeta,
          stuffId.isAcceptableValue(d.stuffId.value, _stuffIdMeta));
    } else if (isInserting) {
      context.missing(_stuffIdMeta);
    }
    if (d.discountId.present) {
      context.handle(_discountIdMeta,
          discountId.isAcceptableValue(d.discountId.value, _discountIdMeta));
    } else if (isInserting) {
      context.missing(_discountIdMeta);
    }
    if (d.price.present) {
      context.handle(
          _priceMeta, price.isAcceptableValue(d.price.value, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SalesItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SalesItemsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.customerId.present) {
      map['customer_id'] = Variable<int, IntType>(d.customerId.value);
    }
    if (d.menuId.present) {
      map['menu_id'] = Variable<int, IntType>(d.menuId.value);
    }
    if (d.stuffId.present) {
      map['stuff_id'] = Variable<int, IntType>(d.stuffId.value);
    }
    if (d.discountId.present) {
      map['discount_id'] = Variable<int, IntType>(d.discountId.value);
    }
    if (d.price.present) {
      map['price'] = Variable<int, IntType>(d.price.value);
    }
    return map;
  }

  @override
  $SalesItemsTable createAlias(String alias) {
    return $SalesItemsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CustomersTable _customers;
  $CustomersTable get customers => _customers ??= $CustomersTable(this);
  $SalesItemsTable _salesItems;
  $SalesItemsTable get salesItems => _salesItems ??= $SalesItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [customers, salesItems];
}
