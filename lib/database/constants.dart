class PersonFields {
  static const String tableName = 'persons';
  static const String id = '_id';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String birthDate = 'birth_date';
  static const String address = 'address';
  static const String userGroups = 'user_groups';

  static final List<String> values = [
    id, firstName, lastName, birthDate, address, userGroups,
  ];

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
}

class GroupFields {
  static const String tableName = 'groups';
  static const String id = '_id';
  static const String name = 'name';
  static const String persons = 'persons';

  static final List<String> values = [
    id, name, persons,
  ];

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
}