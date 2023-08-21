import 'package:clean_articals/core/util/NetworkConnectivity/cubit/network_connectivity_cubit.dart';
import 'package:clean_articals/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:clean_articals/features/daily_news/presentation/bloc/article/remote/report_article_bloc.dart';
import 'package:clean_articals/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<NetworkConnectivityCubit, NetworkConnectivityState>(
        builder: (context, state) {
          if (state is NetworkConnectivityInitial) {
            return const Center(child: Text("No Internet Connection!"));
          } else if (state is NetworkConnectivityFailed) {
            return Center(child: Text(state.error!));
          } else {
            return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
              builder: (context, state) {
                return _buildBody(state);
              },
            );
          }
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: const Text(
      'Daily news',
      style: TextStyle(color: Colors.black),
    ));
  }

  _buildBody(RemoteArticleState state) {
    if (state is RemoteArticlesLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    if (state is RemoteArticlesError) {
      return const Center(child: Icon(Icons.refresh));
    }
    if (state is RemoteArticlesDone) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ArticleTile(
            article: state.articles![index],
          );
        },
        itemCount: state.articles!.length,
      );
    }
    return const SizedBox();
  }
}
