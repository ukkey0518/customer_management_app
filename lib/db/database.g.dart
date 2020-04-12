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

class SoldItem extends DataClass implements Insertable<SoldItem> {
  final int id;
  final DateTime date;
  final int customerId;
  final int stuffId;
  final int menuId;
  SoldItem(
      {@required this.id,
      @required this.date,
      @required this.customerId,
      @required this.stuffId,
      @required this.menuId});
  factory SoldItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return SoldItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      customerId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}customer_id']),
      stuffId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}stuff_id']),
      menuId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}menu_id']),
    );
  }
  factory SoldItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SoldItem(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerId: serializer.fromJson<int>(json['customerId']),
      stuffId: serializer.fromJson<int>(json['stuffId']),
      menuId: serializer.fromJson<int>(json['menuId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'customerId': serializer.toJson<int>(customerId),
      'stuffId': serializer.toJson<int>(stuffId),
      'menuId': serializer.toJson<int>(menuId),
    };
  }

  @override
  SoldItemsCompanion createCompanion(bool nullToAbsent) {
    return SoldItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      stuffId: stuffId == null && nullToAbsent
          ? const Value.absent()
          : Value(stuffId),
      menuId:
          menuId == null && nullToAbsent ? const Value.absent() : Value(menuId),
    );
  }

  SoldItem copyWith(
          {int id, DateTime date, int customerId, int stuffId, int menuId}) =>
      SoldItem(
        id: id ?? this.id,
        date: date ?? this.date,
        customerId: customerId ?? this.customerId,
        stuffId: stuffId ?? this.stuffId,
        menuId: menuId ?? this.menuId,
      );
  @override
  String toString() {
    return (StringBuffer('SoldItem(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('stuffId: $stuffId, ')
          ..write('menuId: $menuId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          date.hashCode,
          $mrjc(
              customerId.hashCode, $mrjc(stuffId.hashCode, menuId.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SoldItem &&
          other.id == this.id &&
          other.date == this.date &&
          other.customerId == this.customerId &&
          other.stuffId == this.stuffId &&
          other.menuId == this.menuId);
}

class SoldItemsCompanion extends UpdateCompanion<SoldItem> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> customerId;
  final Value<int> stuffId;
  final Value<int> menuId;
  const SoldItemsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.customerId = const Value.absent(),
    this.stuffId = const Value.absent(),
    this.menuId = const Value.absent(),
  });
  SoldItemsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime date,
    @required int customerId,
    @required int stuffId,
    @required int menuId,
  })  : date = Value(date),
        customerId = Value(customerId),
        stuffId = Value(stuffId),
        menuId = Value(menuId);
  SoldItemsCompanion copyWith(
      {Value<int> id,
      Value<DateTime> date,
      Value<int> customerId,
      Value<int> stuffId,
      Value<int> menuId}) {
    return SoldItemsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      stuffId: stuffId ?? this.stuffId,
      menuId: menuId ?? this.menuId,
    );
  }
}

class $SoldItemsTable extends SoldItems
    with TableInfo<$SoldItemsTable, SoldItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $SoldItemsTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [id, date, customerId, stuffId, menuId];
  @override
  $SoldItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sold_items';
  @override
  final String actualTableName = 'sold_items';
  @override
  VerificationContext validateIntegrity(SoldItemsCompanion d,
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
    if (d.stuffId.present) {
      context.handle(_stuffIdMeta,
          stuffId.isAcceptableValue(d.stuffId.value, _stuffIdMeta));
    } else if (isInserting) {
      context.missing(_stuffIdMeta);
    }
    if (d.menuId.present) {
      context.handle(
          _menuIdMeta, menuId.isAcceptableValue(d.menuId.value, _menuIdMeta));
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoldItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SoldItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SoldItemsCompanion d) {
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
    if (d.stuffId.present) {
      map['stuff_id'] = Variable<int, IntType>(d.stuffId.value);
    }
    if (d.menuId.present) {
      map['menu_id'] = Variable<int, IntType>(d.menuId.value);
    }
    return map;
  }

  @override
  $SoldItemsTable createAlias(String alias) {
    return $SoldItemsTable(_db, alias);
  }
}

