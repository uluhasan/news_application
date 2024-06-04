import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/config/theme/app_themes.dart';
import 'package:news_application/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_application/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_application/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_application/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: const DailyNews(),
      ),
    );
  }
}
