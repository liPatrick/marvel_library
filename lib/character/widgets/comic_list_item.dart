import 'package:flutter/material.dart';
import 'package:marvel_library/character/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicListItem extends StatelessWidget {
  const ComicListItem({Key? key, required this.post}) : super(key: key);

  final Comic post;

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        //leading: Text('${post.id}', style: textTheme.caption),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(
            post.description != null ? post.description.toString() : 'N/A'),
        dense: true,
      ),
    );
  }
}
