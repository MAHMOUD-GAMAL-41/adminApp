import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/products_model.dart';
import '../homescreen/cubit/states.dart';
import 'edit_product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;

  int currentSelected = 0;

  ProductDetailsScreen(this.productModel);

  void customSelect(int index) {
    currentSelected = index;
  }

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  CarouselController carouselController = CarouselController();
  int currentPage = 0;
  int currentColor = 0;

  @override
  Widget build(BuildContext context) {
    var data = widget.productModel.data.cast<String, Map<String, dynamic>>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text('Custom View'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(.8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              AdminCubit.get(context).deleteProduct(
                                  widget.productModel.productUid);
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditProduct(productModel:widget.productModel,)));
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: MyColors.purpleDark,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageSlider(),
                      clothesInfo(
                        context: context,
                        title: widget.productModel.productName,
                        description: widget.productModel.description,
                        rate: widget.productModel.rate,
                        cubit: AdminCubit.get(context),
                      ),
                      sizeList(data),
                      colorList(data),
                      addCart(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget colorList(data) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your Color',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: data![data!.keys.toList()[widget.currentSelected]]!
                      .keys
                      .length *
                  50.0,
              height: 50,
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25)),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentColor = index;
                          });
                        },
                        child: colorPicker(index: index, data: data),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 3,
                      ),
                  itemCount: data![data!.keys.toList()[widget.currentSelected]]!
                      .keys
                      .length),
            )
          ],
        ),
      );

  Widget imageSlider() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            itemCount: widget.productModel.photos!.length,
            carouselController: carouselController,
            options: CarouselOptions(
                height: 400,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlayInterval: Duration(seconds: 2),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.productModel.photos![index],
                      ),
                      fit: BoxFit.fill,
                    )),
              );
            },
          ),
          Center(
            heightFactor: 6,
            child: AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: widget.productModel.photos!.length,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: Theme.of(context).focusColor,
                dotColor: Colors.black,
              ),
            ),
          ),
        ],
      );

  Widget colorPicker({
    required index,
    required data,
  }) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: currentColor == index
            ? Border.all(
                color: Color(int.parse(
                    data[data!.keys.toList()[widget.currentSelected]]!
                        .keys
                        .toList()[currentColor])),
                width: 2)
            : null,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(int.parse(
              data![data!.keys.toList()[widget.currentSelected]]!
                  .keys
                  .toList()[index])),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget clothesInfo(
          {required context,
          required title,
          required rate,
          required description,
          required cubit}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          AdminCubit.get(context).model!.brandName ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        )),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '$rate',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                RatingBarIndicator(
                  rating: widget.productModel.rate ?? 5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  unratedColor: Colors.orangeAccent.withAlpha(50),
                ),
                Spacer(),
              ],
            ),
            ReadMoreText(
              description,
              trimLines: 3,
              trimMode: TrimMode.Line,
              textAlign: TextAlign.start,
              trimCollapsedText: 'Show More',
              trimExpandedText: 'Show Less',
              lessStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.lightOrange,
              ),
              moreStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.lightOrange,
              ),
              style: TextStyle(
                fontSize: 16,
                height: 2,
                color: Colors.white,
              ),
            )
          ],
        ),
      );

  Widget sizeList(data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Choose your Size',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.currentSelected = index;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: widget.currentSelected == index
                              ? MyColors.lightOrange
                              : Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4)),
                        ),
                        child: Center(
                          child: Text(
                            data!.keys.toList()[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                itemCount: data!.keys.length),
          ),
          SizedBox(
            height: 10,
          )
        ],
      );

  Widget addCart() => Container(
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'price',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                    widget.productModel.offer == ''
                        ? '${ widget.productModel.price} LE '
                        : '${((100 - double.parse( widget.productModel.offer as String)) * double.parse( widget.productModel.price as String)) / 100} LE ',

                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