class MenuCategory extends DataClass implements Insertable<MenuCategory> {
  final int id;
  final String name;
  MenuCategory({@required this.id, @required this.name});
  factory MenuCategory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MenuCategory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory MenuCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MenuCategory(
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

  @override
  MenuCategoriesCompanion createCompanion(bool nullToAbsent) {
    return MenuCategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  MenuCategory copyWith({int id, String name}) => MenuCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('MenuCategory(')
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
      (other is MenuCategory && other.id == this.id && other.name == this.name);
}

class MenuCategoriesCompanion extends UpdateCompanion<MenuCategory> {
  final Value<int> id;
  final Value<String> name;
  const MenuCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MenuCategoriesCompanion.insert({
    @required int id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  MenuCategoriesCompanion copyWith({Value<int> id, Value<String> name}) {
    return MenuCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
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
    return GeneratedIntColumn(
      'id',
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

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $MenuCategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'menu_categories';
  @override
  final String actualTableName = 'menu_categories';
  @override
  VerificationContext validateIntegrity(MenuCategoriesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Map<String, Variable> entityToSql(MenuCategoriesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $MenuCategoriesTable createAlias(String alias) {
    return $MenuCategoriesTable(_db, alias);
  }
}

class Menu extends DataClass implements Insertable<Menu> {
  final int id;
  final int menuCategoryId;
  final String name;
  final int price;
  Menu(
      {@required this.id,
      @required this.menuCategoryId,
      @required this.name,
      @required this.price});
  factory Menu.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Menu(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      menuCategoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}menu_category_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  factory Menu.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Menu(
      id: serializer.fromJson<int>(json['id']),
      menuCategoryId: serializer.fromJson<int>(json['menuCategoryId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuCategoryId': serializer.toJson<int>(menuCategoryId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
    };
  }

  @override
  MenusCompanion createCompanion(bool nullToAbsent) {
    return MenusCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      menuCategoryId: menuCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(menuCategoryId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  Menu copyWith({int id, int menuCategoryId, String name, int price}) => Menu(
        id: id ?? this.id,
        menuCategoryId: menuCategoryId ?? this.menuCategoryId,
        name: name ?? this.name,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('Menu(')
          ..write('id: $id, ')
          ..write('menuCategoryId: $menuCategoryId, ')
          ..write('name: $name, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(menuCategoryId.hashCode, $mrjc(name.hashCode, price.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Menu &&
          other.id == this.id &&
          other.menuCategoryId == this.menuCategoryId &&
          other.name == this.name &&
          other.price == this.price);
}

class MenusCompanion extends UpdateCompanion<Menu> {
  final Value<int> id;
  final Value<int> menuCategoryId;
  final Value<String> name;
  final Value<int> price;
  const MenusCompanion({
    this.id = const Value.absent(),
    this.menuCategoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
  });
  MenusCompanion.insert({
    @required int id,
    @required int menuCategoryId,
    @required String name,
    @required int price,
  })  : id = Value(id),
        menuCategoryId = Value(menuCategoryId),
        name = Value(name),
        price = Value(price);
  MenusCompanion copyWith(
      {Value<int> id,
      Value<int> menuCategoryId,
      Value<String> name,
      Value<int> price}) {
    return MenusCompanion(
      id: id ?? this.id,
      menuCategoryId: menuCategoryId ?? this.menuCategoryId,
      name: name ?? this.name,
      price: price ?? this.price,
    );
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
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _menuCategoryIdMeta =
      const VerificationMeta('menuCategoryId');
  GeneratedIntColumn _menuCategoryId;
  @override
  GeneratedIntColumn get menuCategoryId =>
      _menuCategoryId ??= _constructMenuCategoryId();
  GeneratedIntColumn _constructMenuCategoryId() {
    return GeneratedIntColumn(
      'menu_category_id',
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
  List<GeneratedColumn> get $columns => [id, menuCategoryId, name, price];
  @override
  $MenusTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'menus';
  @override
  final String actualTableName = 'menus';
  @override
  VerificationContext validateIntegrity(MenusCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.menuCategoryId.present) {
      context.handle(
          _menuCategoryIdMeta,
          menuCategoryId.isAcceptableValue(
              d.menuCategoryId.value, _menuCategoryIdMeta));
    } else if (isInserting) {
      context.missing(_menuCategoryIdMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Menu map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Menu.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MenusCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.menuCategoryId.present) {
      map['menu_category_id'] = Variable<int, IntType>(d.menuCategoryId.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.price.present) {
      map['price'] = Variable<int, IntType>(d.price.value);
    }
    return map;
  }

  @override
  $MenusTable createAlias(String alias) {
    return $MenusTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CustomersTable _customers;
  $CustomersTable get customers => _customers ??= $CustomersTable(this);
  $SoldItemsTable _soldItems;
  $SoldItemsTable get soldItems => _soldItems ??= $SoldItemsTable(this);
  $MenuCategoriesTable _menuCategories;
  $MenuCategoriesTable get menuCategories =>
      _menuCategories ??= $MenuCategoriesTable(this);
  $MenusTable _menus;
  $MenusTable get menus => _menus ??= $MenusTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [customers, soldItems, menuCategories, menus];
}
