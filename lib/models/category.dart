// import 'package:flutter/material.dart';
// import 'package:pet_health_app/assets/colors.dart';
// import 'package:pet_health_app/models/scopemodel.dart';
// import 'package:scoped_model/scoped_model.dart';

// class CategoryIcon extends StatelessWidget {
//   // different from the guidence in github
//   final String iconText;
//   final IconData icon;
//   final int value;
//   MyScopeModel model = MyScopeModel();
//   CategoryIcon(this.icon, this.iconText, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return new Container(child: ScopedModelDescendant<MyScopeModel>(
//       builder: (context, child, model) {
//         this.model = model;

//         return new Column(
//           children: <Widget>[
//             new IconButton(
//               icon: new Icon(icon),
//               onPressed: () {
//                 model.setSelected(value);
//                 model.setCategory(iconText);
//               },
//               color: (model == null || model.selectedTypes != value)
//                   ? Colors.white
//                   : AppColorsTheme.myTheme.primarySwatch,
//             ),
//             new Text(
//               iconText,
//               style: TextStyle(
//                 color: (model == null || model.selectedTypes != value)
//                     ? Colors.white
//                     : AppColorsTheme.myTheme.primarySwatch,
//               ),
//             )
//           ],
//         );
//       },
//     ));
//   }

//   static void _onSearchPressed(value) {}
// }
