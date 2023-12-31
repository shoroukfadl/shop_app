
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../Layout/ShopLayout.dart';
import '../ShopRegisterCubit/cubit.dart';
import '../ShopRegisterCubit/state.dart';


class ShopRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControl=TextEditingController();
  var phoneControl=TextEditingController();
  var nameControl=TextEditingController();
  var passwordControl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(ShopRegisterInitialState),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status==true)
            {
              CashHelper.saveData(key: 'token', value:state.loginModel.data!.token
              ).then((value) {
                token=state.loginModel.data!.token!;
                showToast(text:(state.loginModel.message)! , state: ToastState.Success);
                navigateAndFinish(context, ShopLayoutScreen());
              });
            }
            else
            {
              print(state.loginModel.message);
              showToast(text: (state.loginModel.message)!,
                  state: ToastState.Error);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(),
              body:  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Register',
                              style: Theme.of(context).textTheme.headline2!.
                              copyWith(color: Colors.black
                              ),
                            ),
                            Text('Register now to Browse to Our Cool App',
                              style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.grey
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: nameControl,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (){},
                                type: TextInputType.name,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Name Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'Name',
                                prefix: Icons.person),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: emailControl,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (){},
                                type: TextInputType.emailAddress,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Email Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'Email',
                                prefix: Icons.email),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: passwordControl,
                                type: TextInputType.visiblePassword,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (value) {},
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Password is to Short';
                                  else
                                    return null;
                                },
                                isPassword: ShopRegisterCubit.get(context).isPassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: ShopRegisterCubit.get(context).suffix,
                                suffixClicked: (){
                                  ShopRegisterCubit.get(context).changePasswordVisibility();
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormText(
                                control: phoneControl,
                                onTap: (){},
                                onChanged: (value){print(value);},
                                onSubmit: (){},
                                type: TextInputType.phone,
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                    return 'Phone Can not be Empty';
                                  else
                                    return null;
                                },
                                label: 'phone',
                                prefix: Icons.phone),
                            SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder:(context)=>defaultButton(
                                onTap: (){
                                  if(formKey.currentState!.validate())
                                  {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailControl.text,
                                        password: passwordControl.text,
                                        phone: phoneControl.text,
                                        name: nameControl.text);
                                  }
                                },
                                text: 'Register',),
                              fallback:(context)=>Center(child: CircularProgressIndicator()) ,

                            ),

                          ]),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
