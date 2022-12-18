import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:travely_admin/app/data/services/database_service.dart';
import 'package:travely_admin/app/repositories/place/place_repository.dart';
import 'package:travely_admin/app/routes/router.gr.dart';
import 'package:travely_admin/app/widgets/reconnecting_widget.dart';

import '../../../blocs/place/place_bloc.dart';
import '../../../common/color_values.dart';
import '../../../common/shared_code.dart';
import '../../../data/models/place_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AutoRouter.of(context).navigate(PlaceFormRoute());
        },
      ),
      appBar: AppBar(title: const Text('Beranda')),
      body: BlocProvider(
        create: (context) => PlaceBloc(
            repository: RepositoryProvider.of<PlaceRepository>(context))
          ..add(LoadPlaces()),
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceLoading) {
              context.loaderOverlay.show();
            }
            if (state is PlaceInitial) {
              context.loaderOverlay.hide();
            }
            if (state is PlaceLoaded) {
              if (context.loaderOverlay.overlayWidgetType != ReconnectingWidget) {
                context.loaderOverlay.hide();
              }
              print('place loaded ${state.places}');
              return state.places.isEmpty ? const Center(child: Text('Kamu belum menambahkan data.')) : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(SharedCode.defaultPadding),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) => _buildCard(state.places[i]),
                      separatorBuilder: (_, __) => SizedBox(height: 2.h),
                      itemCount: state.places.length),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildCard(PlaceModel place) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigate(PlaceFormRoute(placeModel: place));
        },
        child: Padding(
          padding: const EdgeInsets.all(SharedCode.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    place.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 30.h,
                  )),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    place.name,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  )),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orangeAccent),
                      SizedBox(width: 0.2.h),
                      Text(
                        '${place.rating}',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: ColorValues.navy,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(child: Text(place.location)),
                ],
              ),
              SizedBox(height: 2.h),
              ElevatedButton(onPressed: () async {
                SharedCode.showAlertDialog(context, 'Konfirmasi', 'Apakah kamu yakin ingin menghapus ${place.name}?', () async {
                  context.loaderOverlay.show();
                  try {
                    await DatabaseService().removePlace(place);
                    Future.delayed(Duration.zero, () {
                      SharedCode.showSnackBar(context, 'success', 'Data berhasil dihapus');
                    });
                  } catch (e) {
                    SharedCode.showErrorDialog(context, 'Error', e.toString());
                  }
                  context.loaderOverlay.hide();
                });
              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Hapus Data'))
            ],
          ),
        ),
      ),
    );
  }
}
