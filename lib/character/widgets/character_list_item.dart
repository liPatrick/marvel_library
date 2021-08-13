import 'package:flutter/material.dart';
import 'package:marvel_library/character/character.dart';
import 'package:marvel_library/character_details/character_details.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({Key? key, required this.post}) : super(key: key);

  final Character post;

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        //leading: Text('${post.id}', style: textTheme.caption),
        title: Text(post.name),
        isThreeLine: true,
        subtitle: Text(post.id.toString()),
        dense: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CharacterDetailsPage(id: post.id.toString())),
        ),
      ),
    );
  }
}
