// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ludzie`
  String get people {
    return Intl.message(
      'Ludzie',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Grupy`
  String get groups {
    return Intl.message(
      'Grupy',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get error_occured {
    return Intl.message(
      'Wystąpił błąd',
      name: 'error_occured',
      desc: '',
      args: [],
    );
  }

  /// `Dodaj osobę`
  String get add_person {
    return Intl.message(
      'Dodaj osobę',
      name: 'add_person',
      desc: '',
      args: [],
    );
  }

  /// `Dodaj grupę`
  String get add_group {
    return Intl.message(
      'Dodaj grupę',
      name: 'add_group',
      desc: '',
      args: [],
    );
  }

  /// `Liczba osób:`
  String get amount_of_people {
    return Intl.message(
      'Liczba osób:',
      name: 'amount_of_people',
      desc: '',
      args: [],
    );
  }

  /// `Nie udało się pobrać danych`
  String get api_error {
    return Intl.message(
      'Nie udało się pobrać danych',
      name: 'api_error',
      desc: '',
      args: [],
    );
  }

  /// `Utwórz osobę`
  String get create_person {
    return Intl.message(
      'Utwórz osobę',
      name: 'create_person',
      desc: '',
      args: [],
    );
  }

  /// `Utwórz grupę`
  String get create_group {
    return Intl.message(
      'Utwórz grupę',
      name: 'create_group',
      desc: '',
      args: [],
    );
  }

  /// `Imię`
  String get name {
    return Intl.message(
      'Imię',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Nazwisko`
  String get surname {
    return Intl.message(
      'Nazwisko',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Podaj imię`
  String get enter_name {
    return Intl.message(
      'Podaj imię',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Podaj nazwisko`
  String get enter_surname {
    return Intl.message(
      'Podaj nazwisko',
      name: 'enter_surname',
      desc: '',
      args: [],
    );
  }

  /// `Data urodzenia`
  String get date_of_birth {
    return Intl.message(
      'Data urodzenia',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Wpisz kod pocztowy/miasto`
  String get address {
    return Intl.message(
      'Wpisz kod pocztowy/miasto',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Uworzono nową osobę`
  String get add_person_success {
    return Intl.message(
      'Uworzono nową osobę',
      name: 'add_person_success',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get add_person_failure {
    return Intl.message(
      'Wystąpił błąd',
      name: 'add_person_failure',
      desc: '',
      args: [],
    );
  }

  /// `Uworzono nową grupę`
  String get add_group_success {
    return Intl.message(
      'Uworzono nową grupę',
      name: 'add_group_success',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get add_group_failure {
    return Intl.message(
      'Wystąpił błąd',
      name: 'add_group_failure',
      desc: '',
      args: [],
    );
  }

  /// `Nazwa grupy`
  String get group_name {
    return Intl.message(
      'Nazwa grupy',
      name: 'group_name',
      desc: '',
      args: [],
    );
  }

  /// `Usuń grupę`
  String get delete_group {
    return Intl.message(
      'Usuń grupę',
      name: 'delete_group',
      desc: '',
      args: [],
    );
  }

  /// `Usuń`
  String get delete {
    return Intl.message(
      'Usuń',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Anuluj`
  String get cancel {
    return Intl.message(
      'Anuluj',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Jesteś pewny że chcesz usunąć tą grupę?`
  String get dialog_group_desc {
    return Intl.message(
      'Jesteś pewny że chcesz usunąć tą grupę?',
      name: 'dialog_group_desc',
      desc: '',
      args: [],
    );
  }

  /// `Aktualizuj grupę`
  String get update_group {
    return Intl.message(
      'Aktualizuj grupę',
      name: 'update_group',
      desc: '',
      args: [],
    );
  }

  /// `Zaktualizowano grupę`
  String get edit_group_success {
    return Intl.message(
      'Zaktualizowano grupę',
      name: 'edit_group_success',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get edit_group_failure {
    return Intl.message(
      'Wystąpił błąd',
      name: 'edit_group_failure',
      desc: '',
      args: [],
    );
  }

  /// `Edytowanie grupy`
  String get edit_group {
    return Intl.message(
      'Edytowanie grupy',
      name: 'edit_group',
      desc: '',
      args: [],
    );
  }

  /// `Edytowanie osoby`
  String get edit_person {
    return Intl.message(
      'Edytowanie osoby',
      name: 'edit_person',
      desc: '',
      args: [],
    );
  }

  /// `Zaktualizowano osobę`
  String get edit_person_success {
    return Intl.message(
      'Zaktualizowano osobę',
      name: 'edit_person_success',
      desc: '',
      args: [],
    );
  }

  /// `Wystąpił błąd`
  String get edit_person_failure {
    return Intl.message(
      'Wystąpił błąd',
      name: 'edit_person_failure',
      desc: '',
      args: [],
    );
  }

  /// `Edytuj osobę`
  String get update_person {
    return Intl.message(
      'Edytuj osobę',
      name: 'update_person',
      desc: '',
      args: [],
    );
  }

  /// `Czy na pewno chcesz usunąć osobę?`
  String get dialog_person_desc {
    return Intl.message(
      'Czy na pewno chcesz usunąć osobę?',
      name: 'dialog_person_desc',
      desc: '',
      args: [],
    );
  }

  /// `Usuń osobę`
  String get delete_person {
    return Intl.message(
      'Usuń osobę',
      name: 'delete_person',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pl', countryCode: 'PL'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
