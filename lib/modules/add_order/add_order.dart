import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/style/colors.dart';

class AddOrder extends StatelessWidget {
  dynamic price;
  final aa =DateTime.sunday;
  final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
  AddOrder({Key? key, required this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: defaultColor,
            ),
          ),
        ),
        body: Align(
          alignment: AlignmentDirectional.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              const Text(
                                'Shipping to:',
                                style: TextStyle(
                                    color: Colors.grey
                                ),

                              ),
                              Text(
                                ShopCubit.get(context).userModel!.data!.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                            ],
                          ),
                          const Text(
                            'Estimated delivery',
                            style: TextStyle(
                                color: Colors.grey
                            ),

                          ),
                          Text(
                            '${DateTime.now().add(Duration(days: 3))}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              color: Colors.grey[300],
                              width: double.infinity,
                              height: 1,
                            ),
                          ),
                          Row(
                            children:  [
                              const Text(
                                'items',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                              Spacer(),
                              Text(
                                'EGP ${price}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ],
                          ),
                          Row(
                            children:  const [
                              Text(
                                'shipping & handling',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                              Spacer(),
                              Text(
                                'EGP 21.00',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ],
                          ),
                          Row(
                            children:  const [
                              Text(
                                'Cash on Delivery Fee',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                              Spacer(),
                              Text(
                                'EGP 5.00',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:    [
                              const Text(
                                'Order Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                              const Spacer(),
                              Text(
                                'EGP ${price+5+21}',
                                style: const TextStyle(
                                    color: Colors.red
                                ),

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: MaterialButton(
                          color: defaultColor,
                          onPressed: (){
                            showToast(txt: 'Order Successfully', state: ToastState.SUCCESS);
                            Navigator.pop(context);
                            print(aa);
                          },
                          child: const Text(
                            'Place your order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
