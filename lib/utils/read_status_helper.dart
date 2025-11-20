

import 'package:shared_preferences/shared_preferences.dart';

class ReadStatusHelper {
  static const String key = "read_posts";

  static Future<void> markAsRead(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    final readPosts = prefs.getStringList(key) ?? [];
    if (!readPosts.contains(postId.toString())) {
      readPosts.add(postId.toString());
      await prefs.setStringList(key, readPosts);
    }
  }

  static Future<bool> isRead(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    final readPosts = prefs.getStringList(key) ?? [];
    return readPosts.contains(postId.toString());
  }
}
