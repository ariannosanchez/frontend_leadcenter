import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/features/shared/shared.dart';
import 'package:lead_center/features/tag_categories/presentation/providers/providers.dart';
import 'package:lead_center/features/tags/domain/domain.dart';
import 'package:lead_center/features/tags/presentation/providers/providers.dart';

class TagScreen extends ConsumerWidget {

  final int tagId;

  const TagScreen({super.key, required this.tagId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tagState = ref.watch( tagProvider(tagId) );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tag'),
      ),

      body: tagState.isLoading
        ? const FullScreenLoader()
        : _TagView( tag: tagState.tag! ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon((Icons.save_as_outlined)),  
      ),
    );
  }
}

class _TagView extends StatelessWidget {

  final Tag tag;

  const _TagView({required this.tag});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

          const SizedBox( height: 10 ),
          Center(child: Text( tag.name, style: textStyles.titleSmall )),
          const SizedBox( height: 10 ),
          _TagInformation( tag: tag ),
          
        ],
    );
  }
}

class _TagInformation extends ConsumerWidget {
  final Tag tag;
  const _TagInformation({required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final tagCategories = ref.watch( tagCategoriesProvider );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomTagField( 
            label: 'Nombre',
            initialValue: tag.name,
          ),

          const SizedBox(height: 15 ),

          CustomDropdownButtonField(
            label: 'Categoría',
            value: tag.tagCategory.id,
            items: tagCategories.tagCategories.map(
              (tagCategory) => DropdownMenuItem(
                value: tagCategory.id,
                child: Text(tagCategory.name, style: const TextStyle( fontSize: 15, fontWeight: FontWeight.normal ) ),
              )).toList(),
            onChanged: ( value ) {
              print(value);
            },
          ),
      
          // DropdownButtonFormField(
          //   style: const TextStyle( fontSize: 15, color: Colors.black54 ),

          //   value: tag.tagCategory.id,
          //   items: tagCategories.tagCategories.map(
          //     (tagCategory) => DropdownMenuItem(
          //       value: tagCategory.id,
          //       child: Text(tagCategory.name, style: const TextStyle( fontSize: 15, fontWeight: FontWeight.normal ) ),
          //     )).toList(), 
          //   onChanged: ( value ) {
          //     print(value);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_drop_down_circle_outlined
          //   ),
          //   decoration: InputDecoration(
          //     labelText: 'Categoría',
          //     isDense: true,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(40),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}


class _DropDown extends StatelessWidget {

  const _DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class _SizeSelector extends StatelessWidget {
  final List<String> selectedSizes;
  final List<String> sizes = const['XS','S','M','L','XL','XXL','XXXL'];

  const _SizeSelector({required this.selectedSizes});


  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
          value: size, 
          label: Text(size, style: const TextStyle(fontSize: 10))
        );
      }).toList(), 
      selected: Set.from( selectedSizes ),
      onSelectionChanged: (newSelection) {
        print(newSelection);
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selectedGender;
  final List<String> genders = const['men','women','kid'];
  final List<IconData> genderIcons = const[
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];

  const _GenderSelector({required this.selectedGender});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact ),
        segments: genders.map((size) {
          return ButtonSegment(
            icon: Icon( genderIcons[ genders.indexOf(size) ] ),
            value: size, 
            label: Text(size, style: const TextStyle(fontSize: 12))
          );
        }).toList(), 
        selected: { selectedGender },
        onSelectionChanged: (newSelection) {
          print(newSelection);
        },
      ),
    );
  }
}
