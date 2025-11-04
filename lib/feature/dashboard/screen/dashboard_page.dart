import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> myBanners = [];

  @override
  void initState() {
    myBanners = RepositoryProvider.of<BannerRepository>(context).banners;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DashBoardWidget();
  }
}
