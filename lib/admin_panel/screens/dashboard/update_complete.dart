// ignore: file_names
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import 'package:homify_haven/model/products.dart';

import '../../../model/category_model.dart';
import '../../../widgets/homi_button.dart';
import '../../../widgets/homi_textfield.dart';
import '../../../widgets/snackbar_widget.dart';

// ignore: must_be_immutable
class UpdateCompleteProductScreen extends StatefulWidget {
  UpdateCompleteProductScreen({super.key, this.id, this.product});
  String? id;

  Product? product;

  @override
  State<UpdateCompleteProductScreen> createState() =>
      _UpdateCompleteProductScreenState();
}

class _UpdateCompleteProductScreenState
    extends State<UpdateCompleteProductScreen> {
  String? selectedValue = " ";
  // List<String> categories = [
  //   "Sofas",
  //   "Table",
  //   "Beds",
  //   "Dining Furniture",
  //   "Shelving Furniture",
  //   "Plants",
  //   "Outdoor Furniture"
  // ];

  bool isSaving = false;
  bool isUploading = false;

  final imagePicker = ImagePicker();
  List<XFile> images = [];

  List<dynamic> imageUrls = [];

  TextEditingController categoryCon = TextEditingController();

  TextEditingController idCon = TextEditingController();
  TextEditingController productNameCon = TextEditingController();
  TextEditingController detailCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController discountPriceCon = TextEditingController();

  TextEditingController serialCodeCon = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavorite = false;

  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();

    selectedValue = widget.product!.category;
    productNameCon.text = widget.product!.productName!;
    detailCon.text = widget.product!.detail!;
    descriptionCon.text = widget.product!.description!;
    priceCon.text = widget.product!.price!.toString();
    discountPriceCon.text = widget.product!.discountPrice!.toString();
    serialCodeCon.text = widget.product!.serialCode!;
    isOnSale = widget.product!.isOnSale!;
    isPopular = widget.product!.isPopular!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                const Text(
                  "UPDATE PRODUCT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField(
                    hint: const Text('Choose Category'),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Category must be selected";
                      } else {
                        return null;
                      }
                    },
                    items: categories
                        .map((e) => DropdownMenuItem<String>(
                              value: e.title,
                              child: Text(
                                e.title!,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    value: selectedValue,
                  ),
                ),

                HomifyTextField(
                  hintText: "Enter Product Name..",
                  controller: productNameCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  maxLines: 5,
                  hintText: "Enter Detail..",
                  controller: detailCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: "Enter Description..",
                  controller: descriptionCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: "Enter Price..",
                  controller: priceCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: "Enter Discount Price..",
                  controller: discountPriceCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: "Enter Serial Code..",
                  controller: serialCodeCon,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "It should not be empty";
                    }
                    return null;
                  },
                ),
                // Row(
                //   children: [
                //     ...List.generate(
                //       widget.product!.imagesUrls!.length,
                //       (index) => Stack(
                //         children: [
                //           ClipRRect(
                //             child: Image.network(
                //               widget.product!.imagesUrls![index],
                //               height: 15.h,
                //               width: 15.w,
                //               fit: BoxFit.contain,
                //             ),
                //           ),
                //           IconButton(
                //               onPressed: () {
                //                 setState(() {
                //                   var j = images.indexOf(
                //                       widget.product!.imagesUrls![index]);
                //                   images.removeAt(j);
                //                 });
                //               },
                //               icon: Icon(Icons.cancel_outlined))
                //         ],
                //       ),
                //     ),
                //   ],
                // ),

                Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: widget.product!.imagesUrls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Image.network(
                                  widget.product!.imagesUrls![index],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.product!.imagesUrls!
                                          .removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined)),
                            ],
                          ),
                        );
                      }),
                ),

                HomifyButton(
                  onPress: () {
                    pickImage();
                  },
                  title: 'PICK IMAGES',
                  isLoginButton: true,
                ),
                // EcoButton(
                //   onPress: () {
                //     uploadImages();
                //   },
                //   title: 'UPLOAD IMAGES',
                //   isLoading: isUploading,
                //   isLoginButton: true,
                // ),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                )),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined)),
                            ],
                          ),
                        );
                      }),
                ),

                SwitchListTile(
                  title: const Text("Is the Product on Sale?"),
                  value: isOnSale,
                  onChanged: (value) {
                    setState(() {
                      isOnSale = !isOnSale;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text("Is the Product Popular"),
                  value: isPopular,
                  onChanged: (value) {
                    setState(() {
                      isPopular = !isPopular;
                    });
                  },
                ),
                HomifyButton(
                  title: "Save",
                  onPress: () {
                    save();
                  },
                  isLoading: isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Product.updateProduct(
        widget.id!,
        Product(
          category: selectedValue,
          id: widget.id!,
          productName: productNameCon.text,
          detail: detailCon.text,
          description: descriptionCon.text,
          price: int.parse(priceCon.text),
          discountPrice: int.parse(discountPriceCon.text),
          serialCode: serialCodeCon.text,
          imagesUrls: imageUrls,
          isOnSale: isOnSale,
          isPopular: isPopular,
          isFavorite: isFavorite,
        )).whenComplete(() {
      setState(() {
        isSaving = false;
      });
      images.clear();
      imageUrls.clear();
      clearField();

      SnackbarService.showSuccess(context, "Product Updated successfully!");
    });
    // await FirebaseFirestore.instance.collection('items').add({
    //   "images": imageUrls,
    // }).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    // });
  }

  clearField() {
    // selectedValue = "";
    // productNameCon.clear();
    // detailCon.clear();
    // descriptionCon.clear();
    // priceCon.clear();
    // discountPriceCon.clear();
    // serialCodeCon.clear();
  }

  pickImage() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      if (kDebugMode) {
        print("No Images Selected");
      }
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });

    String? urls;

    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"),
      );

      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downloadUrl) => {
            imageUrls.add(downloadUrl),
          });
    }
    imageUrls.addAll(widget.product!.imagesUrls!);
  }
}
