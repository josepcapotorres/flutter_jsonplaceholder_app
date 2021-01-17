import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/views/album_photos_view.dart';
import 'package:jsonplaceholder_app/views/login_view.dart';
import 'package:jsonplaceholder_app/views/post_comments_view.dart';
import 'package:jsonplaceholder_app/views/user_albums_view.dart';
import 'package:jsonplaceholder_app/views/user_details_view.dart';
import 'package:jsonplaceholder_app/views/user_posts_view.dart';
import 'package:jsonplaceholder_app/views/user_todos_view.dart';
import 'package:jsonplaceholder_app/views/users_view.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    UsersView.routeName: (_) => UsersView(),
    LoginView.routeName: (_) => LoginView(),
    UserDetailsView.routeName: (_) => UserDetailsView(),
    UserPostsView.routeName: (_) => UserPostsView(),
    UserAlbumsView.routeName: (_) => UserAlbumsView(),
    PostCommentsView.routeName: (_) => PostCommentsView(),
    AlbumPhotosView.routeName: (_) => AlbumPhotosView(),
    UserTodosView.routeName: (_) => UserTodosView(),
  };
}
