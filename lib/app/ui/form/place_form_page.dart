import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:travely_admin/app/common/shared_code.dart';
import 'package:travely_admin/app/data/models/place_model.dart';
import 'package:travely_admin/app/data/services/database_service.dart';
import 'package:travely_admin/app/widgets/custom_text_field.dart';
import 'package:travely_admin/app/widgets/reconnecting_widget.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key, this.placeModel}) : super(key: key);
  final PlaceModel? placeModel;

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _imageUrl = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.placeModel != null) {
      _nameController.text = widget.placeModel!.name;
      _locationController.text = widget.placeModel!.location;
      _descriptionController.text = widget.placeModel!.description;
      _ratingController.text = widget.placeModel!.rating.toString();
      _imageUrl = widget.placeModel!.imageUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.placeModel == null ? 'Tambah Obyek' : 'Ubah Obyek')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SharedCode.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                    child: _image != null
                        ? _displaySelectedImage()
                        : _imageUrl.isEmpty
                        ? Container(height: 30.h, color: Colors.grey)
                        : _buildAvatar(Image.network(_imageUrl, height: 30.h,), isImageUrl: true)),
                SizedBox(height: 1.5.h),
                Center(
                  child: OutlinedButton(
                      onPressed: () {
                        _pickImage();
                      },
                      child: Text('Ubah Foto')),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama obyek wisata',
                  controller: _nameController,
                  validator: SharedCode().emptyValidator,
                ),
                SizedBox(height: 2.h),
                CustomTextField(
                    labelText: 'Lokasi',
                    hintText: 'Masukkan lokasi obyek wisata',
                    controller: _locationController,
                    validator: SharedCode().emptyValidator),
                SizedBox(height: 2.h),
                CustomTextField(
                    labelText: 'Deskripsi',
                    hintText: 'Masukkan deskripsi obyek wisata',
                    controller: _descriptionController,
                    paddingVertical: 12,
                    minLines: 5,
                    validator: SharedCode().emptyValidator),
                SizedBox(height: 2.h),
                CustomTextField(
                  labelText: 'Rating',
                  hintText: 'Masukkan rating',
                  controller: _ratingController,
                  validator: SharedCode().emptyValidator,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 2.h),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (_imageUrl.isEmpty && _image == null) {
                      SharedCode.showSnackBar(context, 'error', 'Foto tidak boleh kosong');
                    } else {
                      _uploadToFirebase();
                    }
                  }
                }, child: Text(widget.placeModel == null ? 'Tambah Obyek' : 'Ubah Obyek'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<TaskSnapshot> _uploadImage(String id) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('places/$id/image.png');
    late UploadTask uploadTask;
    if (kIsWeb) {
      var bytes = await _image!.readAsBytes();
      uploadTask = firebaseStorageRef.putData(bytes, SettableMetadata(contentType: 'image/png'));
    } else {
      uploadTask = firebaseStorageRef.putFile(File(_image!.path));
    }
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot;
  }

  Future<void> _uploadToFirebase() async {
    context.loaderOverlay.show(widget: const ReconnectingWidget());
    try {
      PlaceModel model = PlaceModel(
        name: _nameController.text,
        location: _locationController.text,
        description: _descriptionController.text,
        id: '',
        imageUrl: '',
        rating: double.parse(_ratingController.text)
      );

      if (widget.placeModel == null) {
        DocumentReference reference = await DatabaseService().addPlace(model);
        model = PlaceModel(
            name: _nameController.text,
            location: _locationController.text,
            description: _descriptionController.text,
            id: reference.id,
            imageUrl: '',
            rating: double.parse(_ratingController.text)
        );
      } else {
        model = PlaceModel(
            name: _nameController.text,
            location: _locationController.text,
            description: _descriptionController.text,
            id: widget.placeModel!.id,
            imageUrl: widget.placeModel!.imageUrl,
            rating: double.parse(_ratingController.text));

        await DatabaseService().updatePlace(model);
      }

      if (_image != null) {
        TaskSnapshot snapshot = await _uploadImage(model.id);
        String avatarUrl = await snapshot.ref.getDownloadURL();

        model = PlaceModel(
            name: _nameController.text,
            location: _locationController.text,
            description: _descriptionController.text,
            id: model.id,
            imageUrl: avatarUrl,
            rating: double.parse(_ratingController.text));

            await DatabaseService().updatePlace(model);
      }
      context.loaderOverlay.hide();
      Future.delayed(Duration.zero, () {
        SharedCode.showSnackBar(
            context,
            'success',
            widget.placeModel == null
                ? 'Obyek berhasil ditambahkan'
                : 'Obyek berhasil diubah');
        AutoRouter.of(context).pop();
      });
    } catch (e) {
      SharedCode.showErrorDialog(context, 'Error', e.toString());
    }
    context.loaderOverlay.hide();
  }

  Widget _displaySelectedImage() {
    return kIsWeb
        ? _buildAvatar(Image.network(_image!.path))
        : _buildAvatar(Image.file(File(_image!.path)));
  }

  Widget _buildAvatar(Widget provider, {bool isImageUrl = false}) {
    return provider;
  }

  Future<void> _pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = XFile(image.path);
        print('image path ${_image?.path}');
      });
    }
  }
}
