import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagCategoryScreen extends ConsumerStatefulWidget {
  
  final String tagCategoryId;
  
  const TagCategoryScreen({ super.key, required this.tagCategoryId });

  @override
  TagCategoryScreenState createState() => TagCategoryScreenState();
}

class TagCategoryScreenState extends ConsumerState<TagCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar categoria de etiqueta'),
      ),
      body: SizedBox(
        width: 250,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Hola Mundo',
          ),
        ),
      ),
    );
  }
}