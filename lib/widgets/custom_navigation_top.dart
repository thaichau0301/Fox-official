import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';

import '../presentation/main_adjust_screen/main_adjust_screen.dart';


Primitives primitives = new Primitives();
class navigationTop extends StatelessWidget {
  const navigationTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // navigation menu top
      width: double.infinity,
      height: 35,
      color: primitives.surface_secondary,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.undo_outlined, color: primitives.surface_icon1,)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.redo_outlined ,color: primitives.surface_icon1,)
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.image_outlined,color: primitives.surface_icon1,)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.compare_outlined,color: primitives.surface_icon1,)
              ),
            ],
          )
        ],
      ),
    );
  }
}
