import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../shared/style/colors.dart';
import '../add_order/add_order.dart';

class ProductDetails extends StatelessWidget {
  String image;
  String name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String description;
  dynamic id;
  //int id;
  ProductDetails({
    required this.name,
    required this.image,
    required this.oldPrice,
    required this.price,
    required this.description,
    required this.discount,
    required this.id,
});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is SuccessChangeCartData){
          showToast(txt: state.changeCartModel.message.toString(), state: ToastState.SUCCESS);
        }
      },
      builder: (context,state){
        return Scaffold(
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                   Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                   const SizedBox(
                     height: 3,
                   ),
                   Stack(
                     alignment: Alignment.bottomLeft,
                     children: [
                       Image(
                        image: NetworkImage(
                            image
                        ),
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.contain,
                  ),
                       if(discount != 0)
                         Container(
                           color: Colors.red,
                           padding: EdgeInsets.all(5),
                           child: const Text(
                             'DISCOUNT',
                             style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white
                             ),
                           ),
                         )
                     ],
                   ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      ShopCubit.get(context).changeFavourite(productId: id);
                    },
                    icon:   CircleAvatar(
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ),
                      backgroundColor:
                        ShopCubit.get(context).favourite[id]!?Colors.red: Colors.grey,
                      radius: 20,
                    ),
                    iconSize: 25,
                  ),
                   Text(
                     'EGP ${price}\$',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  if(discount != 0)
                     Row(
                    children: [
                      Text(
                        'last price: ',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'EGP ${oldPrice}\$',
                        style:  TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'All prices include VAT.',
                    style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Deliver to Egypt',
                        style:  TextStyle(
                          color:defaultColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,

                        ),

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'In Stock',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 242
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7)
                            ),
                            borderSide: BorderSide(color: defaultColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7)
                            ),
                            borderSide: BorderSide(
                              color: Colors.purple,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7)
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Quantity',
                        hintStyle: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      cursorColor: Colors.deepPurple,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email Must Not Be Null';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if(!ShopCubit.get(context).cart[id]!)
                        Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                color: defaultColor,
                                onPressed: (){
                                  ShopCubit.get(context).changeCart(productId: id);
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            if(state is LoadingChangeCartData)
                              LinearProgressIndicator(color: defaultColor,),
                          ],
                        ),
                      ),
                      if(ShopCubit.get(context).cart[id]!)
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  color: defaultColor,
                                  onPressed: (){
                                    ShopCubit.get(context).changeCart(productId: id);
                                  },
                                  child: const Text(
                                    'Remove from Cart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                              ),
                              if(state is LoadingChangeCartData)
                                LinearProgressIndicator(color: defaultColor,),
                            ],
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MaterialButton(
                            color: defaultColor,
                            onPressed: (){
                              navigateTo(context, AddOrder(price: price,));
                            },
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Decoration',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  ),
                   Text(
                    description,
                    style: const TextStyle(
                        height: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
