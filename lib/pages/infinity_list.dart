import 'package:flutter/material.dart';
import 'package:studying_bloc_pattern/pages/common/app_background.dart';
import 'package:studying_bloc_pattern/pages/common/bottom_loader.dart';
import 'package:studying_bloc_pattern/pages/common/post_widget.dart';
import '../bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class InfinityList extends StatefulWidget {
  @override
  _InfinityListState createState() => _InfinityListState();
}

class _InfinityListState extends State<InfinityList> {
  
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;

  _InfinityListState(){
    _scrollController.addListener(_onScroll);
    _postBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: BlocBuilder(
              bloc: _postBloc,
              builder: (BuildContext context, PostState state){

                if(state is PostUninitialized) return Center(child: CircularProgressIndicator(),);

                if(state is PostError) return Center(child: Text('failed to fetch posts'),);

                if(state is PostLoaded)
                {
                  if(state.posts.isEmpty) return Center(child: Text('No post!'),);

                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, idx){
                      return idx >= state.posts.length ? BottomLoader() : PostWidget(post: state.posts[idx]);
                    },
                    itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _onScroll() {
    print("_onScroll");
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if(maxScroll - currentScroll <= _scrollThreshold)
    {
      _postBloc.dispatch(Fetch());
    }
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }
}