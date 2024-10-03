import 'package:clean_architecture/core/classes/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/repositories/posts_repository_imp.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/bloc_add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/bloc_posts/posts_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/classes/crud_dio.dart';
import 'features/posts/data/datasources/posts_remote_data_source.dart';
import 'features/posts/domain/repositories/posts_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! features - posts
  // BLoC
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
        addPostUsecase: sl(),
        updatePostUsecase: sl(),
        deletePostUsecase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImp(
        postsRemoteDataSource: sl(),
        postsLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImp(dio: sl()),
  );
  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImp(sharedPreferences: sl()),
  );

  //! Core

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(internetConnectionChecker: sl()),
  );
  sl.registerLazySingleton(() => CrudDio());

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
