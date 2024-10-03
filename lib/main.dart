import 'package:clean_architecture/core/shared/app_theme.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/bloc_posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/classes/bloc_observer.dart';
import 'features/posts/presentation/bloc/bloc_add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presentation/screens/posts_screen/posts_screen.dart';
import 'package:clean_architecture/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await di.init();
  Bloc.observer = MyBlocObserver();

  runApp(const PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Posts Application',
        home: const PostsScreen(),
      ),
    );
  }
}
