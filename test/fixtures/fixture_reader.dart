import 'dart:io';

String fixtureReader(String name) =>
    File('test/fixtures/$name').readAsStringSync();