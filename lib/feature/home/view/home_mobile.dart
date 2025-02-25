import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talentpitch_test/app/routes/routes_names.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: AppColors.white,
              size: 32,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.white,
              size: 32,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: AppColors.white,
              size: 32,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: (value) {
          value != 0 ? context.go(RoutesNames.playlist) : context.go(RoutesNames.home);
          context.read<VideoBloc>().add(PlayListVideosEvent());
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Playlist')
        ],
      ),
    );
  }
}
