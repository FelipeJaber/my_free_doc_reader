import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPage.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPageBLoC.dart';
import 'package:my_free_doc_reader/pages/text_page/TextPage.dart';
import 'package:my_free_doc_reader/pages/text_page/TextPageBLoC.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (_) => MainPageBLoC(),
        child: MainPage(),
      ),
    ),
    GoRoute(
      path: '/textpage',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => TextPageBLoC(),
          child: TextPage(state.extra as String),
        );
      },
    ),
  ],
);
