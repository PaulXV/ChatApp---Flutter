import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0.0,
      ),
      drawer: MyDrawer(),
      body: _buildUsersList(),
    );
  }

  // buid users list
  Widget _buildUsersList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userdata) => _buildUserListItem(userdata, context)).toList(),
        );
      },
    );
  }

  // build user list item
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    
    if(userData['email'] != _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData['email'],
        onTap: ()  {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverID: userData['uid'],
                )
              )
            );
        },
      );
    }
    
    else{
      return Container();
    }
  }

}