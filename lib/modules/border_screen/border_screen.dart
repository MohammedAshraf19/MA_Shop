import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BorderShow{
  String image;
  String title;
  String body;
  BorderShow({
    required this.image,
    required this.title,
    required this.body,
});
}

class BorderScreen extends StatefulWidget {

  @override
  State<BorderScreen> createState() => _BorderScreenState();
}

class _BorderScreenState extends State<BorderScreen> {
  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    bool isLast =false;
    List<BorderShow>border =[
      BorderShow(
          image: 'assets/images/shop.jpg',
          title: '  ONLINE CART',
          body: 'Select and memorize your future purchases with smart online shopping cart'
      ),
      BorderShow(
          image: 'assets/images/shop2.jpg',
          title: 'SALES AND GIFTS',
          body: 'Holiday sales.Birthday gifts.Various choice and categories'
      ),
      BorderShow(
          image: 'assets/images/shop3.jpg',
          title: 'CLIENT REVIEWS',
          body: 'Honest feedbacks from our clients.Happy clients - Happy us.'
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: TextButton(
              onPressed: (){
                navigateAndFinish(context, LoginScreen());
              },
              child: const Text(
                'skip',
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:   [
                        Expanded(
                          child:  Image(
                              image: AssetImage(border[index].image),
                            width: double.infinity,
                          //  height: 500,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Text(
                          border[index].title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          border[index].body,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                itemCount: border.length,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index){
                   if(index == border.length-1) {
                     isLast =true;
                   }
                },
              ),
            ),
              const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast==true){
                      navigateAndFinish(context, LoginScreen());
                    }
                    else {

                      pageController.nextPage(duration: const Duration(
                        milliseconds: 750
                    ), curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: defaultColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
