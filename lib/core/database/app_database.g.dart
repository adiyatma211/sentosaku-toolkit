// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentNameMeta = const VerificationMeta(
    'parentName',
  );
  @override
  late final GeneratedColumn<String> parentName = GeneratedColumn<String>(
    'parent_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whatsappMeta = const VerificationMeta(
    'whatsapp',
  );
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
    'whatsapp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
    'school',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultSubjectMeta = const VerificationMeta(
    'defaultSubject',
  );
  @override
  late final GeneratedColumn<String> defaultSubject = GeneratedColumn<String>(
    'default_subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultAcademicPeriodIdMeta =
      const VerificationMeta('defaultAcademicPeriodId');
  @override
  late final GeneratedColumn<int> defaultAcademicPeriodId =
      GeneratedColumn<int>(
        'default_academic_period_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rateTypeMeta = const VerificationMeta(
    'rateType',
  );
  @override
  late final GeneratedColumn<String> rateType = GeneratedColumn<String>(
    'rate_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(RateType.perSession),
  );
  static const VerificationMeta _rateAmountMeta = const VerificationMeta(
    'rateAmount',
  );
  @override
  late final GeneratedColumn<int> rateAmount = GeneratedColumn<int>(
    'rate_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(StudentStatus.active),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    parentName,
    whatsapp,
    address,
    school,
    grade,
    defaultSubject,
    defaultAcademicPeriodId,
    rateType,
    rateAmount,
    status,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_name')) {
      context.handle(
        _parentNameMeta,
        parentName.isAcceptableOrUnknown(data['parent_name']!, _parentNameMeta),
      );
    }
    if (data.containsKey('whatsapp')) {
      context.handle(
        _whatsappMeta,
        whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('school')) {
      context.handle(
        _schoolMeta,
        school.isAcceptableOrUnknown(data['school']!, _schoolMeta),
      );
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('default_subject')) {
      context.handle(
        _defaultSubjectMeta,
        defaultSubject.isAcceptableOrUnknown(
          data['default_subject']!,
          _defaultSubjectMeta,
        ),
      );
    }
    if (data.containsKey('default_academic_period_id')) {
      context.handle(
        _defaultAcademicPeriodIdMeta,
        defaultAcademicPeriodId.isAcceptableOrUnknown(
          data['default_academic_period_id']!,
          _defaultAcademicPeriodIdMeta,
        ),
      );
    }
    if (data.containsKey('rate_type')) {
      context.handle(
        _rateTypeMeta,
        rateType.isAcceptableOrUnknown(data['rate_type']!, _rateTypeMeta),
      );
    }
    if (data.containsKey('rate_amount')) {
      context.handle(
        _rateAmountMeta,
        rateAmount.isAcceptableOrUnknown(data['rate_amount']!, _rateAmountMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_name'],
      ),
      whatsapp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}whatsapp'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      school: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school'],
      ),
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      ),
      defaultSubject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_subject'],
      ),
      defaultAcademicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_academic_period_id'],
      ),
      rateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rate_type'],
      )!,
      rateAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  final String? parentName;
  final String? whatsapp;
  final String? address;
  final String? school;
  final String? grade;
  final String? defaultSubject;
  final int? defaultAcademicPeriodId;
  final String rateType;
  final int rateAmount;
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Student({
    required this.id,
    required this.name,
    this.parentName,
    this.whatsapp,
    this.address,
    this.school,
    this.grade,
    this.defaultSubject,
    this.defaultAcademicPeriodId,
    required this.rateType,
    required this.rateAmount,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentName != null) {
      map['parent_name'] = Variable<String>(parentName);
    }
    if (!nullToAbsent || whatsapp != null) {
      map['whatsapp'] = Variable<String>(whatsapp);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || school != null) {
      map['school'] = Variable<String>(school);
    }
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || defaultSubject != null) {
      map['default_subject'] = Variable<String>(defaultSubject);
    }
    if (!nullToAbsent || defaultAcademicPeriodId != null) {
      map['default_academic_period_id'] = Variable<int>(
        defaultAcademicPeriodId,
      );
    }
    map['rate_type'] = Variable<String>(rateType);
    map['rate_amount'] = Variable<int>(rateAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      parentName: parentName == null && nullToAbsent
          ? const Value.absent()
          : Value(parentName),
      whatsapp: whatsapp == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsapp),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      school: school == null && nullToAbsent
          ? const Value.absent()
          : Value(school),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      defaultSubject: defaultSubject == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSubject),
      defaultAcademicPeriodId: defaultAcademicPeriodId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAcademicPeriodId),
      rateType: Value(rateType),
      rateAmount: Value(rateAmount),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentName: serializer.fromJson<String?>(json['parentName']),
      whatsapp: serializer.fromJson<String?>(json['whatsapp']),
      address: serializer.fromJson<String?>(json['address']),
      school: serializer.fromJson<String?>(json['school']),
      grade: serializer.fromJson<String?>(json['grade']),
      defaultSubject: serializer.fromJson<String?>(json['defaultSubject']),
      defaultAcademicPeriodId: serializer.fromJson<int?>(
        json['defaultAcademicPeriodId'],
      ),
      rateType: serializer.fromJson<String>(json['rateType']),
      rateAmount: serializer.fromJson<int>(json['rateAmount']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'parentName': serializer.toJson<String?>(parentName),
      'whatsapp': serializer.toJson<String?>(whatsapp),
      'address': serializer.toJson<String?>(address),
      'school': serializer.toJson<String?>(school),
      'grade': serializer.toJson<String?>(grade),
      'defaultSubject': serializer.toJson<String?>(defaultSubject),
      'defaultAcademicPeriodId': serializer.toJson<int?>(
        defaultAcademicPeriodId,
      ),
      'rateType': serializer.toJson<String>(rateType),
      'rateAmount': serializer.toJson<int>(rateAmount),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Student copyWith({
    int? id,
    String? name,
    Value<String?> parentName = const Value.absent(),
    Value<String?> whatsapp = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> school = const Value.absent(),
    Value<String?> grade = const Value.absent(),
    Value<String?> defaultSubject = const Value.absent(),
    Value<int?> defaultAcademicPeriodId = const Value.absent(),
    String? rateType,
    int? rateAmount,
    String? status,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Student(
    id: id ?? this.id,
    name: name ?? this.name,
    parentName: parentName.present ? parentName.value : this.parentName,
    whatsapp: whatsapp.present ? whatsapp.value : this.whatsapp,
    address: address.present ? address.value : this.address,
    school: school.present ? school.value : this.school,
    grade: grade.present ? grade.value : this.grade,
    defaultSubject: defaultSubject.present
        ? defaultSubject.value
        : this.defaultSubject,
    defaultAcademicPeriodId: defaultAcademicPeriodId.present
        ? defaultAcademicPeriodId.value
        : this.defaultAcademicPeriodId,
    rateType: rateType ?? this.rateType,
    rateAmount: rateAmount ?? this.rateAmount,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentName: data.parentName.present
          ? data.parentName.value
          : this.parentName,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      address: data.address.present ? data.address.value : this.address,
      school: data.school.present ? data.school.value : this.school,
      grade: data.grade.present ? data.grade.value : this.grade,
      defaultSubject: data.defaultSubject.present
          ? data.defaultSubject.value
          : this.defaultSubject,
      defaultAcademicPeriodId: data.defaultAcademicPeriodId.present
          ? data.defaultAcademicPeriodId.value
          : this.defaultAcademicPeriodId,
      rateType: data.rateType.present ? data.rateType.value : this.rateType,
      rateAmount: data.rateAmount.present
          ? data.rateAmount.value
          : this.rateAmount,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentName: $parentName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('school: $school, ')
          ..write('grade: $grade, ')
          ..write('defaultSubject: $defaultSubject, ')
          ..write('defaultAcademicPeriodId: $defaultAcademicPeriodId, ')
          ..write('rateType: $rateType, ')
          ..write('rateAmount: $rateAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    parentName,
    whatsapp,
    address,
    school,
    grade,
    defaultSubject,
    defaultAcademicPeriodId,
    rateType,
    rateAmount,
    status,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentName == this.parentName &&
          other.whatsapp == this.whatsapp &&
          other.address == this.address &&
          other.school == this.school &&
          other.grade == this.grade &&
          other.defaultSubject == this.defaultSubject &&
          other.defaultAcademicPeriodId == this.defaultAcademicPeriodId &&
          other.rateType == this.rateType &&
          other.rateAmount == this.rateAmount &&
          other.status == this.status &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> parentName;
  final Value<String?> whatsapp;
  final Value<String?> address;
  final Value<String?> school;
  final Value<String?> grade;
  final Value<String?> defaultSubject;
  final Value<int?> defaultAcademicPeriodId;
  final Value<String> rateType;
  final Value<int> rateAmount;
  final Value<String> status;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentName = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.school = const Value.absent(),
    this.grade = const Value.absent(),
    this.defaultSubject = const Value.absent(),
    this.defaultAcademicPeriodId = const Value.absent(),
    this.rateType = const Value.absent(),
    this.rateAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.parentName = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.school = const Value.absent(),
    this.grade = const Value.absent(),
    this.defaultSubject = const Value.absent(),
    this.defaultAcademicPeriodId = const Value.absent(),
    this.rateType = const Value.absent(),
    this.rateAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? parentName,
    Expression<String>? whatsapp,
    Expression<String>? address,
    Expression<String>? school,
    Expression<String>? grade,
    Expression<String>? defaultSubject,
    Expression<int>? defaultAcademicPeriodId,
    Expression<String>? rateType,
    Expression<int>? rateAmount,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentName != null) 'parent_name': parentName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (address != null) 'address': address,
      if (school != null) 'school': school,
      if (grade != null) 'grade': grade,
      if (defaultSubject != null) 'default_subject': defaultSubject,
      if (defaultAcademicPeriodId != null)
        'default_academic_period_id': defaultAcademicPeriodId,
      if (rateType != null) 'rate_type': rateType,
      if (rateAmount != null) 'rate_amount': rateAmount,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? parentName,
    Value<String?>? whatsapp,
    Value<String?>? address,
    Value<String?>? school,
    Value<String?>? grade,
    Value<String?>? defaultSubject,
    Value<int?>? defaultAcademicPeriodId,
    Value<String>? rateType,
    Value<int>? rateAmount,
    Value<String>? status,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentName: parentName ?? this.parentName,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      school: school ?? this.school,
      grade: grade ?? this.grade,
      defaultSubject: defaultSubject ?? this.defaultSubject,
      defaultAcademicPeriodId:
          defaultAcademicPeriodId ?? this.defaultAcademicPeriodId,
      rateType: rateType ?? this.rateType,
      rateAmount: rateAmount ?? this.rateAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
    if (parentName.present) {
      map['parent_name'] = Variable<String>(parentName.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (defaultSubject.present) {
      map['default_subject'] = Variable<String>(defaultSubject.value);
    }
    if (defaultAcademicPeriodId.present) {
      map['default_academic_period_id'] = Variable<int>(
        defaultAcademicPeriodId.value,
      );
    }
    if (rateType.present) {
      map['rate_type'] = Variable<String>(rateType.value);
    }
    if (rateAmount.present) {
      map['rate_amount'] = Variable<int>(rateAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentName: $parentName, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('school: $school, ')
          ..write('grade: $grade, ')
          ..write('defaultSubject: $defaultSubject, ')
          ..write('defaultAcademicPeriodId: $defaultAcademicPeriodId, ')
          ..write('rateType: $rateType, ')
          ..write('rateAmount: $rateAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultRateAmountMeta = const VerificationMeta(
    'defaultRateAmount',
  );
  @override
  late final GeneratedColumn<int> defaultRateAmount = GeneratedColumn<int>(
    'default_rate_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    name,
    defaultRateAmount,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('default_rate_amount')) {
      context.handle(
        _defaultRateAmountMeta,
        defaultRateAmount.isAcceptableOrUnknown(
          data['default_rate_amount']!,
          _defaultRateAmountMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultRateAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_rate_amount'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final int? studentId;
  final String name;
  final int defaultRateAmount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subject({
    required this.id,
    this.studentId,
    required this.name,
    required this.defaultRateAmount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || studentId != null) {
      map['student_id'] = Variable<int>(studentId);
    }
    map['name'] = Variable<String>(name);
    map['default_rate_amount'] = Variable<int>(defaultRateAmount);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      studentId: studentId == null && nullToAbsent
          ? const Value.absent()
          : Value(studentId),
      name: Value(name),
      defaultRateAmount: Value(defaultRateAmount),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int?>(json['studentId']),
      name: serializer.fromJson<String>(json['name']),
      defaultRateAmount: serializer.fromJson<int>(json['defaultRateAmount']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int?>(studentId),
      'name': serializer.toJson<String>(name),
      'defaultRateAmount': serializer.toJson<int>(defaultRateAmount),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Subject copyWith({
    int? id,
    Value<int?> studentId = const Value.absent(),
    String? name,
    int? defaultRateAmount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    studentId: studentId.present ? studentId.value : this.studentId,
    name: name ?? this.name,
    defaultRateAmount: defaultRateAmount ?? this.defaultRateAmount,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      name: data.name.present ? data.name.value : this.name,
      defaultRateAmount: data.defaultRateAmount.present
          ? data.defaultRateAmount.value
          : this.defaultRateAmount,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('name: $name, ')
          ..write('defaultRateAmount: $defaultRateAmount, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    name,
    defaultRateAmount,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.name == this.name &&
          other.defaultRateAmount == this.defaultRateAmount &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<int?> studentId;
  final Value<String> name;
  final Value<int> defaultRateAmount;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultRateAmount = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    required String name,
    this.defaultRateAmount = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<String>? name,
    Expression<int>? defaultRateAmount,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (name != null) 'name': name,
      if (defaultRateAmount != null) 'default_rate_amount': defaultRateAmount,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<int?>? studentId,
    Value<String>? name,
    Value<int>? defaultRateAmount,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      defaultRateAmount: defaultRateAmount ?? this.defaultRateAmount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultRateAmount.present) {
      map['default_rate_amount'] = Variable<int>(defaultRateAmount.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('name: $name, ')
          ..write('defaultRateAmount: $defaultRateAmount, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AcademicPeriodsTable extends AcademicPeriods
    with TableInfo<$AcademicPeriodsTable, AcademicPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcademicPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodTypeMeta = const VerificationMeta(
    'periodType',
  );
  @override
  late final GeneratedColumn<String> periodType = GeneratedColumn<String>(
    'period_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(AcademicPeriodType.semester),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    periodType,
    startDate,
    endDate,
    isActive,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'academic_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<AcademicPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('period_type')) {
      context.handle(
        _periodTypeMeta,
        periodType.isAcceptableOrUnknown(data['period_type']!, _periodTypeMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AcademicPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AcademicPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      periodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $AcademicPeriodsTable createAlias(String alias) {
    return $AcademicPeriodsTable(attachedDatabase, alias);
  }
}

class AcademicPeriod extends DataClass implements Insertable<AcademicPeriod> {
  final int id;
  final String name;
  final String periodType;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const AcademicPeriod({
    required this.id,
    required this.name,
    required this.periodType,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['period_type'] = Variable<String>(periodType);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  AcademicPeriodsCompanion toCompanion(bool nullToAbsent) {
    return AcademicPeriodsCompanion(
      id: Value(id),
      name: Value(name),
      periodType: Value(periodType),
      startDate: Value(startDate),
      endDate: Value(endDate),
      isActive: Value(isActive),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AcademicPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AcademicPeriod(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      periodType: serializer.fromJson<String>(json['periodType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'periodType': serializer.toJson<String>(periodType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'isActive': serializer.toJson<bool>(isActive),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  AcademicPeriod copyWith({
    int? id,
    String? name,
    String? periodType,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => AcademicPeriod(
    id: id ?? this.id,
    name: name ?? this.name,
    periodType: periodType ?? this.periodType,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    isActive: isActive ?? this.isActive,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  AcademicPeriod copyWithCompanion(AcademicPeriodsCompanion data) {
    return AcademicPeriod(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      periodType: data.periodType.present
          ? data.periodType.value
          : this.periodType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AcademicPeriod(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('periodType: $periodType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    periodType,
    startDate,
    endDate,
    isActive,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AcademicPeriod &&
          other.id == this.id &&
          other.name == this.name &&
          other.periodType == this.periodType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isActive == this.isActive &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AcademicPeriodsCompanion extends UpdateCompanion<AcademicPeriod> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> periodType;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> isActive;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const AcademicPeriodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.periodType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  AcademicPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.periodType = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.isActive = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : name = Value(name),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<AcademicPeriod> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? periodType,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isActive,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (periodType != null) 'period_type': periodType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isActive != null) 'is_active': isActive,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  AcademicPeriodsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? periodType,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<bool>? isActive,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return AcademicPeriodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      periodType: periodType ?? this.periodType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
    if (periodType.present) {
      map['period_type'] = Variable<String>(periodType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcademicPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('periodType: $periodType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentPeriodsTable extends StudentPeriods
    with TableInfo<$StudentPeriodsTable, StudentPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _enrolledAtMeta = const VerificationMeta(
    'enrolledAt',
  );
  @override
  late final GeneratedColumn<DateTime> enrolledAt = GeneratedColumn<DateTime>(
    'enrolled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(StudentPeriodStatus.active),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    academicPeriodId,
    enrolledAt,
    status,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicPeriodIdMeta);
    }
    if (data.containsKey('enrolled_at')) {
      context.handle(
        _enrolledAtMeta,
        enrolledAt.isAcceptableOrUnknown(data['enrolled_at']!, _enrolledAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      )!,
      enrolledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}enrolled_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $StudentPeriodsTable createAlias(String alias) {
    return $StudentPeriodsTable(attachedDatabase, alias);
  }
}

class StudentPeriod extends DataClass implements Insertable<StudentPeriod> {
  final int id;
  final int studentId;
  final int academicPeriodId;
  final DateTime enrolledAt;
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const StudentPeriod({
    required this.id,
    required this.studentId,
    required this.academicPeriodId,
    required this.enrolledAt,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['academic_period_id'] = Variable<int>(academicPeriodId);
    map['enrolled_at'] = Variable<DateTime>(enrolledAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  StudentPeriodsCompanion toCompanion(bool nullToAbsent) {
    return StudentPeriodsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      academicPeriodId: Value(academicPeriodId),
      enrolledAt: Value(enrolledAt),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory StudentPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentPeriod(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      academicPeriodId: serializer.fromJson<int>(json['academicPeriodId']),
      enrolledAt: serializer.fromJson<DateTime>(json['enrolledAt']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'academicPeriodId': serializer.toJson<int>(academicPeriodId),
      'enrolledAt': serializer.toJson<DateTime>(enrolledAt),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  StudentPeriod copyWith({
    int? id,
    int? studentId,
    int? academicPeriodId,
    DateTime? enrolledAt,
    String? status,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => StudentPeriod(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    academicPeriodId: academicPeriodId ?? this.academicPeriodId,
    enrolledAt: enrolledAt ?? this.enrolledAt,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  StudentPeriod copyWithCompanion(StudentPeriodsCompanion data) {
    return StudentPeriod(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      enrolledAt: data.enrolledAt.present
          ? data.enrolledAt.value
          : this.enrolledAt,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentPeriod(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    academicPeriodId,
    enrolledAt,
    status,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentPeriod &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.enrolledAt == this.enrolledAt &&
          other.status == this.status &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class StudentPeriodsCompanion extends UpdateCompanion<StudentPeriod> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> academicPeriodId;
  final Value<DateTime> enrolledAt;
  final Value<String> status;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const StudentPeriodsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.enrolledAt = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  StudentPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int academicPeriodId,
    this.enrolledAt = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       academicPeriodId = Value(academicPeriodId);
  static Insertable<StudentPeriod> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? academicPeriodId,
    Expression<DateTime>? enrolledAt,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (enrolledAt != null) 'enrolled_at': enrolledAt,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  StudentPeriodsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? academicPeriodId,
    Value<DateTime>? enrolledAt,
    Value<String>? status,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return StudentPeriodsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (enrolledAt.present) {
      map['enrolled_at'] = Variable<DateTime>(enrolledAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleTypeMeta = const VerificationMeta(
    'scheduleType',
  );
  @override
  late final GeneratedColumn<String> scheduleType = GeneratedColumn<String>(
    'schedule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ScheduleType.once),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ScheduleStatus.scheduled),
  );
  static const VerificationMeta _recurrenceGroupIdMeta = const VerificationMeta(
    'recurrenceGroupId',
  );
  @override
  late final GeneratedColumn<String> recurrenceGroupId =
      GeneratedColumn<String>(
        'recurrence_group_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderOffsetMinutesMeta =
      const VerificationMeta('reminderOffsetMinutes');
  @override
  late final GeneratedColumn<int> reminderOffsetMinutes = GeneratedColumn<int>(
    'reminder_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRescheduledAtMeta = const VerificationMeta(
    'lastRescheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRescheduledAt =
      GeneratedColumn<DateTime>(
        'last_rescheduled_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    subjectId,
    academicPeriodId,
    date,
    startTime,
    endTime,
    scheduleType,
    status,
    recurrenceGroupId,
    reminderEnabled,
    reminderOffsetMinutes,
    note,
    lastRescheduledAt,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Schedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('schedule_type')) {
      context.handle(
        _scheduleTypeMeta,
        scheduleType.isAcceptableOrUnknown(
          data['schedule_type']!,
          _scheduleTypeMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('recurrence_group_id')) {
      context.handle(
        _recurrenceGroupIdMeta,
        recurrenceGroupId.isAcceptableOrUnknown(
          data['recurrence_group_id']!,
          _recurrenceGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_offset_minutes')) {
      context.handle(
        _reminderOffsetMinutesMeta,
        reminderOffsetMinutes.isAcceptableOrUnknown(
          data['reminder_offset_minutes']!,
          _reminderOffsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('last_rescheduled_at')) {
      context.handle(
        _lastRescheduledAtMeta,
        lastRescheduledAt.isAcceptableOrUnknown(
          data['last_rescheduled_at']!,
          _lastRescheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      scheduleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      recurrenceGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_group_id'],
      ),
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      reminderOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_offset_minutes'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      lastRescheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_rescheduled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final int studentId;
  final int subjectId;
  final int? academicPeriodId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String scheduleType;
  final String status;
  final String? recurrenceGroupId;
  final bool reminderEnabled;
  final int reminderOffsetMinutes;
  final String? note;
  final DateTime? lastRescheduledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Schedule({
    required this.id,
    required this.studentId,
    required this.subjectId,
    this.academicPeriodId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.scheduleType,
    required this.status,
    this.recurrenceGroupId,
    required this.reminderEnabled,
    required this.reminderOffsetMinutes,
    this.note,
    this.lastRescheduledAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['subject_id'] = Variable<int>(subjectId);
    if (!nullToAbsent || academicPeriodId != null) {
      map['academic_period_id'] = Variable<int>(academicPeriodId);
    }
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['schedule_type'] = Variable<String>(scheduleType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || recurrenceGroupId != null) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['reminder_offset_minutes'] = Variable<int>(reminderOffsetMinutes);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || lastRescheduledAt != null) {
      map['last_rescheduled_at'] = Variable<DateTime>(lastRescheduledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      subjectId: Value(subjectId),
      academicPeriodId: academicPeriodId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicPeriodId),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
      scheduleType: Value(scheduleType),
      status: Value(status),
      recurrenceGroupId: recurrenceGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceGroupId),
      reminderEnabled: Value(reminderEnabled),
      reminderOffsetMinutes: Value(reminderOffsetMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      lastRescheduledAt: lastRescheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRescheduledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Schedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      academicPeriodId: serializer.fromJson<int?>(json['academicPeriodId']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      scheduleType: serializer.fromJson<String>(json['scheduleType']),
      status: serializer.fromJson<String>(json['status']),
      recurrenceGroupId: serializer.fromJson<String?>(
        json['recurrenceGroupId'],
      ),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderOffsetMinutes: serializer.fromJson<int>(
        json['reminderOffsetMinutes'],
      ),
      note: serializer.fromJson<String?>(json['note']),
      lastRescheduledAt: serializer.fromJson<DateTime?>(
        json['lastRescheduledAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'subjectId': serializer.toJson<int>(subjectId),
      'academicPeriodId': serializer.toJson<int?>(academicPeriodId),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'scheduleType': serializer.toJson<String>(scheduleType),
      'status': serializer.toJson<String>(status),
      'recurrenceGroupId': serializer.toJson<String?>(recurrenceGroupId),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderOffsetMinutes': serializer.toJson<int>(reminderOffsetMinutes),
      'note': serializer.toJson<String?>(note),
      'lastRescheduledAt': serializer.toJson<DateTime?>(lastRescheduledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Schedule copyWith({
    int? id,
    int? studentId,
    int? subjectId,
    Value<int?> academicPeriodId = const Value.absent(),
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    String? scheduleType,
    String? status,
    Value<String?> recurrenceGroupId = const Value.absent(),
    bool? reminderEnabled,
    int? reminderOffsetMinutes,
    Value<String?> note = const Value.absent(),
    Value<DateTime?> lastRescheduledAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Schedule(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    subjectId: subjectId ?? this.subjectId,
    academicPeriodId: academicPeriodId.present
        ? academicPeriodId.value
        : this.academicPeriodId,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    scheduleType: scheduleType ?? this.scheduleType,
    status: status ?? this.status,
    recurrenceGroupId: recurrenceGroupId.present
        ? recurrenceGroupId.value
        : this.recurrenceGroupId,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderOffsetMinutes: reminderOffsetMinutes ?? this.reminderOffsetMinutes,
    note: note.present ? note.value : this.note,
    lastRescheduledAt: lastRescheduledAt.present
        ? lastRescheduledAt.value
        : this.lastRescheduledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      status: data.status.present ? data.status.value : this.status,
      recurrenceGroupId: data.recurrenceGroupId.present
          ? data.recurrenceGroupId.value
          : this.recurrenceGroupId,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderOffsetMinutes: data.reminderOffsetMinutes.present
          ? data.reminderOffsetMinutes.value
          : this.reminderOffsetMinutes,
      note: data.note.present ? data.note.value : this.note,
      lastRescheduledAt: data.lastRescheduledAt.present
          ? data.lastRescheduledAt.value
          : this.lastRescheduledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('status: $status, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderOffsetMinutes: $reminderOffsetMinutes, ')
          ..write('note: $note, ')
          ..write('lastRescheduledAt: $lastRescheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    subjectId,
    academicPeriodId,
    date,
    startTime,
    endTime,
    scheduleType,
    status,
    recurrenceGroupId,
    reminderEnabled,
    reminderOffsetMinutes,
    note,
    lastRescheduledAt,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.subjectId == this.subjectId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.scheduleType == this.scheduleType &&
          other.status == this.status &&
          other.recurrenceGroupId == this.recurrenceGroupId &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderOffsetMinutes == this.reminderOffsetMinutes &&
          other.note == this.note &&
          other.lastRescheduledAt == this.lastRescheduledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> subjectId;
  final Value<int?> academicPeriodId;
  final Value<DateTime> date;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> scheduleType;
  final Value<String> status;
  final Value<String?> recurrenceGroupId;
  final Value<bool> reminderEnabled;
  final Value<int> reminderOffsetMinutes;
  final Value<String?> note;
  final Value<DateTime?> lastRescheduledAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.status = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderOffsetMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.lastRescheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int subjectId,
    this.academicPeriodId = const Value.absent(),
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    this.scheduleType = const Value.absent(),
    this.status = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderOffsetMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.lastRescheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       subjectId = Value(subjectId),
       date = Value(date),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? subjectId,
    Expression<int>? academicPeriodId,
    Expression<DateTime>? date,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? scheduleType,
    Expression<String>? status,
    Expression<String>? recurrenceGroupId,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderOffsetMinutes,
    Expression<String>? note,
    Expression<DateTime>? lastRescheduledAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (subjectId != null) 'subject_id': subjectId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (status != null) 'status': status,
      if (recurrenceGroupId != null) 'recurrence_group_id': recurrenceGroupId,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderOffsetMinutes != null)
        'reminder_offset_minutes': reminderOffsetMinutes,
      if (note != null) 'note': note,
      if (lastRescheduledAt != null) 'last_rescheduled_at': lastRescheduledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  SchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? subjectId,
    Value<int?>? academicPeriodId,
    Value<DateTime>? date,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<String>? scheduleType,
    Value<String>? status,
    Value<String?>? recurrenceGroupId,
    Value<bool>? reminderEnabled,
    Value<int>? reminderOffsetMinutes,
    Value<String?>? note,
    Value<DateTime?>? lastRescheduledAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return SchedulesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      scheduleType: scheduleType ?? this.scheduleType,
      status: status ?? this.status,
      recurrenceGroupId: recurrenceGroupId ?? this.recurrenceGroupId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderOffsetMinutes:
          reminderOffsetMinutes ?? this.reminderOffsetMinutes,
      note: note ?? this.note,
      lastRescheduledAt: lastRescheduledAt ?? this.lastRescheduledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(scheduleType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (recurrenceGroupId.present) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderOffsetMinutes.present) {
      map['reminder_offset_minutes'] = Variable<int>(
        reminderOffsetMinutes.value,
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (lastRescheduledAt.present) {
      map['last_rescheduled_at'] = Variable<DateTime>(lastRescheduledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('status: $status, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderOffsetMinutes: $reminderOffsetMinutes, ')
          ..write('note: $note, ')
          ..write('lastRescheduledAt: $lastRescheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scheduleIdMeta = const VerificationMeta(
    'scheduleId',
  );
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
    'schedule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES schedules (id)',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<DateTime> sessionDate = GeneratedColumn<DateTime>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _attendanceStatusMeta = const VerificationMeta(
    'attendanceStatus',
  );
  @override
  late final GeneratedColumn<String> attendanceStatus = GeneratedColumn<String>(
    'attendance_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(AttendanceStatus.present),
  );
  static const VerificationMeta _materialMeta = const VerificationMeta(
    'material',
  );
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
    'material',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeworkMeta = const VerificationMeta(
    'homework',
  );
  @override
  late final GeneratedColumn<String> homework = GeneratedColumn<String>(
    'homework',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressNoteMeta = const VerificationMeta(
    'progressNote',
  );
  @override
  late final GeneratedColumn<String> progressNote = GeneratedColumn<String>(
    'progress_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feeAmountMeta = const VerificationMeta(
    'feeAmount',
  );
  @override
  late final GeneratedColumn<int> feeAmount = GeneratedColumn<int>(
    'fee_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isAttendanceSourceMeta =
      const VerificationMeta('isAttendanceSource');
  @override
  late final GeneratedColumn<bool> isAttendanceSource = GeneratedColumn<bool>(
    'is_attendance_source',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_attendance_source" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scheduleId,
    studentId,
    subjectId,
    academicPeriodId,
    sessionDate,
    startTime,
    endTime,
    attendanceStatus,
    material,
    homework,
    note,
    progressNote,
    feeAmount,
    isAttendanceSource,
    invoiceId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
        _scheduleIdMeta,
        scheduleId.isAcceptableOrUnknown(data['schedule_id']!, _scheduleIdMeta),
      );
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('attendance_status')) {
      context.handle(
        _attendanceStatusMeta,
        attendanceStatus.isAcceptableOrUnknown(
          data['attendance_status']!,
          _attendanceStatusMeta,
        ),
      );
    }
    if (data.containsKey('material')) {
      context.handle(
        _materialMeta,
        material.isAcceptableOrUnknown(data['material']!, _materialMeta),
      );
    }
    if (data.containsKey('homework')) {
      context.handle(
        _homeworkMeta,
        homework.isAcceptableOrUnknown(data['homework']!, _homeworkMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('progress_note')) {
      context.handle(
        _progressNoteMeta,
        progressNote.isAcceptableOrUnknown(
          data['progress_note']!,
          _progressNoteMeta,
        ),
      );
    }
    if (data.containsKey('fee_amount')) {
      context.handle(
        _feeAmountMeta,
        feeAmount.isAcceptableOrUnknown(data['fee_amount']!, _feeAmountMeta),
      );
    }
    if (data.containsKey('is_attendance_source')) {
      context.handle(
        _isAttendanceSourceMeta,
        isAttendanceSource.isAcceptableOrUnknown(
          data['is_attendance_source']!,
          _isAttendanceSourceMeta,
        ),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scheduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_id'],
      ),
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      ),
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}session_date'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      attendanceStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance_status'],
      )!,
      material: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material'],
      ),
      homework: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}homework'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      progressNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}progress_note'],
      ),
      feeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee_amount'],
      )!,
      isAttendanceSource: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_attendance_source'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int? scheduleId;
  final int studentId;
  final int subjectId;
  final int? academicPeriodId;
  final DateTime sessionDate;
  final DateTime startTime;
  final DateTime endTime;
  final String attendanceStatus;
  final String? material;
  final String? homework;
  final String? note;
  final String? progressNote;
  final int feeAmount;
  final bool isAttendanceSource;
  final int? invoiceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Session({
    required this.id,
    this.scheduleId,
    required this.studentId,
    required this.subjectId,
    this.academicPeriodId,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.attendanceStatus,
    this.material,
    this.homework,
    this.note,
    this.progressNote,
    required this.feeAmount,
    required this.isAttendanceSource,
    this.invoiceId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<int>(scheduleId);
    }
    map['student_id'] = Variable<int>(studentId);
    map['subject_id'] = Variable<int>(subjectId);
    if (!nullToAbsent || academicPeriodId != null) {
      map['academic_period_id'] = Variable<int>(academicPeriodId);
    }
    map['session_date'] = Variable<DateTime>(sessionDate);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['attendance_status'] = Variable<String>(attendanceStatus);
    if (!nullToAbsent || material != null) {
      map['material'] = Variable<String>(material);
    }
    if (!nullToAbsent || homework != null) {
      map['homework'] = Variable<String>(homework);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || progressNote != null) {
      map['progress_note'] = Variable<String>(progressNote);
    }
    map['fee_amount'] = Variable<int>(feeAmount);
    map['is_attendance_source'] = Variable<bool>(isAttendanceSource);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
      studentId: Value(studentId),
      subjectId: Value(subjectId),
      academicPeriodId: academicPeriodId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicPeriodId),
      sessionDate: Value(sessionDate),
      startTime: Value(startTime),
      endTime: Value(endTime),
      attendanceStatus: Value(attendanceStatus),
      material: material == null && nullToAbsent
          ? const Value.absent()
          : Value(material),
      homework: homework == null && nullToAbsent
          ? const Value.absent()
          : Value(homework),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      progressNote: progressNote == null && nullToAbsent
          ? const Value.absent()
          : Value(progressNote),
      feeAmount: Value(feeAmount),
      isAttendanceSource: Value(isAttendanceSource),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<int?>(json['scheduleId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      academicPeriodId: serializer.fromJson<int?>(json['academicPeriodId']),
      sessionDate: serializer.fromJson<DateTime>(json['sessionDate']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      attendanceStatus: serializer.fromJson<String>(json['attendanceStatus']),
      material: serializer.fromJson<String?>(json['material']),
      homework: serializer.fromJson<String?>(json['homework']),
      note: serializer.fromJson<String?>(json['note']),
      progressNote: serializer.fromJson<String?>(json['progressNote']),
      feeAmount: serializer.fromJson<int>(json['feeAmount']),
      isAttendanceSource: serializer.fromJson<bool>(json['isAttendanceSource']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<int?>(scheduleId),
      'studentId': serializer.toJson<int>(studentId),
      'subjectId': serializer.toJson<int>(subjectId),
      'academicPeriodId': serializer.toJson<int?>(academicPeriodId),
      'sessionDate': serializer.toJson<DateTime>(sessionDate),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'attendanceStatus': serializer.toJson<String>(attendanceStatus),
      'material': serializer.toJson<String?>(material),
      'homework': serializer.toJson<String?>(homework),
      'note': serializer.toJson<String?>(note),
      'progressNote': serializer.toJson<String?>(progressNote),
      'feeAmount': serializer.toJson<int>(feeAmount),
      'isAttendanceSource': serializer.toJson<bool>(isAttendanceSource),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Session copyWith({
    int? id,
    Value<int?> scheduleId = const Value.absent(),
    int? studentId,
    int? subjectId,
    Value<int?> academicPeriodId = const Value.absent(),
    DateTime? sessionDate,
    DateTime? startTime,
    DateTime? endTime,
    String? attendanceStatus,
    Value<String?> material = const Value.absent(),
    Value<String?> homework = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> progressNote = const Value.absent(),
    int? feeAmount,
    bool? isAttendanceSource,
    Value<int?> invoiceId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Session(
    id: id ?? this.id,
    scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
    studentId: studentId ?? this.studentId,
    subjectId: subjectId ?? this.subjectId,
    academicPeriodId: academicPeriodId.present
        ? academicPeriodId.value
        : this.academicPeriodId,
    sessionDate: sessionDate ?? this.sessionDate,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    attendanceStatus: attendanceStatus ?? this.attendanceStatus,
    material: material.present ? material.value : this.material,
    homework: homework.present ? homework.value : this.homework,
    note: note.present ? note.value : this.note,
    progressNote: progressNote.present ? progressNote.value : this.progressNote,
    feeAmount: feeAmount ?? this.feeAmount,
    isAttendanceSource: isAttendanceSource ?? this.isAttendanceSource,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      scheduleId: data.scheduleId.present
          ? data.scheduleId.value
          : this.scheduleId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      attendanceStatus: data.attendanceStatus.present
          ? data.attendanceStatus.value
          : this.attendanceStatus,
      material: data.material.present ? data.material.value : this.material,
      homework: data.homework.present ? data.homework.value : this.homework,
      note: data.note.present ? data.note.value : this.note,
      progressNote: data.progressNote.present
          ? data.progressNote.value
          : this.progressNote,
      feeAmount: data.feeAmount.present ? data.feeAmount.value : this.feeAmount,
      isAttendanceSource: data.isAttendanceSource.present
          ? data.isAttendanceSource.value
          : this.isAttendanceSource,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendanceStatus: $attendanceStatus, ')
          ..write('material: $material, ')
          ..write('homework: $homework, ')
          ..write('note: $note, ')
          ..write('progressNote: $progressNote, ')
          ..write('feeAmount: $feeAmount, ')
          ..write('isAttendanceSource: $isAttendanceSource, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scheduleId,
    studentId,
    subjectId,
    academicPeriodId,
    sessionDate,
    startTime,
    endTime,
    attendanceStatus,
    material,
    homework,
    note,
    progressNote,
    feeAmount,
    isAttendanceSource,
    invoiceId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.studentId == this.studentId &&
          other.subjectId == this.subjectId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.sessionDate == this.sessionDate &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.attendanceStatus == this.attendanceStatus &&
          other.material == this.material &&
          other.homework == this.homework &&
          other.note == this.note &&
          other.progressNote == this.progressNote &&
          other.feeAmount == this.feeAmount &&
          other.isAttendanceSource == this.isAttendanceSource &&
          other.invoiceId == this.invoiceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int?> scheduleId;
  final Value<int> studentId;
  final Value<int> subjectId;
  final Value<int?> academicPeriodId;
  final Value<DateTime> sessionDate;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> attendanceStatus;
  final Value<String?> material;
  final Value<String?> homework;
  final Value<String?> note;
  final Value<String?> progressNote;
  final Value<int> feeAmount;
  final Value<bool> isAttendanceSource;
  final Value<int?> invoiceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.attendanceStatus = const Value.absent(),
    this.material = const Value.absent(),
    this.homework = const Value.absent(),
    this.note = const Value.absent(),
    this.progressNote = const Value.absent(),
    this.feeAmount = const Value.absent(),
    this.isAttendanceSource = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    required int studentId,
    required int subjectId,
    this.academicPeriodId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.attendanceStatus = const Value.absent(),
    this.material = const Value.absent(),
    this.homework = const Value.absent(),
    this.note = const Value.absent(),
    this.progressNote = const Value.absent(),
    this.feeAmount = const Value.absent(),
    this.isAttendanceSource = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       subjectId = Value(subjectId);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? scheduleId,
    Expression<int>? studentId,
    Expression<int>? subjectId,
    Expression<int>? academicPeriodId,
    Expression<DateTime>? sessionDate,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? attendanceStatus,
    Expression<String>? material,
    Expression<String>? homework,
    Expression<String>? note,
    Expression<String>? progressNote,
    Expression<int>? feeAmount,
    Expression<bool>? isAttendanceSource,
    Expression<int>? invoiceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (studentId != null) 'student_id': studentId,
      if (subjectId != null) 'subject_id': subjectId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (sessionDate != null) 'session_date': sessionDate,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (attendanceStatus != null) 'attendance_status': attendanceStatus,
      if (material != null) 'material': material,
      if (homework != null) 'homework': homework,
      if (note != null) 'note': note,
      if (progressNote != null) 'progress_note': progressNote,
      if (feeAmount != null) 'fee_amount': feeAmount,
      if (isAttendanceSource != null)
        'is_attendance_source': isAttendanceSource,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? scheduleId,
    Value<int>? studentId,
    Value<int>? subjectId,
    Value<int?>? academicPeriodId,
    Value<DateTime>? sessionDate,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<String>? attendanceStatus,
    Value<String?>? material,
    Value<String?>? homework,
    Value<String?>? note,
    Value<String?>? progressNote,
    Value<int>? feeAmount,
    Value<bool>? isAttendanceSource,
    Value<int?>? invoiceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      sessionDate: sessionDate ?? this.sessionDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      material: material ?? this.material,
      homework: homework ?? this.homework,
      note: note ?? this.note,
      progressNote: progressNote ?? this.progressNote,
      feeAmount: feeAmount ?? this.feeAmount,
      isAttendanceSource: isAttendanceSource ?? this.isAttendanceSource,
      invoiceId: invoiceId ?? this.invoiceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<DateTime>(sessionDate.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (attendanceStatus.present) {
      map['attendance_status'] = Variable<String>(attendanceStatus.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (homework.present) {
      map['homework'] = Variable<String>(homework.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (progressNote.present) {
      map['progress_note'] = Variable<String>(progressNote.value);
    }
    if (feeAmount.present) {
      map['fee_amount'] = Variable<int>(feeAmount.value);
    }
    if (isAttendanceSource.present) {
      map['is_attendance_source'] = Variable<bool>(isAttendanceSource.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendanceStatus: $attendanceStatus, ')
          ..write('material: $material, ')
          ..write('homework: $homework, ')
          ..write('note: $note, ')
          ..write('progressNote: $progressNote, ')
          ..write('feeAmount: $feeAmount, ')
          ..write('isAttendanceSource: $isAttendanceSource, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $AssessmentsTable extends Assessments
    with TableInfo<$AssessmentsTable, Assessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _assessmentTypeMeta = const VerificationMeta(
    'assessmentType',
  );
  @override
  late final GeneratedColumn<String> assessmentType = GeneratedColumn<String>(
    'assessment_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(AssessmentType.session),
  );
  static const VerificationMeta _reviewCycleLabelMeta = const VerificationMeta(
    'reviewCycleLabel',
  );
  @override
  late final GeneratedColumn<String> reviewCycleLabel = GeneratedColumn<String>(
    'review_cycle_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pemahamanMateriMeta = const VerificationMeta(
    'pemahamanMateri',
  );
  @override
  late final GeneratedColumn<String> pemahamanMateri = GeneratedColumn<String>(
    'pemahaman_materi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keaktifanTanyaJawabMeta =
      const VerificationMeta('keaktifanTanyaJawab');
  @override
  late final GeneratedColumn<String> keaktifanTanyaJawab =
      GeneratedColumn<String>(
        'keaktifan_tanya_jawab',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ketepatanKerapianTugasMeta =
      const VerificationMeta('ketepatanKerapianTugas');
  @override
  late final GeneratedColumn<String> ketepatanKerapianTugas =
      GeneratedColumn<String>(
        'ketepatan_kerapian_tugas',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _konsistensiKehadiranFokusMeta =
      const VerificationMeta('konsistensiKehadiranFokus');
  @override
  late final GeneratedColumn<String> konsistensiKehadiranFokus =
      GeneratedColumn<String>(
        'konsistensi_kehadiran_fokus',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetMateriDrillingMeta =
      const VerificationMeta('targetMateriDrilling');
  @override
  late final GeneratedColumn<String> targetMateriDrilling =
      GeneratedColumn<String>(
        'target_materi_drilling',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sikapBelajarResponMeta =
      const VerificationMeta('sikapBelajarRespon');
  @override
  late final GeneratedColumn<String> sikapBelajarRespon =
      GeneratedColumn<String>(
        'sikap_belajar_respon',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _summaryNoteMeta = const VerificationMeta(
    'summaryNote',
  );
  @override
  late final GeneratedColumn<String> summaryNote = GeneratedColumn<String>(
    'summary_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    studentId,
    academicPeriodId,
    assessmentType,
    reviewCycleLabel,
    pemahamanMateri,
    keaktifanTanyaJawab,
    ketepatanKerapianTugas,
    konsistensiKehadiranFokus,
    targetMateriDrilling,
    sikapBelajarRespon,
    summaryNote,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Assessment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    }
    if (data.containsKey('assessment_type')) {
      context.handle(
        _assessmentTypeMeta,
        assessmentType.isAcceptableOrUnknown(
          data['assessment_type']!,
          _assessmentTypeMeta,
        ),
      );
    }
    if (data.containsKey('review_cycle_label')) {
      context.handle(
        _reviewCycleLabelMeta,
        reviewCycleLabel.isAcceptableOrUnknown(
          data['review_cycle_label']!,
          _reviewCycleLabelMeta,
        ),
      );
    }
    if (data.containsKey('pemahaman_materi')) {
      context.handle(
        _pemahamanMateriMeta,
        pemahamanMateri.isAcceptableOrUnknown(
          data['pemahaman_materi']!,
          _pemahamanMateriMeta,
        ),
      );
    }
    if (data.containsKey('keaktifan_tanya_jawab')) {
      context.handle(
        _keaktifanTanyaJawabMeta,
        keaktifanTanyaJawab.isAcceptableOrUnknown(
          data['keaktifan_tanya_jawab']!,
          _keaktifanTanyaJawabMeta,
        ),
      );
    }
    if (data.containsKey('ketepatan_kerapian_tugas')) {
      context.handle(
        _ketepatanKerapianTugasMeta,
        ketepatanKerapianTugas.isAcceptableOrUnknown(
          data['ketepatan_kerapian_tugas']!,
          _ketepatanKerapianTugasMeta,
        ),
      );
    }
    if (data.containsKey('konsistensi_kehadiran_fokus')) {
      context.handle(
        _konsistensiKehadiranFokusMeta,
        konsistensiKehadiranFokus.isAcceptableOrUnknown(
          data['konsistensi_kehadiran_fokus']!,
          _konsistensiKehadiranFokusMeta,
        ),
      );
    }
    if (data.containsKey('target_materi_drilling')) {
      context.handle(
        _targetMateriDrillingMeta,
        targetMateriDrilling.isAcceptableOrUnknown(
          data['target_materi_drilling']!,
          _targetMateriDrillingMeta,
        ),
      );
    }
    if (data.containsKey('sikap_belajar_respon')) {
      context.handle(
        _sikapBelajarResponMeta,
        sikapBelajarRespon.isAcceptableOrUnknown(
          data['sikap_belajar_respon']!,
          _sikapBelajarResponMeta,
        ),
      );
    }
    if (data.containsKey('summary_note')) {
      context.handle(
        _summaryNoteMeta,
        summaryNote.isAcceptableOrUnknown(
          data['summary_note']!,
          _summaryNoteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assessment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      ),
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      ),
      assessmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment_type'],
      )!,
      reviewCycleLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_cycle_label'],
      ),
      pemahamanMateri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pemahaman_materi'],
      ),
      keaktifanTanyaJawab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keaktifan_tanya_jawab'],
      ),
      ketepatanKerapianTugas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ketepatan_kerapian_tugas'],
      ),
      konsistensiKehadiranFokus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}konsistensi_kehadiran_fokus'],
      ),
      targetMateriDrilling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_materi_drilling'],
      ),
      sikapBelajarRespon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sikap_belajar_respon'],
      ),
      summaryNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $AssessmentsTable createAlias(String alias) {
    return $AssessmentsTable(attachedDatabase, alias);
  }
}

class Assessment extends DataClass implements Insertable<Assessment> {
  final int id;
  final int? sessionId;
  final int studentId;
  final int? academicPeriodId;
  final String assessmentType;
  final String? reviewCycleLabel;
  final String? pemahamanMateri;
  final String? keaktifanTanyaJawab;
  final String? ketepatanKerapianTugas;
  final String? konsistensiKehadiranFokus;
  final String? targetMateriDrilling;
  final String? sikapBelajarRespon;
  final String? summaryNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Assessment({
    required this.id,
    this.sessionId,
    required this.studentId,
    this.academicPeriodId,
    required this.assessmentType,
    this.reviewCycleLabel,
    this.pemahamanMateri,
    this.keaktifanTanyaJawab,
    this.ketepatanKerapianTugas,
    this.konsistensiKehadiranFokus,
    this.targetMateriDrilling,
    this.sikapBelajarRespon,
    this.summaryNote,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<int>(sessionId);
    }
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || academicPeriodId != null) {
      map['academic_period_id'] = Variable<int>(academicPeriodId);
    }
    map['assessment_type'] = Variable<String>(assessmentType);
    if (!nullToAbsent || reviewCycleLabel != null) {
      map['review_cycle_label'] = Variable<String>(reviewCycleLabel);
    }
    if (!nullToAbsent || pemahamanMateri != null) {
      map['pemahaman_materi'] = Variable<String>(pemahamanMateri);
    }
    if (!nullToAbsent || keaktifanTanyaJawab != null) {
      map['keaktifan_tanya_jawab'] = Variable<String>(keaktifanTanyaJawab);
    }
    if (!nullToAbsent || ketepatanKerapianTugas != null) {
      map['ketepatan_kerapian_tugas'] = Variable<String>(
        ketepatanKerapianTugas,
      );
    }
    if (!nullToAbsent || konsistensiKehadiranFokus != null) {
      map['konsistensi_kehadiran_fokus'] = Variable<String>(
        konsistensiKehadiranFokus,
      );
    }
    if (!nullToAbsent || targetMateriDrilling != null) {
      map['target_materi_drilling'] = Variable<String>(targetMateriDrilling);
    }
    if (!nullToAbsent || sikapBelajarRespon != null) {
      map['sikap_belajar_respon'] = Variable<String>(sikapBelajarRespon);
    }
    if (!nullToAbsent || summaryNote != null) {
      map['summary_note'] = Variable<String>(summaryNote);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  AssessmentsCompanion toCompanion(bool nullToAbsent) {
    return AssessmentsCompanion(
      id: Value(id),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      studentId: Value(studentId),
      academicPeriodId: academicPeriodId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicPeriodId),
      assessmentType: Value(assessmentType),
      reviewCycleLabel: reviewCycleLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewCycleLabel),
      pemahamanMateri: pemahamanMateri == null && nullToAbsent
          ? const Value.absent()
          : Value(pemahamanMateri),
      keaktifanTanyaJawab: keaktifanTanyaJawab == null && nullToAbsent
          ? const Value.absent()
          : Value(keaktifanTanyaJawab),
      ketepatanKerapianTugas: ketepatanKerapianTugas == null && nullToAbsent
          ? const Value.absent()
          : Value(ketepatanKerapianTugas),
      konsistensiKehadiranFokus:
          konsistensiKehadiranFokus == null && nullToAbsent
          ? const Value.absent()
          : Value(konsistensiKehadiranFokus),
      targetMateriDrilling: targetMateriDrilling == null && nullToAbsent
          ? const Value.absent()
          : Value(targetMateriDrilling),
      sikapBelajarRespon: sikapBelajarRespon == null && nullToAbsent
          ? const Value.absent()
          : Value(sikapBelajarRespon),
      summaryNote: summaryNote == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Assessment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assessment(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int?>(json['sessionId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      academicPeriodId: serializer.fromJson<int?>(json['academicPeriodId']),
      assessmentType: serializer.fromJson<String>(json['assessmentType']),
      reviewCycleLabel: serializer.fromJson<String?>(json['reviewCycleLabel']),
      pemahamanMateri: serializer.fromJson<String?>(json['pemahamanMateri']),
      keaktifanTanyaJawab: serializer.fromJson<String?>(
        json['keaktifanTanyaJawab'],
      ),
      ketepatanKerapianTugas: serializer.fromJson<String?>(
        json['ketepatanKerapianTugas'],
      ),
      konsistensiKehadiranFokus: serializer.fromJson<String?>(
        json['konsistensiKehadiranFokus'],
      ),
      targetMateriDrilling: serializer.fromJson<String?>(
        json['targetMateriDrilling'],
      ),
      sikapBelajarRespon: serializer.fromJson<String?>(
        json['sikapBelajarRespon'],
      ),
      summaryNote: serializer.fromJson<String?>(json['summaryNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int?>(sessionId),
      'studentId': serializer.toJson<int>(studentId),
      'academicPeriodId': serializer.toJson<int?>(academicPeriodId),
      'assessmentType': serializer.toJson<String>(assessmentType),
      'reviewCycleLabel': serializer.toJson<String?>(reviewCycleLabel),
      'pemahamanMateri': serializer.toJson<String?>(pemahamanMateri),
      'keaktifanTanyaJawab': serializer.toJson<String?>(keaktifanTanyaJawab),
      'ketepatanKerapianTugas': serializer.toJson<String?>(
        ketepatanKerapianTugas,
      ),
      'konsistensiKehadiranFokus': serializer.toJson<String?>(
        konsistensiKehadiranFokus,
      ),
      'targetMateriDrilling': serializer.toJson<String?>(targetMateriDrilling),
      'sikapBelajarRespon': serializer.toJson<String?>(sikapBelajarRespon),
      'summaryNote': serializer.toJson<String?>(summaryNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Assessment copyWith({
    int? id,
    Value<int?> sessionId = const Value.absent(),
    int? studentId,
    Value<int?> academicPeriodId = const Value.absent(),
    String? assessmentType,
    Value<String?> reviewCycleLabel = const Value.absent(),
    Value<String?> pemahamanMateri = const Value.absent(),
    Value<String?> keaktifanTanyaJawab = const Value.absent(),
    Value<String?> ketepatanKerapianTugas = const Value.absent(),
    Value<String?> konsistensiKehadiranFokus = const Value.absent(),
    Value<String?> targetMateriDrilling = const Value.absent(),
    Value<String?> sikapBelajarRespon = const Value.absent(),
    Value<String?> summaryNote = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Assessment(
    id: id ?? this.id,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    studentId: studentId ?? this.studentId,
    academicPeriodId: academicPeriodId.present
        ? academicPeriodId.value
        : this.academicPeriodId,
    assessmentType: assessmentType ?? this.assessmentType,
    reviewCycleLabel: reviewCycleLabel.present
        ? reviewCycleLabel.value
        : this.reviewCycleLabel,
    pemahamanMateri: pemahamanMateri.present
        ? pemahamanMateri.value
        : this.pemahamanMateri,
    keaktifanTanyaJawab: keaktifanTanyaJawab.present
        ? keaktifanTanyaJawab.value
        : this.keaktifanTanyaJawab,
    ketepatanKerapianTugas: ketepatanKerapianTugas.present
        ? ketepatanKerapianTugas.value
        : this.ketepatanKerapianTugas,
    konsistensiKehadiranFokus: konsistensiKehadiranFokus.present
        ? konsistensiKehadiranFokus.value
        : this.konsistensiKehadiranFokus,
    targetMateriDrilling: targetMateriDrilling.present
        ? targetMateriDrilling.value
        : this.targetMateriDrilling,
    sikapBelajarRespon: sikapBelajarRespon.present
        ? sikapBelajarRespon.value
        : this.sikapBelajarRespon,
    summaryNote: summaryNote.present ? summaryNote.value : this.summaryNote,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Assessment copyWithCompanion(AssessmentsCompanion data) {
    return Assessment(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      assessmentType: data.assessmentType.present
          ? data.assessmentType.value
          : this.assessmentType,
      reviewCycleLabel: data.reviewCycleLabel.present
          ? data.reviewCycleLabel.value
          : this.reviewCycleLabel,
      pemahamanMateri: data.pemahamanMateri.present
          ? data.pemahamanMateri.value
          : this.pemahamanMateri,
      keaktifanTanyaJawab: data.keaktifanTanyaJawab.present
          ? data.keaktifanTanyaJawab.value
          : this.keaktifanTanyaJawab,
      ketepatanKerapianTugas: data.ketepatanKerapianTugas.present
          ? data.ketepatanKerapianTugas.value
          : this.ketepatanKerapianTugas,
      konsistensiKehadiranFokus: data.konsistensiKehadiranFokus.present
          ? data.konsistensiKehadiranFokus.value
          : this.konsistensiKehadiranFokus,
      targetMateriDrilling: data.targetMateriDrilling.present
          ? data.targetMateriDrilling.value
          : this.targetMateriDrilling,
      sikapBelajarRespon: data.sikapBelajarRespon.present
          ? data.sikapBelajarRespon.value
          : this.sikapBelajarRespon,
      summaryNote: data.summaryNote.present
          ? data.summaryNote.value
          : this.summaryNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assessment(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('reviewCycleLabel: $reviewCycleLabel, ')
          ..write('pemahamanMateri: $pemahamanMateri, ')
          ..write('keaktifanTanyaJawab: $keaktifanTanyaJawab, ')
          ..write('ketepatanKerapianTugas: $ketepatanKerapianTugas, ')
          ..write('konsistensiKehadiranFokus: $konsistensiKehadiranFokus, ')
          ..write('targetMateriDrilling: $targetMateriDrilling, ')
          ..write('sikapBelajarRespon: $sikapBelajarRespon, ')
          ..write('summaryNote: $summaryNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    studentId,
    academicPeriodId,
    assessmentType,
    reviewCycleLabel,
    pemahamanMateri,
    keaktifanTanyaJawab,
    ketepatanKerapianTugas,
    konsistensiKehadiranFokus,
    targetMateriDrilling,
    sikapBelajarRespon,
    summaryNote,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assessment &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.studentId == this.studentId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.assessmentType == this.assessmentType &&
          other.reviewCycleLabel == this.reviewCycleLabel &&
          other.pemahamanMateri == this.pemahamanMateri &&
          other.keaktifanTanyaJawab == this.keaktifanTanyaJawab &&
          other.ketepatanKerapianTugas == this.ketepatanKerapianTugas &&
          other.konsistensiKehadiranFokus == this.konsistensiKehadiranFokus &&
          other.targetMateriDrilling == this.targetMateriDrilling &&
          other.sikapBelajarRespon == this.sikapBelajarRespon &&
          other.summaryNote == this.summaryNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AssessmentsCompanion extends UpdateCompanion<Assessment> {
  final Value<int> id;
  final Value<int?> sessionId;
  final Value<int> studentId;
  final Value<int?> academicPeriodId;
  final Value<String> assessmentType;
  final Value<String?> reviewCycleLabel;
  final Value<String?> pemahamanMateri;
  final Value<String?> keaktifanTanyaJawab;
  final Value<String?> ketepatanKerapianTugas;
  final Value<String?> konsistensiKehadiranFokus;
  final Value<String?> targetMateriDrilling;
  final Value<String?> sikapBelajarRespon;
  final Value<String?> summaryNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const AssessmentsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.assessmentType = const Value.absent(),
    this.reviewCycleLabel = const Value.absent(),
    this.pemahamanMateri = const Value.absent(),
    this.keaktifanTanyaJawab = const Value.absent(),
    this.ketepatanKerapianTugas = const Value.absent(),
    this.konsistensiKehadiranFokus = const Value.absent(),
    this.targetMateriDrilling = const Value.absent(),
    this.sikapBelajarRespon = const Value.absent(),
    this.summaryNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  AssessmentsCompanion.insert({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    required int studentId,
    this.academicPeriodId = const Value.absent(),
    this.assessmentType = const Value.absent(),
    this.reviewCycleLabel = const Value.absent(),
    this.pemahamanMateri = const Value.absent(),
    this.keaktifanTanyaJawab = const Value.absent(),
    this.ketepatanKerapianTugas = const Value.absent(),
    this.konsistensiKehadiranFokus = const Value.absent(),
    this.targetMateriDrilling = const Value.absent(),
    this.sikapBelajarRespon = const Value.absent(),
    this.summaryNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId);
  static Insertable<Assessment> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? studentId,
    Expression<int>? academicPeriodId,
    Expression<String>? assessmentType,
    Expression<String>? reviewCycleLabel,
    Expression<String>? pemahamanMateri,
    Expression<String>? keaktifanTanyaJawab,
    Expression<String>? ketepatanKerapianTugas,
    Expression<String>? konsistensiKehadiranFokus,
    Expression<String>? targetMateriDrilling,
    Expression<String>? sikapBelajarRespon,
    Expression<String>? summaryNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (studentId != null) 'student_id': studentId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (assessmentType != null) 'assessment_type': assessmentType,
      if (reviewCycleLabel != null) 'review_cycle_label': reviewCycleLabel,
      if (pemahamanMateri != null) 'pemahaman_materi': pemahamanMateri,
      if (keaktifanTanyaJawab != null)
        'keaktifan_tanya_jawab': keaktifanTanyaJawab,
      if (ketepatanKerapianTugas != null)
        'ketepatan_kerapian_tugas': ketepatanKerapianTugas,
      if (konsistensiKehadiranFokus != null)
        'konsistensi_kehadiran_fokus': konsistensiKehadiranFokus,
      if (targetMateriDrilling != null)
        'target_materi_drilling': targetMateriDrilling,
      if (sikapBelajarRespon != null)
        'sikap_belajar_respon': sikapBelajarRespon,
      if (summaryNote != null) 'summary_note': summaryNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  AssessmentsCompanion copyWith({
    Value<int>? id,
    Value<int?>? sessionId,
    Value<int>? studentId,
    Value<int?>? academicPeriodId,
    Value<String>? assessmentType,
    Value<String?>? reviewCycleLabel,
    Value<String?>? pemahamanMateri,
    Value<String?>? keaktifanTanyaJawab,
    Value<String?>? ketepatanKerapianTugas,
    Value<String?>? konsistensiKehadiranFokus,
    Value<String?>? targetMateriDrilling,
    Value<String?>? sikapBelajarRespon,
    Value<String?>? summaryNote,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return AssessmentsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      assessmentType: assessmentType ?? this.assessmentType,
      reviewCycleLabel: reviewCycleLabel ?? this.reviewCycleLabel,
      pemahamanMateri: pemahamanMateri ?? this.pemahamanMateri,
      keaktifanTanyaJawab: keaktifanTanyaJawab ?? this.keaktifanTanyaJawab,
      ketepatanKerapianTugas:
          ketepatanKerapianTugas ?? this.ketepatanKerapianTugas,
      konsistensiKehadiranFokus:
          konsistensiKehadiranFokus ?? this.konsistensiKehadiranFokus,
      targetMateriDrilling: targetMateriDrilling ?? this.targetMateriDrilling,
      sikapBelajarRespon: sikapBelajarRespon ?? this.sikapBelajarRespon,
      summaryNote: summaryNote ?? this.summaryNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (assessmentType.present) {
      map['assessment_type'] = Variable<String>(assessmentType.value);
    }
    if (reviewCycleLabel.present) {
      map['review_cycle_label'] = Variable<String>(reviewCycleLabel.value);
    }
    if (pemahamanMateri.present) {
      map['pemahaman_materi'] = Variable<String>(pemahamanMateri.value);
    }
    if (keaktifanTanyaJawab.present) {
      map['keaktifan_tanya_jawab'] = Variable<String>(
        keaktifanTanyaJawab.value,
      );
    }
    if (ketepatanKerapianTugas.present) {
      map['ketepatan_kerapian_tugas'] = Variable<String>(
        ketepatanKerapianTugas.value,
      );
    }
    if (konsistensiKehadiranFokus.present) {
      map['konsistensi_kehadiran_fokus'] = Variable<String>(
        konsistensiKehadiranFokus.value,
      );
    }
    if (targetMateriDrilling.present) {
      map['target_materi_drilling'] = Variable<String>(
        targetMateriDrilling.value,
      );
    }
    if (sikapBelajarRespon.present) {
      map['sikap_belajar_respon'] = Variable<String>(sikapBelajarRespon.value);
    }
    if (summaryNote.present) {
      map['summary_note'] = Variable<String>(summaryNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('reviewCycleLabel: $reviewCycleLabel, ')
          ..write('pemahamanMateri: $pemahamanMateri, ')
          ..write('keaktifanTanyaJawab: $keaktifanTanyaJawab, ')
          ..write('ketepatanKerapianTugas: $ketepatanKerapianTugas, ')
          ..write('konsistensiKehadiranFokus: $konsistensiKehadiranFokus, ')
          ..write('targetMateriDrilling: $targetMateriDrilling, ')
          ..write('sikapBelajarRespon: $sikapBelajarRespon, ')
          ..write('summaryNote: $summaryNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _periodLabelMeta = const VerificationMeta(
    'periodLabel',
  );
  @override
  late final GeneratedColumn<String> periodLabel = GeneratedColumn<String>(
    'period_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<int> paidAmount = GeneratedColumn<int>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(InvoiceStatus.unpaid),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRemindedAtMeta = const VerificationMeta(
    'lastRemindedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRemindedAt =
      GeneratedColumn<DateTime>(
        'last_reminded_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    sessionId,
    academicPeriodId,
    periodLabel,
    amount,
    paidAmount,
    status,
    dueDate,
    lastRemindedAt,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    }
    if (data.containsKey('period_label')) {
      context.handle(
        _periodLabelMeta,
        periodLabel.isAcceptableOrUnknown(
          data['period_label']!,
          _periodLabelMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('last_reminded_at')) {
      context.handle(
        _lastRemindedAtMeta,
        lastRemindedAt.isAcceptableOrUnknown(
          data['last_reminded_at']!,
          _lastRemindedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      ),
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      ),
      periodLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_label'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      lastRemindedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reminded_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int studentId;
  final int? sessionId;
  final int? academicPeriodId;
  final String periodLabel;
  final int amount;
  final int paidAmount;
  final String status;
  final DateTime? dueDate;
  final DateTime? lastRemindedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Invoice({
    required this.id,
    required this.studentId,
    this.sessionId,
    this.academicPeriodId,
    required this.periodLabel,
    required this.amount,
    required this.paidAmount,
    required this.status,
    this.dueDate,
    this.lastRemindedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<int>(sessionId);
    }
    if (!nullToAbsent || academicPeriodId != null) {
      map['academic_period_id'] = Variable<int>(academicPeriodId);
    }
    map['period_label'] = Variable<String>(periodLabel);
    map['amount'] = Variable<int>(amount);
    map['paid_amount'] = Variable<int>(paidAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || lastRemindedAt != null) {
      map['last_reminded_at'] = Variable<DateTime>(lastRemindedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      academicPeriodId: academicPeriodId == null && nullToAbsent
          ? const Value.absent()
          : Value(academicPeriodId),
      periodLabel: Value(periodLabel),
      amount: Value(amount),
      paidAmount: Value(paidAmount),
      status: Value(status),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      lastRemindedAt: lastRemindedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRemindedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      sessionId: serializer.fromJson<int?>(json['sessionId']),
      academicPeriodId: serializer.fromJson<int?>(json['academicPeriodId']),
      periodLabel: serializer.fromJson<String>(json['periodLabel']),
      amount: serializer.fromJson<int>(json['amount']),
      paidAmount: serializer.fromJson<int>(json['paidAmount']),
      status: serializer.fromJson<String>(json['status']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      lastRemindedAt: serializer.fromJson<DateTime?>(json['lastRemindedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'sessionId': serializer.toJson<int?>(sessionId),
      'academicPeriodId': serializer.toJson<int?>(academicPeriodId),
      'periodLabel': serializer.toJson<String>(periodLabel),
      'amount': serializer.toJson<int>(amount),
      'paidAmount': serializer.toJson<int>(paidAmount),
      'status': serializer.toJson<String>(status),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'lastRemindedAt': serializer.toJson<DateTime?>(lastRemindedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Invoice copyWith({
    int? id,
    int? studentId,
    Value<int?> sessionId = const Value.absent(),
    Value<int?> academicPeriodId = const Value.absent(),
    String? periodLabel,
    int? amount,
    int? paidAmount,
    String? status,
    Value<DateTime?> dueDate = const Value.absent(),
    Value<DateTime?> lastRemindedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    academicPeriodId: academicPeriodId.present
        ? academicPeriodId.value
        : this.academicPeriodId,
    periodLabel: periodLabel ?? this.periodLabel,
    amount: amount ?? this.amount,
    paidAmount: paidAmount ?? this.paidAmount,
    status: status ?? this.status,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    lastRemindedAt: lastRemindedAt.present
        ? lastRemindedAt.value
        : this.lastRemindedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      periodLabel: data.periodLabel.present
          ? data.periodLabel.value
          : this.periodLabel,
      amount: data.amount.present ? data.amount.value : this.amount,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      lastRemindedAt: data.lastRemindedAt.present
          ? data.lastRemindedAt.value
          : this.lastRemindedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('sessionId: $sessionId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('amount: $amount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('lastRemindedAt: $lastRemindedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    sessionId,
    academicPeriodId,
    periodLabel,
    amount,
    paidAmount,
    status,
    dueDate,
    lastRemindedAt,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.sessionId == this.sessionId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.periodLabel == this.periodLabel &&
          other.amount == this.amount &&
          other.paidAmount == this.paidAmount &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.lastRemindedAt == this.lastRemindedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int?> sessionId;
  final Value<int?> academicPeriodId;
  final Value<String> periodLabel;
  final Value<int> amount;
  final Value<int> paidAmount;
  final Value<String> status;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> lastRemindedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.periodLabel = const Value.absent(),
    this.amount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.lastRemindedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    this.sessionId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.periodLabel = const Value.absent(),
    this.amount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.lastRemindedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? sessionId,
    Expression<int>? academicPeriodId,
    Expression<String>? periodLabel,
    Expression<int>? amount,
    Expression<int>? paidAmount,
    Expression<String>? status,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? lastRemindedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (sessionId != null) 'session_id': sessionId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (periodLabel != null) 'period_label': periodLabel,
      if (amount != null) 'amount': amount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (lastRemindedAt != null) 'last_reminded_at': lastRemindedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int?>? sessionId,
    Value<int?>? academicPeriodId,
    Value<String>? periodLabel,
    Value<int>? amount,
    Value<int>? paidAmount,
    Value<String>? status,
    Value<DateTime?>? dueDate,
    Value<DateTime?>? lastRemindedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      sessionId: sessionId ?? this.sessionId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      periodLabel: periodLabel ?? this.periodLabel,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      lastRemindedAt: lastRemindedAt ?? this.lastRemindedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (periodLabel.present) {
      map['period_label'] = Variable<String>(periodLabel.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<int>(paidAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (lastRemindedAt.present) {
      map['last_reminded_at'] = Variable<DateTime>(lastRemindedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('sessionId: $sessionId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('amount: $amount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('lastRemindedAt: $lastRemindedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(PaymentMethod.cash),
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    amount,
    method,
    paidAt,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int invoiceId;
  final int amount;
  final String method;
  final DateTime paidAt;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Payment({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.method,
    required this.paidAt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['amount'] = Variable<int>(amount);
    map['method'] = Variable<String>(method);
    map['paid_at'] = Variable<DateTime>(paidAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      amount: Value(amount),
      method: Value(method),
      paidAt: Value(paidAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      amount: serializer.fromJson<int>(json['amount']),
      method: serializer.fromJson<String>(json['method']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'amount': serializer.toJson<int>(amount),
      'method': serializer.toJson<String>(method),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Payment copyWith({
    int? id,
    int? invoiceId,
    int? amount,
    String? method,
    DateTime? paidAt,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Payment(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    amount: amount ?? this.amount,
    method: method ?? this.method,
    paidAt: paidAt ?? this.paidAt,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      method: data.method.present ? data.method.value : this.method,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    amount,
    method,
    paidAt,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.amount == this.amount &&
          other.method == this.method &&
          other.paidAt == this.paidAt &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> amount;
  final Value<String> method;
  final Value<DateTime> paidAt;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    required DateTime paidAt,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       paidAt = Value(paidAt);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? amount,
    Expression<String>? method,
    Expression<DateTime>? paidAt,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amount != null) 'amount': amount,
      if (method != null) 'method': method,
      if (paidAt != null) 'paid_at': paidAt,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? amount,
    Value<String>? method,
    Value<DateTime>? paidAt,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      paidAt: paidAt ?? this.paidAt,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $ProgressReportsTable extends ProgressReports
    with TableInfo<$ProgressReportsTable, ProgressReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES students (id)',
    ),
  );
  static const VerificationMeta _academicPeriodIdMeta = const VerificationMeta(
    'academicPeriodId',
  );
  @override
  late final GeneratedColumn<int> academicPeriodId = GeneratedColumn<int>(
    'academic_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES academic_periods (id)',
    ),
  );
  static const VerificationMeta _reportTypeMeta = const VerificationMeta(
    'reportType',
  );
  @override
  late final GeneratedColumn<String> reportType = GeneratedColumn<String>(
    'report_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ProgressReportType.periodic),
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _attendanceSummaryJsonMeta =
      const VerificationMeta('attendanceSummaryJson');
  @override
  late final GeneratedColumn<String> attendanceSummaryJson =
      GeneratedColumn<String>(
        'attendance_summary_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _assessmentSummaryJsonMeta =
      const VerificationMeta('assessmentSummaryJson');
  @override
  late final GeneratedColumn<String> assessmentSummaryJson =
      GeneratedColumn<String>(
        'assessment_summary_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _teacherNoteMeta = const VerificationMeta(
    'teacherNote',
  );
  @override
  late final GeneratedColumn<String> teacherNote = GeneratedColumn<String>(
    'teacher_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ProgressReportStatus.draft),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    academicPeriodId,
    reportType,
    generatedAt,
    attendanceSummaryJson,
    assessmentSummaryJson,
    teacherNote,
    status,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('academic_period_id')) {
      context.handle(
        _academicPeriodIdMeta,
        academicPeriodId.isAcceptableOrUnknown(
          data['academic_period_id']!,
          _academicPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicPeriodIdMeta);
    }
    if (data.containsKey('report_type')) {
      context.handle(
        _reportTypeMeta,
        reportType.isAcceptableOrUnknown(data['report_type']!, _reportTypeMeta),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('attendance_summary_json')) {
      context.handle(
        _attendanceSummaryJsonMeta,
        attendanceSummaryJson.isAcceptableOrUnknown(
          data['attendance_summary_json']!,
          _attendanceSummaryJsonMeta,
        ),
      );
    }
    if (data.containsKey('assessment_summary_json')) {
      context.handle(
        _assessmentSummaryJsonMeta,
        assessmentSummaryJson.isAcceptableOrUnknown(
          data['assessment_summary_json']!,
          _assessmentSummaryJsonMeta,
        ),
      );
    }
    if (data.containsKey('teacher_note')) {
      context.handle(
        _teacherNoteMeta,
        teacherNote.isAcceptableOrUnknown(
          data['teacher_note']!,
          _teacherNoteMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      academicPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_period_id'],
      )!,
      reportType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_type'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      attendanceSummaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance_summary_json'],
      )!,
      assessmentSummaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment_summary_json'],
      )!,
      teacherNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_note'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProgressReportsTable createAlias(String alias) {
    return $ProgressReportsTable(attachedDatabase, alias);
  }
}

class ProgressReport extends DataClass implements Insertable<ProgressReport> {
  final int id;
  final int studentId;
  final int academicPeriodId;
  final String reportType;
  final DateTime generatedAt;
  final String attendanceSummaryJson;
  final String assessmentSummaryJson;
  final String? teacherNote;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const ProgressReport({
    required this.id,
    required this.studentId,
    required this.academicPeriodId,
    required this.reportType,
    required this.generatedAt,
    required this.attendanceSummaryJson,
    required this.assessmentSummaryJson,
    this.teacherNote,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['academic_period_id'] = Variable<int>(academicPeriodId);
    map['report_type'] = Variable<String>(reportType);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['attendance_summary_json'] = Variable<String>(attendanceSummaryJson);
    map['assessment_summary_json'] = Variable<String>(assessmentSummaryJson);
    if (!nullToAbsent || teacherNote != null) {
      map['teacher_note'] = Variable<String>(teacherNote);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProgressReportsCompanion toCompanion(bool nullToAbsent) {
    return ProgressReportsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      academicPeriodId: Value(academicPeriodId),
      reportType: Value(reportType),
      generatedAt: Value(generatedAt),
      attendanceSummaryJson: Value(attendanceSummaryJson),
      assessmentSummaryJson: Value(assessmentSummaryJson),
      teacherNote: teacherNote == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherNote),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ProgressReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressReport(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      academicPeriodId: serializer.fromJson<int>(json['academicPeriodId']),
      reportType: serializer.fromJson<String>(json['reportType']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      attendanceSummaryJson: serializer.fromJson<String>(
        json['attendanceSummaryJson'],
      ),
      assessmentSummaryJson: serializer.fromJson<String>(
        json['assessmentSummaryJson'],
      ),
      teacherNote: serializer.fromJson<String?>(json['teacherNote']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'academicPeriodId': serializer.toJson<int>(academicPeriodId),
      'reportType': serializer.toJson<String>(reportType),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'attendanceSummaryJson': serializer.toJson<String>(attendanceSummaryJson),
      'assessmentSummaryJson': serializer.toJson<String>(assessmentSummaryJson),
      'teacherNote': serializer.toJson<String?>(teacherNote),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ProgressReport copyWith({
    int? id,
    int? studentId,
    int? academicPeriodId,
    String? reportType,
    DateTime? generatedAt,
    String? attendanceSummaryJson,
    String? assessmentSummaryJson,
    Value<String?> teacherNote = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => ProgressReport(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    academicPeriodId: academicPeriodId ?? this.academicPeriodId,
    reportType: reportType ?? this.reportType,
    generatedAt: generatedAt ?? this.generatedAt,
    attendanceSummaryJson: attendanceSummaryJson ?? this.attendanceSummaryJson,
    assessmentSummaryJson: assessmentSummaryJson ?? this.assessmentSummaryJson,
    teacherNote: teacherNote.present ? teacherNote.value : this.teacherNote,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ProgressReport copyWithCompanion(ProgressReportsCompanion data) {
    return ProgressReport(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      academicPeriodId: data.academicPeriodId.present
          ? data.academicPeriodId.value
          : this.academicPeriodId,
      reportType: data.reportType.present
          ? data.reportType.value
          : this.reportType,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      attendanceSummaryJson: data.attendanceSummaryJson.present
          ? data.attendanceSummaryJson.value
          : this.attendanceSummaryJson,
      assessmentSummaryJson: data.assessmentSummaryJson.present
          ? data.assessmentSummaryJson.value
          : this.assessmentSummaryJson,
      teacherNote: data.teacherNote.present
          ? data.teacherNote.value
          : this.teacherNote,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressReport(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('reportType: $reportType, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('attendanceSummaryJson: $attendanceSummaryJson, ')
          ..write('assessmentSummaryJson: $assessmentSummaryJson, ')
          ..write('teacherNote: $teacherNote, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    academicPeriodId,
    reportType,
    generatedAt,
    attendanceSummaryJson,
    assessmentSummaryJson,
    teacherNote,
    status,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressReport &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.academicPeriodId == this.academicPeriodId &&
          other.reportType == this.reportType &&
          other.generatedAt == this.generatedAt &&
          other.attendanceSummaryJson == this.attendanceSummaryJson &&
          other.assessmentSummaryJson == this.assessmentSummaryJson &&
          other.teacherNote == this.teacherNote &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ProgressReportsCompanion extends UpdateCompanion<ProgressReport> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> academicPeriodId;
  final Value<String> reportType;
  final Value<DateTime> generatedAt;
  final Value<String> attendanceSummaryJson;
  final Value<String> assessmentSummaryJson;
  final Value<String?> teacherNote;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const ProgressReportsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.academicPeriodId = const Value.absent(),
    this.reportType = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.attendanceSummaryJson = const Value.absent(),
    this.assessmentSummaryJson = const Value.absent(),
    this.teacherNote = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  ProgressReportsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int academicPeriodId,
    this.reportType = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.attendanceSummaryJson = const Value.absent(),
    this.assessmentSummaryJson = const Value.absent(),
    this.teacherNote = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       academicPeriodId = Value(academicPeriodId);
  static Insertable<ProgressReport> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? academicPeriodId,
    Expression<String>? reportType,
    Expression<DateTime>? generatedAt,
    Expression<String>? attendanceSummaryJson,
    Expression<String>? assessmentSummaryJson,
    Expression<String>? teacherNote,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (academicPeriodId != null) 'academic_period_id': academicPeriodId,
      if (reportType != null) 'report_type': reportType,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (attendanceSummaryJson != null)
        'attendance_summary_json': attendanceSummaryJson,
      if (assessmentSummaryJson != null)
        'assessment_summary_json': assessmentSummaryJson,
      if (teacherNote != null) 'teacher_note': teacherNote,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  ProgressReportsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? academicPeriodId,
    Value<String>? reportType,
    Value<DateTime>? generatedAt,
    Value<String>? attendanceSummaryJson,
    Value<String>? assessmentSummaryJson,
    Value<String?>? teacherNote,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return ProgressReportsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      academicPeriodId: academicPeriodId ?? this.academicPeriodId,
      reportType: reportType ?? this.reportType,
      generatedAt: generatedAt ?? this.generatedAt,
      attendanceSummaryJson:
          attendanceSummaryJson ?? this.attendanceSummaryJson,
      assessmentSummaryJson:
          assessmentSummaryJson ?? this.assessmentSummaryJson,
      teacherNote: teacherNote ?? this.teacherNote,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (academicPeriodId.present) {
      map['academic_period_id'] = Variable<int>(academicPeriodId.value);
    }
    if (reportType.present) {
      map['report_type'] = Variable<String>(reportType.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (attendanceSummaryJson.present) {
      map['attendance_summary_json'] = Variable<String>(
        attendanceSummaryJson.value,
      );
    }
    if (assessmentSummaryJson.present) {
      map['assessment_summary_json'] = Variable<String>(
        assessmentSummaryJson.value,
      );
    }
    if (teacherNote.present) {
      map['teacher_note'] = Variable<String>(teacherNote.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressReportsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('academicPeriodId: $academicPeriodId, ')
          ..write('reportType: $reportType, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('attendanceSummaryJson: $attendanceSummaryJson, ')
          ..write('assessmentSummaryJson: $assessmentSummaryJson, ')
          ..write('teacherNote: $teacherNote, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $ReminderRulesTable extends ReminderRules
    with TableInfo<$ReminderRulesTable, ReminderRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reminderTypeMeta = const VerificationMeta(
    'reminderType',
  );
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
    'reminder_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ReminderType.scheduleSession),
  );
  static const VerificationMeta _offsetMinutesMeta = const VerificationMeta(
    'offsetMinutes',
  );
  @override
  late final GeneratedColumn<int> offsetMinutes = GeneratedColumn<int>(
    'offset_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _daysBeforeDueMeta = const VerificationMeta(
    'daysBeforeDue',
  );
  @override
  late final GeneratedColumn<int> daysBeforeDue = GeneratedColumn<int>(
    'days_before_due',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ReminderChannel.localNotification),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reminderType,
    offsetMinutes,
    daysBeforeDue,
    isEnabled,
    channel,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
        _reminderTypeMeta,
        reminderType.isAcceptableOrUnknown(
          data['reminder_type']!,
          _reminderTypeMeta,
        ),
      );
    }
    if (data.containsKey('offset_minutes')) {
      context.handle(
        _offsetMinutesMeta,
        offsetMinutes.isAcceptableOrUnknown(
          data['offset_minutes']!,
          _offsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('days_before_due')) {
      context.handle(
        _daysBeforeDueMeta,
        daysBeforeDue.isAcceptableOrUnknown(
          data['days_before_due']!,
          _daysBeforeDueMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reminderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_type'],
      )!,
      offsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offset_minutes'],
      ),
      daysBeforeDue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_before_due'],
      ),
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReminderRulesTable createAlias(String alias) {
    return $ReminderRulesTable(attachedDatabase, alias);
  }
}

class ReminderRule extends DataClass implements Insertable<ReminderRule> {
  final int id;
  final String reminderType;
  final int? offsetMinutes;
  final int? daysBeforeDue;
  final bool isEnabled;
  final String channel;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderRule({
    required this.id,
    required this.reminderType,
    this.offsetMinutes,
    this.daysBeforeDue,
    required this.isEnabled,
    required this.channel,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reminder_type'] = Variable<String>(reminderType);
    if (!nullToAbsent || offsetMinutes != null) {
      map['offset_minutes'] = Variable<int>(offsetMinutes);
    }
    if (!nullToAbsent || daysBeforeDue != null) {
      map['days_before_due'] = Variable<int>(daysBeforeDue);
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['channel'] = Variable<String>(channel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReminderRulesCompanion toCompanion(bool nullToAbsent) {
    return ReminderRulesCompanion(
      id: Value(id),
      reminderType: Value(reminderType),
      offsetMinutes: offsetMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(offsetMinutes),
      daysBeforeDue: daysBeforeDue == null && nullToAbsent
          ? const Value.absent()
          : Value(daysBeforeDue),
      isEnabled: Value(isEnabled),
      channel: Value(channel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRule(
      id: serializer.fromJson<int>(json['id']),
      reminderType: serializer.fromJson<String>(json['reminderType']),
      offsetMinutes: serializer.fromJson<int?>(json['offsetMinutes']),
      daysBeforeDue: serializer.fromJson<int?>(json['daysBeforeDue']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      channel: serializer.fromJson<String>(json['channel']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reminderType': serializer.toJson<String>(reminderType),
      'offsetMinutes': serializer.toJson<int?>(offsetMinutes),
      'daysBeforeDue': serializer.toJson<int?>(daysBeforeDue),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'channel': serializer.toJson<String>(channel),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderRule copyWith({
    int? id,
    String? reminderType,
    Value<int?> offsetMinutes = const Value.absent(),
    Value<int?> daysBeforeDue = const Value.absent(),
    bool? isEnabled,
    String? channel,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReminderRule(
    id: id ?? this.id,
    reminderType: reminderType ?? this.reminderType,
    offsetMinutes: offsetMinutes.present
        ? offsetMinutes.value
        : this.offsetMinutes,
    daysBeforeDue: daysBeforeDue.present
        ? daysBeforeDue.value
        : this.daysBeforeDue,
    isEnabled: isEnabled ?? this.isEnabled,
    channel: channel ?? this.channel,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderRule copyWithCompanion(ReminderRulesCompanion data) {
    return ReminderRule(
      id: data.id.present ? data.id.value : this.id,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      offsetMinutes: data.offsetMinutes.present
          ? data.offsetMinutes.value
          : this.offsetMinutes,
      daysBeforeDue: data.daysBeforeDue.present
          ? data.daysBeforeDue.value
          : this.daysBeforeDue,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      channel: data.channel.present ? data.channel.value : this.channel,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRule(')
          ..write('id: $id, ')
          ..write('reminderType: $reminderType, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('daysBeforeDue: $daysBeforeDue, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('channel: $channel, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reminderType,
    offsetMinutes,
    daysBeforeDue,
    isEnabled,
    channel,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRule &&
          other.id == this.id &&
          other.reminderType == this.reminderType &&
          other.offsetMinutes == this.offsetMinutes &&
          other.daysBeforeDue == this.daysBeforeDue &&
          other.isEnabled == this.isEnabled &&
          other.channel == this.channel &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReminderRulesCompanion extends UpdateCompanion<ReminderRule> {
  final Value<int> id;
  final Value<String> reminderType;
  final Value<int?> offsetMinutes;
  final Value<int?> daysBeforeDue;
  final Value<bool> isEnabled;
  final Value<String> channel;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ReminderRulesCompanion({
    this.id = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.daysBeforeDue = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.channel = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReminderRulesCompanion.insert({
    this.id = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.daysBeforeDue = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.channel = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<ReminderRule> custom({
    Expression<int>? id,
    Expression<String>? reminderType,
    Expression<int>? offsetMinutes,
    Expression<int>? daysBeforeDue,
    Expression<bool>? isEnabled,
    Expression<String>? channel,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderType != null) 'reminder_type': reminderType,
      if (offsetMinutes != null) 'offset_minutes': offsetMinutes,
      if (daysBeforeDue != null) 'days_before_due': daysBeforeDue,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (channel != null) 'channel': channel,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReminderRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? reminderType,
    Value<int?>? offsetMinutes,
    Value<int?>? daysBeforeDue,
    Value<bool>? isEnabled,
    Value<String>? channel,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ReminderRulesCompanion(
      id: id ?? this.id,
      reminderType: reminderType ?? this.reminderType,
      offsetMinutes: offsetMinutes ?? this.offsetMinutes,
      daysBeforeDue: daysBeforeDue ?? this.daysBeforeDue,
      isEnabled: isEnabled ?? this.isEnabled,
      channel: channel ?? this.channel,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (offsetMinutes.present) {
      map['offset_minutes'] = Variable<int>(offsetMinutes.value);
    }
    if (daysBeforeDue.present) {
      map['days_before_due'] = Variable<int>(daysBeforeDue.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRulesCompanion(')
          ..write('id: $id, ')
          ..write('reminderType: $reminderType, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('daysBeforeDue: $daysBeforeDue, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('channel: $channel, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReminderLogsTable extends ReminderLogs
    with TableInfo<$ReminderLogsTable, ReminderLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reminderRuleIdMeta = const VerificationMeta(
    'reminderRuleId',
  );
  @override
  late final GeneratedColumn<int> reminderRuleId = GeneratedColumn<int>(
    'reminder_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reminder_rules (id)',
    ),
  );
  static const VerificationMeta _reminderTypeMeta = const VerificationMeta(
    'reminderType',
  );
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
    'reminder_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ReminderType.scheduleSession),
  );
  static const VerificationMeta _referenceTableMeta = const VerificationMeta(
    'referenceTable',
  );
  @override
  late final GeneratedColumn<String> referenceTable = GeneratedColumn<String>(
    'reference_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<int> referenceId = GeneratedColumn<int>(
    'reference_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggeredAtMeta = const VerificationMeta(
    'triggeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> triggeredAt = GeneratedColumn<DateTime>(
    'triggered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(ReminderStatus.scheduled),
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reminderRuleId,
    reminderType,
    referenceTable,
    referenceId,
    scheduledAt,
    triggeredAt,
    status,
    payloadJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reminder_rule_id')) {
      context.handle(
        _reminderRuleIdMeta,
        reminderRuleId.isAcceptableOrUnknown(
          data['reminder_rule_id']!,
          _reminderRuleIdMeta,
        ),
      );
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
        _reminderTypeMeta,
        reminderType.isAcceptableOrUnknown(
          data['reminder_type']!,
          _reminderTypeMeta,
        ),
      );
    }
    if (data.containsKey('reference_table')) {
      context.handle(
        _referenceTableMeta,
        referenceTable.isAcceptableOrUnknown(
          data['reference_table']!,
          _referenceTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceTableMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('triggered_at')) {
      context.handle(
        _triggeredAtMeta,
        triggeredAt.isAcceptableOrUnknown(
          data['triggered_at']!,
          _triggeredAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reminderRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_rule_id'],
      ),
      reminderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_type'],
      )!,
      referenceTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_table'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      triggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}triggered_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReminderLogsTable createAlias(String alias) {
    return $ReminderLogsTable(attachedDatabase, alias);
  }
}

class ReminderLog extends DataClass implements Insertable<ReminderLog> {
  final int id;
  final int? reminderRuleId;
  final String reminderType;
  final String referenceTable;
  final int referenceId;
  final DateTime scheduledAt;
  final DateTime? triggeredAt;
  final String status;
  final String? payloadJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderLog({
    required this.id,
    this.reminderRuleId,
    required this.reminderType,
    required this.referenceTable,
    required this.referenceId,
    required this.scheduledAt,
    this.triggeredAt,
    required this.status,
    this.payloadJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || reminderRuleId != null) {
      map['reminder_rule_id'] = Variable<int>(reminderRuleId);
    }
    map['reminder_type'] = Variable<String>(reminderType);
    map['reference_table'] = Variable<String>(referenceTable);
    map['reference_id'] = Variable<int>(referenceId);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || triggeredAt != null) {
      map['triggered_at'] = Variable<DateTime>(triggeredAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReminderLogsCompanion toCompanion(bool nullToAbsent) {
    return ReminderLogsCompanion(
      id: Value(id),
      reminderRuleId: reminderRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderRuleId),
      reminderType: Value(reminderType),
      referenceTable: Value(referenceTable),
      referenceId: Value(referenceId),
      scheduledAt: Value(scheduledAt),
      triggeredAt: triggeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(triggeredAt),
      status: Value(status),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderLog(
      id: serializer.fromJson<int>(json['id']),
      reminderRuleId: serializer.fromJson<int?>(json['reminderRuleId']),
      reminderType: serializer.fromJson<String>(json['reminderType']),
      referenceTable: serializer.fromJson<String>(json['referenceTable']),
      referenceId: serializer.fromJson<int>(json['referenceId']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      triggeredAt: serializer.fromJson<DateTime?>(json['triggeredAt']),
      status: serializer.fromJson<String>(json['status']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reminderRuleId': serializer.toJson<int?>(reminderRuleId),
      'reminderType': serializer.toJson<String>(reminderType),
      'referenceTable': serializer.toJson<String>(referenceTable),
      'referenceId': serializer.toJson<int>(referenceId),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'triggeredAt': serializer.toJson<DateTime?>(triggeredAt),
      'status': serializer.toJson<String>(status),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderLog copyWith({
    int? id,
    Value<int?> reminderRuleId = const Value.absent(),
    String? reminderType,
    String? referenceTable,
    int? referenceId,
    DateTime? scheduledAt,
    Value<DateTime?> triggeredAt = const Value.absent(),
    String? status,
    Value<String?> payloadJson = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReminderLog(
    id: id ?? this.id,
    reminderRuleId: reminderRuleId.present
        ? reminderRuleId.value
        : this.reminderRuleId,
    reminderType: reminderType ?? this.reminderType,
    referenceTable: referenceTable ?? this.referenceTable,
    referenceId: referenceId ?? this.referenceId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    triggeredAt: triggeredAt.present ? triggeredAt.value : this.triggeredAt,
    status: status ?? this.status,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderLog copyWithCompanion(ReminderLogsCompanion data) {
    return ReminderLog(
      id: data.id.present ? data.id.value : this.id,
      reminderRuleId: data.reminderRuleId.present
          ? data.reminderRuleId.value
          : this.reminderRuleId,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      referenceTable: data.referenceTable.present
          ? data.referenceTable.value
          : this.referenceTable,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      triggeredAt: data.triggeredAt.present
          ? data.triggeredAt.value
          : this.triggeredAt,
      status: data.status.present ? data.status.value : this.status,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderLog(')
          ..write('id: $id, ')
          ..write('reminderRuleId: $reminderRuleId, ')
          ..write('reminderType: $reminderType, ')
          ..write('referenceTable: $referenceTable, ')
          ..write('referenceId: $referenceId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('status: $status, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reminderRuleId,
    reminderType,
    referenceTable,
    referenceId,
    scheduledAt,
    triggeredAt,
    status,
    payloadJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderLog &&
          other.id == this.id &&
          other.reminderRuleId == this.reminderRuleId &&
          other.reminderType == this.reminderType &&
          other.referenceTable == this.referenceTable &&
          other.referenceId == this.referenceId &&
          other.scheduledAt == this.scheduledAt &&
          other.triggeredAt == this.triggeredAt &&
          other.status == this.status &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReminderLogsCompanion extends UpdateCompanion<ReminderLog> {
  final Value<int> id;
  final Value<int?> reminderRuleId;
  final Value<String> reminderType;
  final Value<String> referenceTable;
  final Value<int> referenceId;
  final Value<DateTime> scheduledAt;
  final Value<DateTime?> triggeredAt;
  final Value<String> status;
  final Value<String?> payloadJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ReminderLogsCompanion({
    this.id = const Value.absent(),
    this.reminderRuleId = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.referenceTable = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.triggeredAt = const Value.absent(),
    this.status = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReminderLogsCompanion.insert({
    this.id = const Value.absent(),
    this.reminderRuleId = const Value.absent(),
    this.reminderType = const Value.absent(),
    required String referenceTable,
    required int referenceId,
    required DateTime scheduledAt,
    this.triggeredAt = const Value.absent(),
    this.status = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : referenceTable = Value(referenceTable),
       referenceId = Value(referenceId),
       scheduledAt = Value(scheduledAt);
  static Insertable<ReminderLog> custom({
    Expression<int>? id,
    Expression<int>? reminderRuleId,
    Expression<String>? reminderType,
    Expression<String>? referenceTable,
    Expression<int>? referenceId,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? triggeredAt,
    Expression<String>? status,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderRuleId != null) 'reminder_rule_id': reminderRuleId,
      if (reminderType != null) 'reminder_type': reminderType,
      if (referenceTable != null) 'reference_table': referenceTable,
      if (referenceId != null) 'reference_id': referenceId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (triggeredAt != null) 'triggered_at': triggeredAt,
      if (status != null) 'status': status,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReminderLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? reminderRuleId,
    Value<String>? reminderType,
    Value<String>? referenceTable,
    Value<int>? referenceId,
    Value<DateTime>? scheduledAt,
    Value<DateTime?>? triggeredAt,
    Value<String>? status,
    Value<String?>? payloadJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ReminderLogsCompanion(
      id: id ?? this.id,
      reminderRuleId: reminderRuleId ?? this.reminderRuleId,
      reminderType: reminderType ?? this.reminderType,
      referenceTable: referenceTable ?? this.referenceTable,
      referenceId: referenceId ?? this.referenceId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      status: status ?? this.status,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reminderRuleId.present) {
      map['reminder_rule_id'] = Variable<int>(reminderRuleId.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (referenceTable.present) {
      map['reference_table'] = Variable<String>(referenceTable.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<int>(referenceId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (triggeredAt.present) {
      map['triggered_at'] = Variable<DateTime>(triggeredAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderLogsCompanion(')
          ..write('id: $id, ')
          ..write('reminderRuleId: $reminderRuleId, ')
          ..write('reminderType: $reminderType, ')
          ..write('referenceTable: $referenceTable, ')
          ..write('referenceId: $referenceId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('status: $status, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const Setting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      Setting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupMetadataTable extends BackupMetadata
    with TableInfo<$BackupMetadataTable, BackupMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fileName, filePath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BackupMetadataTable createAlias(String alias) {
    return $BackupMetadataTable(attachedDatabase, alias);
  }
}

class BackupMetadataData extends DataClass
    implements Insertable<BackupMetadataData> {
  final int id;
  final String fileName;
  final String filePath;
  final DateTime createdAt;
  const BackupMetadataData({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_name'] = Variable<String>(fileName);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BackupMetadataCompanion toCompanion(bool nullToAbsent) {
    return BackupMetadataCompanion(
      id: Value(id),
      fileName: Value(fileName),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
    );
  }

  factory BackupMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupMetadataData(
      id: serializer.fromJson<int>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BackupMetadataData copyWith({
    int? id,
    String? fileName,
    String? filePath,
    DateTime? createdAt,
  }) => BackupMetadataData(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
  );
  BackupMetadataData copyWithCompanion(BackupMetadataCompanion data) {
    return BackupMetadataData(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataData(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fileName, filePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupMetadataData &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt);
}

class BackupMetadataCompanion extends UpdateCompanion<BackupMetadataData> {
  final Value<int> id;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  const BackupMetadataCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BackupMetadataCompanion.insert({
    this.id = const Value.absent(),
    required String fileName,
    required String filePath,
    this.createdAt = const Value.absent(),
  }) : fileName = Value(fileName),
       filePath = Value(filePath);
  static Insertable<BackupMetadataData> custom({
    Expression<int>? id,
    Expression<String>? fileName,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BackupMetadataCompanion copyWith({
    Value<int>? id,
    Value<String>? fileName,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
  }) {
    return BackupMetadataCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $AcademicPeriodsTable academicPeriods = $AcademicPeriodsTable(
    this,
  );
  late final $StudentPeriodsTable studentPeriods = $StudentPeriodsTable(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $AssessmentsTable assessments = $AssessmentsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ProgressReportsTable progressReports = $ProgressReportsTable(
    this,
  );
  late final $ReminderRulesTable reminderRules = $ReminderRulesTable(this);
  late final $ReminderLogsTable reminderLogs = $ReminderLogsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $BackupMetadataTable backupMetadata = $BackupMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    students,
    subjects,
    academicPeriods,
    studentPeriods,
    schedules,
    sessions,
    assessments,
    invoices,
    payments,
    progressReports,
    reminderRules,
    reminderLogs,
    settings,
    backupMetadata,
  ];
}

typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> parentName,
      Value<String?> whatsapp,
      Value<String?> address,
      Value<String?> school,
      Value<String?> grade,
      Value<String?> defaultSubject,
      Value<int?> defaultAcademicPeriodId,
      Value<String> rateType,
      Value<int> rateAmount,
      Value<String> status,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> parentName,
      Value<String?> whatsapp,
      Value<String?> address,
      Value<String?> school,
      Value<String?> grade,
      Value<String?> defaultSubject,
      Value<int?> defaultAcademicPeriodId,
      Value<String> rateType,
      Value<int> rateAmount,
      Value<String> status,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subjects,
    aliasName: $_aliasNameGenerator(db.students.id, db.subjects.studentId),
  );

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudentPeriodsTable, List<StudentPeriod>>
  _studentPeriodsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studentPeriods,
    aliasName: $_aliasNameGenerator(
      db.students.id,
      db.studentPeriods.studentId,
    ),
  );

  $$StudentPeriodsTableProcessedTableManager get studentPeriodsRefs {
    final manager = $$StudentPeriodsTableTableManager(
      $_db,
      $_db.studentPeriods,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentPeriodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SchedulesTable, List<Schedule>>
  _schedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedules,
    aliasName: $_aliasNameGenerator(db.students.id, db.schedules.studentId),
  );

  $$SchedulesTableProcessedTableManager get schedulesRefs {
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_schedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.students.id, db.sessions.studentId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssessmentsTable, List<Assessment>>
  _assessmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assessments,
    aliasName: $_aliasNameGenerator(db.students.id, db.assessments.studentId),
  );

  $$AssessmentsTableProcessedTableManager get assessmentsRefs {
    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assessmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.students.id, db.invoices.studentId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProgressReportsTable, List<ProgressReport>>
  _progressReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.progressReports,
    aliasName: $_aliasNameGenerator(
      db.students.id,
      db.progressReports.studentId,
    ),
  );

  $$ProgressReportsTableProcessedTableManager get progressReportsRefs {
    final manager = $$ProgressReportsTableTableManager(
      $_db,
      $_db.progressReports,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _progressReportsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultSubject => $composableBuilder(
    column: $table.defaultSubject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultAcademicPeriodId => $composableBuilder(
    column: $table.defaultAcademicPeriodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rateType => $composableBuilder(
    column: $table.rateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rateAmount => $composableBuilder(
    column: $table.rateAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subjectsRefs(
    Expression<bool> Function($$SubjectsTableFilterComposer f) f,
  ) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentPeriodsRefs(
    Expression<bool> Function($$StudentPeriodsTableFilterComposer f) f,
  ) {
    final $$StudentPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentPeriods,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.studentPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> schedulesRefs(
    Expression<bool> Function($$SchedulesTableFilterComposer f) f,
  ) {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assessmentsRefs(
    Expression<bool> Function($$AssessmentsTableFilterComposer f) f,
  ) {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> progressReportsRefs(
    Expression<bool> Function($$ProgressReportsTableFilterComposer f) f,
  ) {
    final $$ProgressReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progressReports,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressReportsTableFilterComposer(
            $db: $db,
            $table: $db.progressReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSubject => $composableBuilder(
    column: $table.defaultSubject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultAcademicPeriodId => $composableBuilder(
    column: $table.defaultAcademicPeriodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rateType => $composableBuilder(
    column: $table.rateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rateAmount => $composableBuilder(
    column: $table.rateAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get parentName => $composableBuilder(
    column: $table.parentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get defaultSubject => $composableBuilder(
    column: $table.defaultSubject,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultAcademicPeriodId => $composableBuilder(
    column: $table.defaultAcademicPeriodId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rateType =>
      $composableBuilder(column: $table.rateType, builder: (column) => column);

  GeneratedColumn<int> get rateAmount => $composableBuilder(
    column: $table.rateAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> subjectsRefs<T extends Object>(
    Expression<T> Function($$SubjectsTableAnnotationComposer a) f,
  ) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studentPeriodsRefs<T extends Object>(
    Expression<T> Function($$StudentPeriodsTableAnnotationComposer a) f,
  ) {
    final $$StudentPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentPeriods,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.studentPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> schedulesRefs<T extends Object>(
    Expression<T> Function($$SchedulesTableAnnotationComposer a) f,
  ) {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assessmentsRefs<T extends Object>(
    Expression<T> Function($$AssessmentsTableAnnotationComposer a) f,
  ) {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> progressReportsRefs<T extends Object>(
    Expression<T> Function($$ProgressReportsTableAnnotationComposer a) f,
  ) {
    final $$ProgressReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progressReports,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.progressReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, $$StudentsTableReferences),
          Student,
          PrefetchHooks Function({
            bool subjectsRefs,
            bool studentPeriodsRefs,
            bool schedulesRefs,
            bool sessionsRefs,
            bool assessmentsRefs,
            bool invoicesRefs,
            bool progressReportsRefs,
          })
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> parentName = const Value.absent(),
                Value<String?> whatsapp = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> school = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> defaultSubject = const Value.absent(),
                Value<int?> defaultAcademicPeriodId = const Value.absent(),
                Value<String> rateType = const Value.absent(),
                Value<int> rateAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                name: name,
                parentName: parentName,
                whatsapp: whatsapp,
                address: address,
                school: school,
                grade: grade,
                defaultSubject: defaultSubject,
                defaultAcademicPeriodId: defaultAcademicPeriodId,
                rateType: rateType,
                rateAmount: rateAmount,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> parentName = const Value.absent(),
                Value<String?> whatsapp = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> school = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> defaultSubject = const Value.absent(),
                Value<int?> defaultAcademicPeriodId = const Value.absent(),
                Value<String> rateType = const Value.absent(),
                Value<int> rateAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StudentsCompanion.insert(
                id: id,
                name: name,
                parentName: parentName,
                whatsapp: whatsapp,
                address: address,
                school: school,
                grade: grade,
                defaultSubject: defaultSubject,
                defaultAcademicPeriodId: defaultAcademicPeriodId,
                rateType: rateType,
                rateAmount: rateAmount,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectsRefs = false,
                studentPeriodsRefs = false,
                schedulesRefs = false,
                sessionsRefs = false,
                assessmentsRefs = false,
                invoicesRefs = false,
                progressReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subjectsRefs) db.subjects,
                    if (studentPeriodsRefs) db.studentPeriods,
                    if (schedulesRefs) db.schedules,
                    if (sessionsRefs) db.sessions,
                    if (assessmentsRefs) db.assessments,
                    if (invoicesRefs) db.invoices,
                    if (progressReportsRefs) db.progressReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subjectsRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          Subject
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._subjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).subjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studentPeriodsRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          StudentPeriod
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._studentPeriodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentPeriodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (schedulesRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          Schedule
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._schedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).schedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          Session
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (assessmentsRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          Assessment
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._assessmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).assessmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (progressReportsRefs)
                        await $_getPrefetchedData<
                          Student,
                          $StudentsTable,
                          ProgressReport
                        >(
                          currentTable: table,
                          referencedTable: $$StudentsTableReferences
                              ._progressReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudentsTableReferences(
                                db,
                                table,
                                p0,
                              ).progressReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.studentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, $$StudentsTableReferences),
      Student,
      PrefetchHooks Function({
        bool subjectsRefs,
        bool studentPeriodsRefs,
        bool schedulesRefs,
        bool sessionsRefs,
        bool assessmentsRefs,
        bool invoicesRefs,
        bool progressReportsRefs,
      })
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      Value<int?> studentId,
      required String name,
      Value<int> defaultRateAmount,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      Value<int?> studentId,
      Value<String> name,
      Value<int> defaultRateAmount,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) => db.students
      .createAlias($_aliasNameGenerator(db.subjects.studentId, db.students.id));

  $$StudentsTableProcessedTableManager? get studentId {
    final $_column = $_itemColumn<int>('student_id');
    if ($_column == null) return null;
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SchedulesTable, List<Schedule>>
  _schedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedules,
    aliasName: $_aliasNameGenerator(db.subjects.id, db.schedules.subjectId),
  );

  $$SchedulesTableProcessedTableManager get schedulesRefs {
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_schedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.subjects.id, db.sessions.subjectId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultRateAmount => $composableBuilder(
    column: $table.defaultRateAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> schedulesRefs(
    Expression<bool> Function($$SchedulesTableFilterComposer f) f,
  ) {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultRateAmount => $composableBuilder(
    column: $table.defaultRateAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get defaultRateAmount => $composableBuilder(
    column: $table.defaultRateAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> schedulesRefs<T extends Object>(
    Expression<T> Function($$SchedulesTableAnnotationComposer a) f,
  ) {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({
            bool studentId,
            bool schedulesRefs,
            bool sessionsRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> studentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> defaultRateAmount = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                studentId: studentId,
                name: name,
                defaultRateAmount: defaultRateAmount,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> studentId = const Value.absent(),
                required String name,
                Value<int> defaultRateAmount = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                studentId: studentId,
                name: name,
                defaultRateAmount: defaultRateAmount,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentId = false,
                schedulesRefs = false,
                sessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (schedulesRefs) db.schedules,
                    if (sessionsRefs) db.sessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable: $$SubjectsTableReferences
                                        ._studentIdTable(db),
                                    referencedColumn: $$SubjectsTableReferences
                                        ._studentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (schedulesRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          Schedule
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._schedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).schedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          Subject,
                          $SubjectsTable,
                          Session
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subjectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({
        bool studentId,
        bool schedulesRefs,
        bool sessionsRefs,
      })
    >;
typedef $$AcademicPeriodsTableCreateCompanionBuilder =
    AcademicPeriodsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> periodType,
      required DateTime startDate,
      required DateTime endDate,
      Value<bool> isActive,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$AcademicPeriodsTableUpdateCompanionBuilder =
    AcademicPeriodsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> periodType,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> isActive,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$AcademicPeriodsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AcademicPeriodsTable, AcademicPeriod> {
  $$AcademicPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StudentPeriodsTable, List<StudentPeriod>>
  _studentPeriodsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studentPeriods,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.studentPeriods.academicPeriodId,
    ),
  );

  $$StudentPeriodsTableProcessedTableManager get studentPeriodsRefs {
    final manager = $$StudentPeriodsTableTableManager(
      $_db,
      $_db.studentPeriods,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentPeriodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SchedulesTable, List<Schedule>>
  _schedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedules,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.schedules.academicPeriodId,
    ),
  );

  $$SchedulesTableProcessedTableManager get schedulesRefs {
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_schedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.sessions.academicPeriodId,
    ),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssessmentsTable, List<Assessment>>
  _assessmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assessments,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.assessments.academicPeriodId,
    ),
  );

  $$AssessmentsTableProcessedTableManager get assessmentsRefs {
    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assessmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.invoices.academicPeriodId,
    ),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProgressReportsTable, List<ProgressReport>>
  _progressReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.progressReports,
    aliasName: $_aliasNameGenerator(
      db.academicPeriods.id,
      db.progressReports.academicPeriodId,
    ),
  );

  $$ProgressReportsTableProcessedTableManager get progressReportsRefs {
    final manager = $$ProgressReportsTableTableManager(
      $_db,
      $_db.progressReports,
    ).filter((f) => f.academicPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _progressReportsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AcademicPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $AcademicPeriodsTable> {
  $$AcademicPeriodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studentPeriodsRefs(
    Expression<bool> Function($$StudentPeriodsTableFilterComposer f) f,
  ) {
    final $$StudentPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentPeriods,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.studentPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> schedulesRefs(
    Expression<bool> Function($$SchedulesTableFilterComposer f) f,
  ) {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assessmentsRefs(
    Expression<bool> Function($$AssessmentsTableFilterComposer f) f,
  ) {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> progressReportsRefs(
    Expression<bool> Function($$ProgressReportsTableFilterComposer f) f,
  ) {
    final $$ProgressReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progressReports,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressReportsTableFilterComposer(
            $db: $db,
            $table: $db.progressReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AcademicPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $AcademicPeriodsTable> {
  $$AcademicPeriodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AcademicPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcademicPeriodsTable> {
  $$AcademicPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get periodType => $composableBuilder(
    column: $table.periodType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> studentPeriodsRefs<T extends Object>(
    Expression<T> Function($$StudentPeriodsTableAnnotationComposer a) f,
  ) {
    final $$StudentPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentPeriods,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.studentPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> schedulesRefs<T extends Object>(
    Expression<T> Function($$SchedulesTableAnnotationComposer a) f,
  ) {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assessmentsRefs<T extends Object>(
    Expression<T> Function($$AssessmentsTableAnnotationComposer a) f,
  ) {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> progressReportsRefs<T extends Object>(
    Expression<T> Function($$ProgressReportsTableAnnotationComposer a) f,
  ) {
    final $$ProgressReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.progressReports,
      getReferencedColumn: (t) => t.academicPeriodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgressReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.progressReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AcademicPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AcademicPeriodsTable,
          AcademicPeriod,
          $$AcademicPeriodsTableFilterComposer,
          $$AcademicPeriodsTableOrderingComposer,
          $$AcademicPeriodsTableAnnotationComposer,
          $$AcademicPeriodsTableCreateCompanionBuilder,
          $$AcademicPeriodsTableUpdateCompanionBuilder,
          (AcademicPeriod, $$AcademicPeriodsTableReferences),
          AcademicPeriod,
          PrefetchHooks Function({
            bool studentPeriodsRefs,
            bool schedulesRefs,
            bool sessionsRefs,
            bool assessmentsRefs,
            bool invoicesRefs,
            bool progressReportsRefs,
          })
        > {
  $$AcademicPeriodsTableTableManager(
    _$AppDatabase db,
    $AcademicPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcademicPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AcademicPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AcademicPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> periodType = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => AcademicPeriodsCompanion(
                id: id,
                name: name,
                periodType: periodType,
                startDate: startDate,
                endDate: endDate,
                isActive: isActive,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> periodType = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                Value<bool> isActive = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => AcademicPeriodsCompanion.insert(
                id: id,
                name: name,
                periodType: periodType,
                startDate: startDate,
                endDate: endDate,
                isActive: isActive,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AcademicPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentPeriodsRefs = false,
                schedulesRefs = false,
                sessionsRefs = false,
                assessmentsRefs = false,
                invoicesRefs = false,
                progressReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentPeriodsRefs) db.studentPeriods,
                    if (schedulesRefs) db.schedules,
                    if (sessionsRefs) db.sessions,
                    if (assessmentsRefs) db.assessments,
                    if (invoicesRefs) db.invoices,
                    if (progressReportsRefs) db.progressReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentPeriodsRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          StudentPeriod
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._studentPeriodsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).studentPeriodsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (schedulesRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          Schedule
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._schedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).schedulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          Session
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (assessmentsRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          Assessment
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._assessmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).assessmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (progressReportsRefs)
                        await $_getPrefetchedData<
                          AcademicPeriod,
                          $AcademicPeriodsTable,
                          ProgressReport
                        >(
                          currentTable: table,
                          referencedTable: $$AcademicPeriodsTableReferences
                              ._progressReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AcademicPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).progressReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.academicPeriodId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AcademicPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AcademicPeriodsTable,
      AcademicPeriod,
      $$AcademicPeriodsTableFilterComposer,
      $$AcademicPeriodsTableOrderingComposer,
      $$AcademicPeriodsTableAnnotationComposer,
      $$AcademicPeriodsTableCreateCompanionBuilder,
      $$AcademicPeriodsTableUpdateCompanionBuilder,
      (AcademicPeriod, $$AcademicPeriodsTableReferences),
      AcademicPeriod,
      PrefetchHooks Function({
        bool studentPeriodsRefs,
        bool schedulesRefs,
        bool sessionsRefs,
        bool assessmentsRefs,
        bool invoicesRefs,
        bool progressReportsRefs,
      })
    >;
typedef $$StudentPeriodsTableCreateCompanionBuilder =
    StudentPeriodsCompanion Function({
      Value<int> id,
      required int studentId,
      required int academicPeriodId,
      Value<DateTime> enrolledAt,
      Value<String> status,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$StudentPeriodsTableUpdateCompanionBuilder =
    StudentPeriodsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> academicPeriodId,
      Value<DateTime> enrolledAt,
      Value<String> status,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$StudentPeriodsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentPeriodsTable, StudentPeriod> {
  $$StudentPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
        $_aliasNameGenerator(db.studentPeriods.studentId, db.students.id),
      );

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.studentPeriods.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id')!;

    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentPeriodsTable> {
  $$StudentPeriodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentPeriodsTable> {
  $$StudentPeriodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentPeriodsTable> {
  $$StudentPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get enrolledAt => $composableBuilder(
    column: $table.enrolledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentPeriodsTable,
          StudentPeriod,
          $$StudentPeriodsTableFilterComposer,
          $$StudentPeriodsTableOrderingComposer,
          $$StudentPeriodsTableAnnotationComposer,
          $$StudentPeriodsTableCreateCompanionBuilder,
          $$StudentPeriodsTableUpdateCompanionBuilder,
          (StudentPeriod, $$StudentPeriodsTableReferences),
          StudentPeriod,
          PrefetchHooks Function({bool studentId, bool academicPeriodId})
        > {
  $$StudentPeriodsTableTableManager(
    _$AppDatabase db,
    $StudentPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> academicPeriodId = const Value.absent(),
                Value<DateTime> enrolledAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StudentPeriodsCompanion(
                id: id,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                enrolledAt: enrolledAt,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int academicPeriodId,
                Value<DateTime> enrolledAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StudentPeriodsCompanion.insert(
                id: id,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                enrolledAt: enrolledAt,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studentId = false, academicPeriodId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable:
                                        $$StudentPeriodsTableReferences
                                            ._studentIdTable(db),
                                    referencedColumn:
                                        $$StudentPeriodsTableReferences
                                            ._studentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable:
                                        $$StudentPeriodsTableReferences
                                            ._academicPeriodIdTable(db),
                                    referencedColumn:
                                        $$StudentPeriodsTableReferences
                                            ._academicPeriodIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$StudentPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentPeriodsTable,
      StudentPeriod,
      $$StudentPeriodsTableFilterComposer,
      $$StudentPeriodsTableOrderingComposer,
      $$StudentPeriodsTableAnnotationComposer,
      $$StudentPeriodsTableCreateCompanionBuilder,
      $$StudentPeriodsTableUpdateCompanionBuilder,
      (StudentPeriod, $$StudentPeriodsTableReferences),
      StudentPeriod,
      PrefetchHooks Function({bool studentId, bool academicPeriodId})
    >;
typedef $$SchedulesTableCreateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      required int studentId,
      required int subjectId,
      Value<int?> academicPeriodId,
      required DateTime date,
      required DateTime startTime,
      required DateTime endTime,
      Value<String> scheduleType,
      Value<String> status,
      Value<String?> recurrenceGroupId,
      Value<bool> reminderEnabled,
      Value<int> reminderOffsetMinutes,
      Value<String?> note,
      Value<DateTime?> lastRescheduledAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$SchedulesTableUpdateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> subjectId,
      Value<int?> academicPeriodId,
      Value<DateTime> date,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String> scheduleType,
      Value<String> status,
      Value<String?> recurrenceGroupId,
      Value<bool> reminderEnabled,
      Value<int> reminderOffsetMinutes,
      Value<String?> note,
      Value<DateTime?> lastRescheduledAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$SchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $SchedulesTable, Schedule> {
  $$SchedulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
        $_aliasNameGenerator(db.schedules.studentId, db.students.id),
      );

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias(
        $_aliasNameGenerator(db.schedules.subjectId, db.subjects.id),
      );

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.schedules.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager? get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id');
    if ($_column == null) return null;
    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<Session>> _sessionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: $_aliasNameGenerator(db.schedules.id, db.sessions.scheduleId),
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.scheduleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderOffsetMinutes => $composableBuilder(
    column: $table.reminderOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRescheduledAt => $composableBuilder(
    column: $table.lastRescheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderOffsetMinutes => $composableBuilder(
    column: $table.reminderOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRescheduledAt => $composableBuilder(
    column: $table.lastRescheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderOffsetMinutes => $composableBuilder(
    column: $table.reminderOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRescheduledAt => $composableBuilder(
    column: $table.lastRescheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.scheduleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchedulesTable,
          Schedule,
          $$SchedulesTableFilterComposer,
          $$SchedulesTableOrderingComposer,
          $$SchedulesTableAnnotationComposer,
          $$SchedulesTableCreateCompanionBuilder,
          $$SchedulesTableUpdateCompanionBuilder,
          (Schedule, $$SchedulesTableReferences),
          Schedule,
          PrefetchHooks Function({
            bool studentId,
            bool subjectId,
            bool academicPeriodId,
            bool sessionsRefs,
          })
        > {
  $$SchedulesTableTableManager(_$AppDatabase db, $SchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int?> academicPeriodId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderOffsetMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime?> lastRescheduledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SchedulesCompanion(
                id: id,
                studentId: studentId,
                subjectId: subjectId,
                academicPeriodId: academicPeriodId,
                date: date,
                startTime: startTime,
                endTime: endTime,
                scheduleType: scheduleType,
                status: status,
                recurrenceGroupId: recurrenceGroupId,
                reminderEnabled: reminderEnabled,
                reminderOffsetMinutes: reminderOffsetMinutes,
                note: note,
                lastRescheduledAt: lastRescheduledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int subjectId,
                Value<int?> academicPeriodId = const Value.absent(),
                required DateTime date,
                required DateTime startTime,
                required DateTime endTime,
                Value<String> scheduleType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderOffsetMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime?> lastRescheduledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SchedulesCompanion.insert(
                id: id,
                studentId: studentId,
                subjectId: subjectId,
                academicPeriodId: academicPeriodId,
                date: date,
                startTime: startTime,
                endTime: endTime,
                scheduleType: scheduleType,
                status: status,
                recurrenceGroupId: recurrenceGroupId,
                reminderEnabled: reminderEnabled,
                reminderOffsetMinutes: reminderOffsetMinutes,
                note: note,
                lastRescheduledAt: lastRescheduledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentId = false,
                subjectId = false,
                academicPeriodId = false,
                sessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (sessionsRefs) db.sessions],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable: $$SchedulesTableReferences
                                        ._studentIdTable(db),
                                    referencedColumn: $$SchedulesTableReferences
                                        ._studentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (subjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.subjectId,
                                    referencedTable: $$SchedulesTableReferences
                                        ._subjectIdTable(db),
                                    referencedColumn: $$SchedulesTableReferences
                                        ._subjectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable: $$SchedulesTableReferences
                                        ._academicPeriodIdTable(db),
                                    referencedColumn: $$SchedulesTableReferences
                                        ._academicPeriodIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          Schedule,
                          $SchedulesTable,
                          Session
                        >(
                          currentTable: table,
                          referencedTable: $$SchedulesTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SchedulesTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scheduleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchedulesTable,
      Schedule,
      $$SchedulesTableFilterComposer,
      $$SchedulesTableOrderingComposer,
      $$SchedulesTableAnnotationComposer,
      $$SchedulesTableCreateCompanionBuilder,
      $$SchedulesTableUpdateCompanionBuilder,
      (Schedule, $$SchedulesTableReferences),
      Schedule,
      PrefetchHooks Function({
        bool studentId,
        bool subjectId,
        bool academicPeriodId,
        bool sessionsRefs,
      })
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int?> scheduleId,
      required int studentId,
      required int subjectId,
      Value<int?> academicPeriodId,
      Value<DateTime> sessionDate,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String> attendanceStatus,
      Value<String?> material,
      Value<String?> homework,
      Value<String?> note,
      Value<String?> progressNote,
      Value<int> feeAmount,
      Value<bool> isAttendanceSource,
      Value<int?> invoiceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int?> scheduleId,
      Value<int> studentId,
      Value<int> subjectId,
      Value<int?> academicPeriodId,
      Value<DateTime> sessionDate,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<String> attendanceStatus,
      Value<String?> material,
      Value<String?> homework,
      Value<String?> note,
      Value<String?> progressNote,
      Value<int> feeAmount,
      Value<bool> isAttendanceSource,
      Value<int?> invoiceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SchedulesTable _scheduleIdTable(_$AppDatabase db) =>
      db.schedules.createAlias(
        $_aliasNameGenerator(db.sessions.scheduleId, db.schedules.id),
      );

  $$SchedulesTableProcessedTableManager? get scheduleId {
    final $_column = $_itemColumn<int>('schedule_id');
    if ($_column == null) return null;
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) => db.students
      .createAlias($_aliasNameGenerator(db.sessions.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) => db.subjects
      .createAlias($_aliasNameGenerator(db.sessions.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.sessions.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager? get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id');
    if ($_column == null) return null;
    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AssessmentsTable, List<Assessment>>
  _assessmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.assessments,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.assessments.sessionId),
  );

  $$AssessmentsTableProcessedTableManager get assessmentsRefs {
    final manager = $$AssessmentsTableTableManager(
      $_db,
      $_db.assessments,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assessmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.invoices.sessionId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homework => $composableBuilder(
    column: $table.homework,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get progressNote => $composableBuilder(
    column: $table.progressNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feeAmount => $composableBuilder(
    column: $table.feeAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAttendanceSource => $composableBuilder(
    column: $table.isAttendanceSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SchedulesTableFilterComposer get scheduleId {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> assessmentsRefs(
    Expression<bool> Function($$AssessmentsTableFilterComposer f) f,
  ) {
    final $$AssessmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableFilterComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homework => $composableBuilder(
    column: $table.homework,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get progressNote => $composableBuilder(
    column: $table.progressNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feeAmount => $composableBuilder(
    column: $table.feeAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAttendanceSource => $composableBuilder(
    column: $table.isAttendanceSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SchedulesTableOrderingComposer get scheduleId {
    final $$SchedulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableOrderingComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<String> get homework =>
      $composableBuilder(column: $table.homework, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get progressNote => $composableBuilder(
    column: $table.progressNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get feeAmount =>
      $composableBuilder(column: $table.feeAmount, builder: (column) => column);

  GeneratedColumn<bool> get isAttendanceSource => $composableBuilder(
    column: $table.isAttendanceSource,
    builder: (column) => column,
  );

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$SchedulesTableAnnotationComposer get scheduleId {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleId,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> assessmentsRefs<T extends Object>(
    Expression<T> Function($$AssessmentsTableAnnotationComposer a) f,
  ) {
    final $$AssessmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assessments,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssessmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.assessments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({
            bool scheduleId,
            bool studentId,
            bool subjectId,
            bool academicPeriodId,
            bool assessmentsRefs,
            bool invoicesRefs,
          })
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduleId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int?> academicPeriodId = const Value.absent(),
                Value<DateTime> sessionDate = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String> attendanceStatus = const Value.absent(),
                Value<String?> material = const Value.absent(),
                Value<String?> homework = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> progressNote = const Value.absent(),
                Value<int> feeAmount = const Value.absent(),
                Value<bool> isAttendanceSource = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                scheduleId: scheduleId,
                studentId: studentId,
                subjectId: subjectId,
                academicPeriodId: academicPeriodId,
                sessionDate: sessionDate,
                startTime: startTime,
                endTime: endTime,
                attendanceStatus: attendanceStatus,
                material: material,
                homework: homework,
                note: note,
                progressNote: progressNote,
                feeAmount: feeAmount,
                isAttendanceSource: isAttendanceSource,
                invoiceId: invoiceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduleId = const Value.absent(),
                required int studentId,
                required int subjectId,
                Value<int?> academicPeriodId = const Value.absent(),
                Value<DateTime> sessionDate = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<String> attendanceStatus = const Value.absent(),
                Value<String?> material = const Value.absent(),
                Value<String?> homework = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> progressNote = const Value.absent(),
                Value<int> feeAmount = const Value.absent(),
                Value<bool> isAttendanceSource = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                scheduleId: scheduleId,
                studentId: studentId,
                subjectId: subjectId,
                academicPeriodId: academicPeriodId,
                sessionDate: sessionDate,
                startTime: startTime,
                endTime: endTime,
                attendanceStatus: attendanceStatus,
                material: material,
                homework: homework,
                note: note,
                progressNote: progressNote,
                feeAmount: feeAmount,
                isAttendanceSource: isAttendanceSource,
                invoiceId: invoiceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                scheduleId = false,
                studentId = false,
                subjectId = false,
                academicPeriodId = false,
                assessmentsRefs = false,
                invoicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (assessmentsRefs) db.assessments,
                    if (invoicesRefs) db.invoices,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (scheduleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.scheduleId,
                                    referencedTable: $$SessionsTableReferences
                                        ._scheduleIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._scheduleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable: $$SessionsTableReferences
                                        ._studentIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._studentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (subjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.subjectId,
                                    referencedTable: $$SessionsTableReferences
                                        ._subjectIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._subjectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable: $$SessionsTableReferences
                                        ._academicPeriodIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._academicPeriodIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (assessmentsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          Assessment
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._assessmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).assessmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({
        bool scheduleId,
        bool studentId,
        bool subjectId,
        bool academicPeriodId,
        bool assessmentsRefs,
        bool invoicesRefs,
      })
    >;
typedef $$AssessmentsTableCreateCompanionBuilder =
    AssessmentsCompanion Function({
      Value<int> id,
      Value<int?> sessionId,
      required int studentId,
      Value<int?> academicPeriodId,
      Value<String> assessmentType,
      Value<String?> reviewCycleLabel,
      Value<String?> pemahamanMateri,
      Value<String?> keaktifanTanyaJawab,
      Value<String?> ketepatanKerapianTugas,
      Value<String?> konsistensiKehadiranFokus,
      Value<String?> targetMateriDrilling,
      Value<String?> sikapBelajarRespon,
      Value<String?> summaryNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$AssessmentsTableUpdateCompanionBuilder =
    AssessmentsCompanion Function({
      Value<int> id,
      Value<int?> sessionId,
      Value<int> studentId,
      Value<int?> academicPeriodId,
      Value<String> assessmentType,
      Value<String?> reviewCycleLabel,
      Value<String?> pemahamanMateri,
      Value<String?> keaktifanTanyaJawab,
      Value<String?> ketepatanKerapianTugas,
      Value<String?> konsistensiKehadiranFokus,
      Value<String?> targetMateriDrilling,
      Value<String?> sikapBelajarRespon,
      Value<String?> summaryNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$AssessmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AssessmentsTable, Assessment> {
  $$AssessmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.assessments.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager? get sessionId {
    final $_column = $_itemColumn<int>('session_id');
    if ($_column == null) return null;
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
        $_aliasNameGenerator(db.assessments.studentId, db.students.id),
      );

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.assessments.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager? get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id');
    if ($_column == null) return null;
    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AssessmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewCycleLabel => $composableBuilder(
    column: $table.reviewCycleLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pemahamanMateri => $composableBuilder(
    column: $table.pemahamanMateri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keaktifanTanyaJawab => $composableBuilder(
    column: $table.keaktifanTanyaJawab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ketepatanKerapianTugas => $composableBuilder(
    column: $table.ketepatanKerapianTugas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get konsistensiKehadiranFokus => $composableBuilder(
    column: $table.konsistensiKehadiranFokus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetMateriDrilling => $composableBuilder(
    column: $table.targetMateriDrilling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sikapBelajarRespon => $composableBuilder(
    column: $table.sikapBelajarRespon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryNote => $composableBuilder(
    column: $table.summaryNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssessmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewCycleLabel => $composableBuilder(
    column: $table.reviewCycleLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pemahamanMateri => $composableBuilder(
    column: $table.pemahamanMateri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keaktifanTanyaJawab => $composableBuilder(
    column: $table.keaktifanTanyaJawab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ketepatanKerapianTugas => $composableBuilder(
    column: $table.ketepatanKerapianTugas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get konsistensiKehadiranFokus => $composableBuilder(
    column: $table.konsistensiKehadiranFokus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetMateriDrilling => $composableBuilder(
    column: $table.targetMateriDrilling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sikapBelajarRespon => $composableBuilder(
    column: $table.sikapBelajarRespon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryNote => $composableBuilder(
    column: $table.summaryNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssessmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewCycleLabel => $composableBuilder(
    column: $table.reviewCycleLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pemahamanMateri => $composableBuilder(
    column: $table.pemahamanMateri,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keaktifanTanyaJawab => $composableBuilder(
    column: $table.keaktifanTanyaJawab,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ketepatanKerapianTugas => $composableBuilder(
    column: $table.ketepatanKerapianTugas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get konsistensiKehadiranFokus => $composableBuilder(
    column: $table.konsistensiKehadiranFokus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetMateriDrilling => $composableBuilder(
    column: $table.targetMateriDrilling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sikapBelajarRespon => $composableBuilder(
    column: $table.sikapBelajarRespon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summaryNote => $composableBuilder(
    column: $table.summaryNote,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssessmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssessmentsTable,
          Assessment,
          $$AssessmentsTableFilterComposer,
          $$AssessmentsTableOrderingComposer,
          $$AssessmentsTableAnnotationComposer,
          $$AssessmentsTableCreateCompanionBuilder,
          $$AssessmentsTableUpdateCompanionBuilder,
          (Assessment, $$AssessmentsTableReferences),
          Assessment,
          PrefetchHooks Function({
            bool sessionId,
            bool studentId,
            bool academicPeriodId,
          })
        > {
  $$AssessmentsTableTableManager(_$AppDatabase db, $AssessmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssessmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssessmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> sessionId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> academicPeriodId = const Value.absent(),
                Value<String> assessmentType = const Value.absent(),
                Value<String?> reviewCycleLabel = const Value.absent(),
                Value<String?> pemahamanMateri = const Value.absent(),
                Value<String?> keaktifanTanyaJawab = const Value.absent(),
                Value<String?> ketepatanKerapianTugas = const Value.absent(),
                Value<String?> konsistensiKehadiranFokus = const Value.absent(),
                Value<String?> targetMateriDrilling = const Value.absent(),
                Value<String?> sikapBelajarRespon = const Value.absent(),
                Value<String?> summaryNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => AssessmentsCompanion(
                id: id,
                sessionId: sessionId,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                assessmentType: assessmentType,
                reviewCycleLabel: reviewCycleLabel,
                pemahamanMateri: pemahamanMateri,
                keaktifanTanyaJawab: keaktifanTanyaJawab,
                ketepatanKerapianTugas: ketepatanKerapianTugas,
                konsistensiKehadiranFokus: konsistensiKehadiranFokus,
                targetMateriDrilling: targetMateriDrilling,
                sikapBelajarRespon: sikapBelajarRespon,
                summaryNote: summaryNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> sessionId = const Value.absent(),
                required int studentId,
                Value<int?> academicPeriodId = const Value.absent(),
                Value<String> assessmentType = const Value.absent(),
                Value<String?> reviewCycleLabel = const Value.absent(),
                Value<String?> pemahamanMateri = const Value.absent(),
                Value<String?> keaktifanTanyaJawab = const Value.absent(),
                Value<String?> ketepatanKerapianTugas = const Value.absent(),
                Value<String?> konsistensiKehadiranFokus = const Value.absent(),
                Value<String?> targetMateriDrilling = const Value.absent(),
                Value<String?> sikapBelajarRespon = const Value.absent(),
                Value<String?> summaryNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => AssessmentsCompanion.insert(
                id: id,
                sessionId: sessionId,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                assessmentType: assessmentType,
                reviewCycleLabel: reviewCycleLabel,
                pemahamanMateri: pemahamanMateri,
                keaktifanTanyaJawab: keaktifanTanyaJawab,
                ketepatanKerapianTugas: ketepatanKerapianTugas,
                konsistensiKehadiranFokus: konsistensiKehadiranFokus,
                targetMateriDrilling: targetMateriDrilling,
                sikapBelajarRespon: sikapBelajarRespon,
                summaryNote: summaryNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AssessmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionId = false,
                studentId = false,
                academicPeriodId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable:
                                        $$AssessmentsTableReferences
                                            ._sessionIdTable(db),
                                    referencedColumn:
                                        $$AssessmentsTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable:
                                        $$AssessmentsTableReferences
                                            ._studentIdTable(db),
                                    referencedColumn:
                                        $$AssessmentsTableReferences
                                            ._studentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable:
                                        $$AssessmentsTableReferences
                                            ._academicPeriodIdTable(db),
                                    referencedColumn:
                                        $$AssessmentsTableReferences
                                            ._academicPeriodIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AssessmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssessmentsTable,
      Assessment,
      $$AssessmentsTableFilterComposer,
      $$AssessmentsTableOrderingComposer,
      $$AssessmentsTableAnnotationComposer,
      $$AssessmentsTableCreateCompanionBuilder,
      $$AssessmentsTableUpdateCompanionBuilder,
      (Assessment, $$AssessmentsTableReferences),
      Assessment,
      PrefetchHooks Function({
        bool sessionId,
        bool studentId,
        bool academicPeriodId,
      })
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required int studentId,
      Value<int?> sessionId,
      Value<int?> academicPeriodId,
      Value<String> periodLabel,
      Value<int> amount,
      Value<int> paidAmount,
      Value<String> status,
      Value<DateTime?> dueDate,
      Value<DateTime?> lastRemindedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int?> sessionId,
      Value<int?> academicPeriodId,
      Value<String> periodLabel,
      Value<int> amount,
      Value<int> paidAmount,
      Value<String> status,
      Value<DateTime?> dueDate,
      Value<DateTime?> lastRemindedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) => db.students
      .createAlias($_aliasNameGenerator(db.invoices.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SessionsTable _sessionIdTable(_$AppDatabase db) => db.sessions
      .createAlias($_aliasNameGenerator(db.invoices.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager? get sessionId {
    final $_column = $_itemColumn<int>('session_id');
    if ($_column == null) return null;
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.invoices.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager? get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id');
    if ($_column == null) return null;
    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.payments.invoiceId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool studentId,
            bool sessionId,
            bool academicPeriodId,
            bool paymentsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> sessionId = const Value.absent(),
                Value<int?> academicPeriodId = const Value.absent(),
                Value<String> periodLabel = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> paidAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> lastRemindedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                studentId: studentId,
                sessionId: sessionId,
                academicPeriodId: academicPeriodId,
                periodLabel: periodLabel,
                amount: amount,
                paidAmount: paidAmount,
                status: status,
                dueDate: dueDate,
                lastRemindedAt: lastRemindedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                Value<int?> sessionId = const Value.absent(),
                Value<int?> academicPeriodId = const Value.absent(),
                Value<String> periodLabel = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> paidAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> lastRemindedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                studentId: studentId,
                sessionId: sessionId,
                academicPeriodId: academicPeriodId,
                periodLabel: periodLabel,
                amount: amount,
                paidAmount: paidAmount,
                status: status,
                dueDate: dueDate,
                lastRemindedAt: lastRemindedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studentId = false,
                sessionId = false,
                academicPeriodId = false,
                paymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (paymentsRefs) db.payments],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._studentIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._studentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._sessionIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._academicPeriodIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._academicPeriodIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool studentId,
        bool sessionId,
        bool academicPeriodId,
        bool paymentsRefs,
      })
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int invoiceId,
      Value<int> amount,
      Value<String> method,
      required DateTime paidAt,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> amount,
      Value<String> method,
      Value<DateTime> paidAt,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) => db.invoices
      .createAlias($_aliasNameGenerator(db.payments.invoiceId, db.invoices.id));

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                method: method,
                paidAt: paidAt,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                Value<int> amount = const Value.absent(),
                Value<String> method = const Value.absent(),
                required DateTime paidAt,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                method: method,
                paidAt: paidAt,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$PaymentsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$ProgressReportsTableCreateCompanionBuilder =
    ProgressReportsCompanion Function({
      Value<int> id,
      required int studentId,
      required int academicPeriodId,
      Value<String> reportType,
      Value<DateTime> generatedAt,
      Value<String> attendanceSummaryJson,
      Value<String> assessmentSummaryJson,
      Value<String?> teacherNote,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$ProgressReportsTableUpdateCompanionBuilder =
    ProgressReportsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> academicPeriodId,
      Value<String> reportType,
      Value<DateTime> generatedAt,
      Value<String> attendanceSummaryJson,
      Value<String> assessmentSummaryJson,
      Value<String?> teacherNote,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

final class $$ProgressReportsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProgressReportsTable, ProgressReport> {
  $$ProgressReportsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias(
        $_aliasNameGenerator(db.progressReports.studentId, db.students.id),
      );

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AcademicPeriodsTable _academicPeriodIdTable(_$AppDatabase db) =>
      db.academicPeriods.createAlias(
        $_aliasNameGenerator(
          db.progressReports.academicPeriodId,
          db.academicPeriods.id,
        ),
      );

  $$AcademicPeriodsTableProcessedTableManager get academicPeriodId {
    final $_column = $_itemColumn<int>('academic_period_id')!;

    final manager = $$AcademicPeriodsTableTableManager(
      $_db,
      $_db.academicPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_academicPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProgressReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressReportsTable> {
  $$ProgressReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attendanceSummaryJson => $composableBuilder(
    column: $table.attendanceSummaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessmentSummaryJson => $composableBuilder(
    column: $table.assessmentSummaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherNote => $composableBuilder(
    column: $table.teacherNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableFilterComposer get academicPeriodId {
    final $$AcademicPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressReportsTable> {
  $$ProgressReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendanceSummaryJson => $composableBuilder(
    column: $table.attendanceSummaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessmentSummaryJson => $composableBuilder(
    column: $table.assessmentSummaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherNote => $composableBuilder(
    column: $table.teacherNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableOrderingComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableOrderingComposer get academicPeriodId {
    final $$AcademicPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressReportsTable> {
  $$ProgressReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attendanceSummaryJson => $composableBuilder(
    column: $table.attendanceSummaryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assessmentSummaryJson => $composableBuilder(
    column: $table.assessmentSummaryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get teacherNote => $composableBuilder(
    column: $table.teacherNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AcademicPeriodsTableAnnotationComposer get academicPeriodId {
    final $$AcademicPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.academicPeriodId,
      referencedTable: $db.academicPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AcademicPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.academicPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProgressReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressReportsTable,
          ProgressReport,
          $$ProgressReportsTableFilterComposer,
          $$ProgressReportsTableOrderingComposer,
          $$ProgressReportsTableAnnotationComposer,
          $$ProgressReportsTableCreateCompanionBuilder,
          $$ProgressReportsTableUpdateCompanionBuilder,
          (ProgressReport, $$ProgressReportsTableReferences),
          ProgressReport,
          PrefetchHooks Function({bool studentId, bool academicPeriodId})
        > {
  $$ProgressReportsTableTableManager(
    _$AppDatabase db,
    $ProgressReportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> academicPeriodId = const Value.absent(),
                Value<String> reportType = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> attendanceSummaryJson = const Value.absent(),
                Value<String> assessmentSummaryJson = const Value.absent(),
                Value<String?> teacherNote = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => ProgressReportsCompanion(
                id: id,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                reportType: reportType,
                generatedAt: generatedAt,
                attendanceSummaryJson: attendanceSummaryJson,
                assessmentSummaryJson: assessmentSummaryJson,
                teacherNote: teacherNote,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int academicPeriodId,
                Value<String> reportType = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> attendanceSummaryJson = const Value.absent(),
                Value<String> assessmentSummaryJson = const Value.absent(),
                Value<String?> teacherNote = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => ProgressReportsCompanion.insert(
                id: id,
                studentId: studentId,
                academicPeriodId: academicPeriodId,
                reportType: reportType,
                generatedAt: generatedAt,
                attendanceSummaryJson: attendanceSummaryJson,
                assessmentSummaryJson: assessmentSummaryJson,
                teacherNote: teacherNote,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgressReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studentId = false, academicPeriodId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (studentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.studentId,
                                    referencedTable:
                                        $$ProgressReportsTableReferences
                                            ._studentIdTable(db),
                                    referencedColumn:
                                        $$ProgressReportsTableReferences
                                            ._studentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (academicPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.academicPeriodId,
                                    referencedTable:
                                        $$ProgressReportsTableReferences
                                            ._academicPeriodIdTable(db),
                                    referencedColumn:
                                        $$ProgressReportsTableReferences
                                            ._academicPeriodIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ProgressReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressReportsTable,
      ProgressReport,
      $$ProgressReportsTableFilterComposer,
      $$ProgressReportsTableOrderingComposer,
      $$ProgressReportsTableAnnotationComposer,
      $$ProgressReportsTableCreateCompanionBuilder,
      $$ProgressReportsTableUpdateCompanionBuilder,
      (ProgressReport, $$ProgressReportsTableReferences),
      ProgressReport,
      PrefetchHooks Function({bool studentId, bool academicPeriodId})
    >;
typedef $$ReminderRulesTableCreateCompanionBuilder =
    ReminderRulesCompanion Function({
      Value<int> id,
      Value<String> reminderType,
      Value<int?> offsetMinutes,
      Value<int?> daysBeforeDue,
      Value<bool> isEnabled,
      Value<String> channel,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ReminderRulesTableUpdateCompanionBuilder =
    ReminderRulesCompanion Function({
      Value<int> id,
      Value<String> reminderType,
      Value<int?> offsetMinutes,
      Value<int?> daysBeforeDue,
      Value<bool> isEnabled,
      Value<String> channel,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ReminderRulesTableReferences
    extends BaseReferences<_$AppDatabase, $ReminderRulesTable, ReminderRule> {
  $$ReminderRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ReminderLogsTable, List<ReminderLog>>
  _reminderLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminderLogs,
    aliasName: $_aliasNameGenerator(
      db.reminderRules.id,
      db.reminderLogs.reminderRuleId,
    ),
  );

  $$ReminderLogsTableProcessedTableManager get reminderLogsRefs {
    final manager = $$ReminderLogsTableTableManager(
      $_db,
      $_db.reminderLogs,
    ).filter((f) => f.reminderRuleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reminderLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReminderRulesTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysBeforeDue => $composableBuilder(
    column: $table.daysBeforeDue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reminderLogsRefs(
    Expression<bool> Function($$ReminderLogsTableFilterComposer f) f,
  ) {
    final $$ReminderLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderLogs,
      getReferencedColumn: (t) => t.reminderRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderLogsTableFilterComposer(
            $db: $db,
            $table: $db.reminderLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReminderRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysBeforeDue => $composableBuilder(
    column: $table.daysBeforeDue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderRulesTable> {
  $$ReminderRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get daysBeforeDue => $composableBuilder(
    column: $table.daysBeforeDue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> reminderLogsRefs<T extends Object>(
    Expression<T> Function($$ReminderLogsTableAnnotationComposer a) f,
  ) {
    final $$ReminderLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderLogs,
      getReferencedColumn: (t) => t.reminderRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.reminderLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReminderRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderRulesTable,
          ReminderRule,
          $$ReminderRulesTableFilterComposer,
          $$ReminderRulesTableOrderingComposer,
          $$ReminderRulesTableAnnotationComposer,
          $$ReminderRulesTableCreateCompanionBuilder,
          $$ReminderRulesTableUpdateCompanionBuilder,
          (ReminderRule, $$ReminderRulesTableReferences),
          ReminderRule,
          PrefetchHooks Function({bool reminderLogsRefs})
        > {
  $$ReminderRulesTableTableManager(_$AppDatabase db, $ReminderRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<int?> offsetMinutes = const Value.absent(),
                Value<int?> daysBeforeDue = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReminderRulesCompanion(
                id: id,
                reminderType: reminderType,
                offsetMinutes: offsetMinutes,
                daysBeforeDue: daysBeforeDue,
                isEnabled: isEnabled,
                channel: channel,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<int?> offsetMinutes = const Value.absent(),
                Value<int?> daysBeforeDue = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReminderRulesCompanion.insert(
                id: id,
                reminderType: reminderType,
                offsetMinutes: offsetMinutes,
                daysBeforeDue: daysBeforeDue,
                isEnabled: isEnabled,
                channel: channel,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReminderRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (reminderLogsRefs) db.reminderLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reminderLogsRefs)
                    await $_getPrefetchedData<
                      ReminderRule,
                      $ReminderRulesTable,
                      ReminderLog
                    >(
                      currentTable: table,
                      referencedTable: $$ReminderRulesTableReferences
                          ._reminderLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ReminderRulesTableReferences(
                            db,
                            table,
                            p0,
                          ).reminderLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.reminderRuleId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReminderRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderRulesTable,
      ReminderRule,
      $$ReminderRulesTableFilterComposer,
      $$ReminderRulesTableOrderingComposer,
      $$ReminderRulesTableAnnotationComposer,
      $$ReminderRulesTableCreateCompanionBuilder,
      $$ReminderRulesTableUpdateCompanionBuilder,
      (ReminderRule, $$ReminderRulesTableReferences),
      ReminderRule,
      PrefetchHooks Function({bool reminderLogsRefs})
    >;
typedef $$ReminderLogsTableCreateCompanionBuilder =
    ReminderLogsCompanion Function({
      Value<int> id,
      Value<int?> reminderRuleId,
      Value<String> reminderType,
      required String referenceTable,
      required int referenceId,
      required DateTime scheduledAt,
      Value<DateTime?> triggeredAt,
      Value<String> status,
      Value<String?> payloadJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ReminderLogsTableUpdateCompanionBuilder =
    ReminderLogsCompanion Function({
      Value<int> id,
      Value<int?> reminderRuleId,
      Value<String> reminderType,
      Value<String> referenceTable,
      Value<int> referenceId,
      Value<DateTime> scheduledAt,
      Value<DateTime?> triggeredAt,
      Value<String> status,
      Value<String?> payloadJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ReminderLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ReminderLogsTable, ReminderLog> {
  $$ReminderLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReminderRulesTable _reminderRuleIdTable(_$AppDatabase db) =>
      db.reminderRules.createAlias(
        $_aliasNameGenerator(
          db.reminderLogs.reminderRuleId,
          db.reminderRules.id,
        ),
      );

  $$ReminderRulesTableProcessedTableManager? get reminderRuleId {
    final $_column = $_itemColumn<int>('reminder_rule_id');
    if ($_column == null) return null;
    final manager = $$ReminderRulesTableTableManager(
      $_db,
      $_db.reminderRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reminderRuleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReminderLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderLogsTable> {
  $$ReminderLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceTable => $composableBuilder(
    column: $table.referenceTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ReminderRulesTableFilterComposer get reminderRuleId {
    final $$ReminderRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderRuleId,
      referencedTable: $db.reminderRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderRulesTableFilterComposer(
            $db: $db,
            $table: $db.reminderRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderLogsTable> {
  $$ReminderLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceTable => $composableBuilder(
    column: $table.referenceTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReminderRulesTableOrderingComposer get reminderRuleId {
    final $$ReminderRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderRuleId,
      referencedTable: $db.reminderRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderRulesTableOrderingComposer(
            $db: $db,
            $table: $db.reminderRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderLogsTable> {
  $$ReminderLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceTable => $composableBuilder(
    column: $table.referenceTable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get triggeredAt => $composableBuilder(
    column: $table.triggeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ReminderRulesTableAnnotationComposer get reminderRuleId {
    final $$ReminderRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderRuleId,
      referencedTable: $db.reminderRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.reminderRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderLogsTable,
          ReminderLog,
          $$ReminderLogsTableFilterComposer,
          $$ReminderLogsTableOrderingComposer,
          $$ReminderLogsTableAnnotationComposer,
          $$ReminderLogsTableCreateCompanionBuilder,
          $$ReminderLogsTableUpdateCompanionBuilder,
          (ReminderLog, $$ReminderLogsTableReferences),
          ReminderLog,
          PrefetchHooks Function({bool reminderRuleId})
        > {
  $$ReminderLogsTableTableManager(_$AppDatabase db, $ReminderLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> reminderRuleId = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<String> referenceTable = const Value.absent(),
                Value<int> referenceId = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime?> triggeredAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReminderLogsCompanion(
                id: id,
                reminderRuleId: reminderRuleId,
                reminderType: reminderType,
                referenceTable: referenceTable,
                referenceId: referenceId,
                scheduledAt: scheduledAt,
                triggeredAt: triggeredAt,
                status: status,
                payloadJson: payloadJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> reminderRuleId = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                required String referenceTable,
                required int referenceId,
                required DateTime scheduledAt,
                Value<DateTime?> triggeredAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReminderLogsCompanion.insert(
                id: id,
                reminderRuleId: reminderRuleId,
                reminderType: reminderType,
                referenceTable: referenceTable,
                referenceId: referenceId,
                scheduledAt: scheduledAt,
                triggeredAt: triggeredAt,
                status: status,
                payloadJson: payloadJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReminderLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderRuleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reminderRuleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reminderRuleId,
                                referencedTable: $$ReminderLogsTableReferences
                                    ._reminderRuleIdTable(db),
                                referencedColumn: $$ReminderLogsTableReferences
                                    ._reminderRuleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReminderLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderLogsTable,
      ReminderLog,
      $$ReminderLogsTableFilterComposer,
      $$ReminderLogsTableOrderingComposer,
      $$ReminderLogsTableAnnotationComposer,
      $$ReminderLogsTableCreateCompanionBuilder,
      $$ReminderLogsTableUpdateCompanionBuilder,
      (ReminderLog, $$ReminderLogsTableReferences),
      ReminderLog,
      PrefetchHooks Function({bool reminderRuleId})
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$BackupMetadataTableCreateCompanionBuilder =
    BackupMetadataCompanion Function({
      Value<int> id,
      required String fileName,
      required String filePath,
      Value<DateTime> createdAt,
    });
typedef $$BackupMetadataTableUpdateCompanionBuilder =
    BackupMetadataCompanion Function({
      Value<int> id,
      Value<String> fileName,
      Value<String> filePath,
      Value<DateTime> createdAt,
    });

class $$BackupMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BackupMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupMetadataTable,
          BackupMetadataData,
          $$BackupMetadataTableFilterComposer,
          $$BackupMetadataTableOrderingComposer,
          $$BackupMetadataTableAnnotationComposer,
          $$BackupMetadataTableCreateCompanionBuilder,
          $$BackupMetadataTableUpdateCompanionBuilder,
          (
            BackupMetadataData,
            BaseReferences<
              _$AppDatabase,
              $BackupMetadataTable,
              BackupMetadataData
            >,
          ),
          BackupMetadataData,
          PrefetchHooks Function()
        > {
  $$BackupMetadataTableTableManager(
    _$AppDatabase db,
    $BackupMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BackupMetadataCompanion(
                id: id,
                fileName: fileName,
                filePath: filePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fileName,
                required String filePath,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BackupMetadataCompanion.insert(
                id: id,
                fileName: fileName,
                filePath: filePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupMetadataTable,
      BackupMetadataData,
      $$BackupMetadataTableFilterComposer,
      $$BackupMetadataTableOrderingComposer,
      $$BackupMetadataTableAnnotationComposer,
      $$BackupMetadataTableCreateCompanionBuilder,
      $$BackupMetadataTableUpdateCompanionBuilder,
      (
        BackupMetadataData,
        BaseReferences<_$AppDatabase, $BackupMetadataTable, BackupMetadataData>,
      ),
      BackupMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$AcademicPeriodsTableTableManager get academicPeriods =>
      $$AcademicPeriodsTableTableManager(_db, _db.academicPeriods);
  $$StudentPeriodsTableTableManager get studentPeriods =>
      $$StudentPeriodsTableTableManager(_db, _db.studentPeriods);
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$AssessmentsTableTableManager get assessments =>
      $$AssessmentsTableTableManager(_db, _db.assessments);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ProgressReportsTableTableManager get progressReports =>
      $$ProgressReportsTableTableManager(_db, _db.progressReports);
  $$ReminderRulesTableTableManager get reminderRules =>
      $$ReminderRulesTableTableManager(_db, _db.reminderRules);
  $$ReminderLogsTableTableManager get reminderLogs =>
      $$ReminderLogsTableTableManager(_db, _db.reminderLogs);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$BackupMetadataTableTableManager get backupMetadata =>
      $$BackupMetadataTableTableManager(_db, _db.backupMetadata);
}
