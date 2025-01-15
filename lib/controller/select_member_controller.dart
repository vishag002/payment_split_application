import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//   First, let's create a Member model
class Member {
  final String name;
  final String id;

  Member({required this.name})
      : id = DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(name: json['name']);
  }
}

// Create the state notifier
class AddMemberControllerNotifier extends StateNotifier<List<Member>> {
  AddMemberControllerNotifier() : super([]);

  Future<void> addMember(String name) async {
    state = [...state, Member(name: name)];
    await saveMember();
  }

  Future<void> removeMember(String id) async {
    state = state.where((member) => member.id != id).toList();
    await saveMember();
  }

  Future<void> saveMember() async {
    final prefs = await SharedPreferences.getInstance();
    final membersList = state.map((member) => member.toJson()).toList();
    await prefs.setString('members', membersList.toString());
  }

  Future<void> loadMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final membersString = prefs.getString('members');
    if (membersString != null) {
      final membersList =
          List<Map<String, dynamic>>.from(membersString as List);
      state = membersList.map((json) => Member.fromJson(json)).toList();
    }
  }
}

// Create the provider
final membersProvider =
    StateNotifierProvider<AddMemberControllerNotifier, List<Member>>(
  (ref) {
    return AddMemberControllerNotifier();
  },
);
