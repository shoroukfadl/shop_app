import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/ShopApp/ShopCubit/shopCubit.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';


Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixClicked!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder()),
    );

Widget defaultAppBar({
  required BuildContext context,
  String ?title,
  List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    icon: Icon(IconBroken.Arrow___Left_2),
    onPressed: (){
      Navigator.pop(context);
    },
  ),
  title: Text(
     title!
  ),
  titleSpacing: 5.0,
  actions: actions,
);


Widget dividerWidget()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);

void navigateTo(context,Widget){
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=> Widget
      ));
}

void navigateAndFinish(context,Widget)=>
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>Widget),
          (route) => false);

Widget defaultTextButton({
  required void Function() onTap,
  required String text
})=> TextButton(
        onPressed: (){onTap();},
        child: Text(text.toUpperCase())
    );

void showToast({
  required String text,
  required ToastState state})=>  Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastState{Success,Error,Warning}

Color chooseToastColor(ToastState state){
  Color color;
switch(state){
  case ToastState.Success:
  color=Colors.green;
    break;
    case ToastState.Error:
  color=Colors.red;
    break;
    case ToastState.Warning:
  color=Colors.amber;
    break;
}
return color;
}

Widget buildProductItems( model, context,{bool inSearch=true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage((model.image)!),
              width: 120,
              height: 120,
            ),
            if((model.discount) != 0&&inSearch)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.name)!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text((model.price.toString()),
                    style: TextStyle(
                        fontSize: 12,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if((model.discount) != 0&&inSearch)
                    Text(model.discount.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),

                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavourites(
                          (model.id)!
                      );
                      // print(model.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor: ShopCubit
                            .get(context)
                            .favourite[model.id]!
                            ? defaultColor
                            : Colors.grey,
                        radius: 15,
                        child: Icon(Icons.favorite_border,
                          color: Colors.white,
                          size: 14,
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
