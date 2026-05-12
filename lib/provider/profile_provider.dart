import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/db_helper.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> _profiles = [];

  List<Profile> get profiles => _profiles;

  Future<void> fetchProfiles() async {
    try {
      _profiles = await DbHelper.getProfiles();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching profiles: $e');
    }
  }

  Future<void> addProfile(Profile newProfile) async {
    try {
      final int insertedId = await DbHelper.insertProfile(newProfile);
      final updatedProfile = newProfile.copywith(id: insertedId);
      _profiles.add(updatedProfile);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding: $e");
    }
  }

  Future<void> updateProfile(int id, Profile profile) async {
    final db = await DbHelper.database;
    await db.update(
      'tb_profile',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchProfiles();
  }

  Future<void> deleteProfile(int id) async {
    final db = await DbHelper.database;
    await db.delete('tb_profile', where: 'id = ?', whereArgs: [id]);
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Profile getProfileById(int id) {
    return _profiles.firstWhere((profile) => profile.id == id);
  }
}
