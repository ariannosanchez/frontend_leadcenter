import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({ 
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[

  MenuItem(
    title: 'Leads', 
    subTitle: 'Listado de Leads', 
    link: '/', 
    icon: Icons.connect_without_contact_outlined
  ),

  MenuItem(
    title: 'Etiquetas', 
    subTitle: 'Listado de categorias', 
    link: '/tags', 
    icon: Icons.local_offer_outlined
  ),

  MenuItem(
    title: 'Estados', 
    subTitle: 'Listado de estados', 
    link: '/stages', 
    icon: Icons.view_timeline_outlined
  ),

  MenuItem(
    title: 'Categoria de etiquetas', 
    subTitle: 'Listado de estados', 
    link: '/tag_categories', 
    icon: Icons.settings
  ),

  MenuItem(
    title: 'Categoria de estados', 
    subTitle: 'Listado de estados', 
    link: '/stage_categories', 
    icon: Icons.settings
  ),

  MenuItem(
    title: 'Embudo',
    subTitle: 'Embudo de ventas',
    link: '/funnel',
    icon: Icons.bar_chart_outlined
  ),

  MenuItem(
    title: 'Cambiar tema', 
    subTitle: 'Cambiar tema de la aplicación', 
    link: '/theme-changer', 
    icon: Icons.color_lens_outlined
  )

];

