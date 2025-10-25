import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luden/common/widget/is_premium.dart';
import 'package:luden/features/home/presentation/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/model/category/category_model.dart';
import '../../../../common/provider/category/category_provider.dart';
import '../../../../common/provider/user/user_provider.dart';
import '../../../../core/consts/color/app_colors.dart';
import '../../../../core/consts/gen/assets.gen.dart';
import '../../../../core/consts/route/app_routes.dart';
import '../../../../core/consts/text_style/app_text_styles.dart';
import '../../../../core/services/get_it/get_it_service.dart';
import '../../../../core/services/route/route_service.dart';
import '../mixin/home_mixin.dart';
import '../widget/popular_video_item.dart';
import '../widget/video_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) => context.read<HomeViewModel>().changeIndex(index),
              ),
              carouselController: CarouselSliderController(),
              items: homeVideos.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return PopularVideoItem(homeModel: item);
                  },
                );
              }).toList(),
            ),
          ),

          /// 🟣 SLIVER 2: Carousel indicator
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: Consumer<HomeViewModel>(
                  builder: (BuildContext context, homeProvider, Widget? child) {
                    return Stack(
                      alignment: homeProvider.alignment(),
                      children: [
                        Container(
                          width: 100.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.grey.withValues(alpha: 0.1),
                          ),
                        ),
                        Container(
                          width: (100 / 3).w,
                          height: 4.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          /// 🟣 SLIVER 3: Kategoriler
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final category = categoryProvider.categories[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [buildCategoryTitle(category), buildCategories(category)],
                ),
              );
            }, childCount: categoryProvider.categories.length),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 80.h)),
        ],
      ),
    );
  }

  SizedBox buildCategories(CategoryModel category) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        cacheExtent: 9999999,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        padding: EdgeInsets.only(right: 16.w),
        itemCount: category.templates.length,
        itemBuilder: (context, i) {
          final template = category.templates[i];
          return TemplateVideoItem(template: template);
        },
      ),
    );
  }

  /// 🟩 Kategori Başlığı
  Padding buildCategoryTitle(CategoryModel category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h).copyWith(top: 0),
      child: RichText(
        text: TextSpan(
          text: category.title,
          style: AppStyles.semiBold(fontSize: 16),
          children: [TextSpan(text: ' Video Categories', style: AppStyles.regular(fontSize: 16))],
        ),
      ),
    );
  }

  /// 🟩 AppBar
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      forceMaterialTransparency: true,
      titleSpacing: 16.w,
      title: Row(
        children: [
          Assets.images.splashLogo.svg(width: 30),
          SizedBox(width: 10.w),
          Text('Luden AI', style: AppStyles.semiBold(fontSize: 16)),
        ],
      ),
      actions: [
        IsPremium(
          builder: (bool isPremium) {
            return GestureDetector(
              onTap: () {
                if (isPremium == true) {
                  getIt<RouteService>().go(path: AppRoutes.coins);
                } else {
                  getIt<RouteService>().go(path: AppRoutes.subscriptions);
                }
              },
              child: Container(
                decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                margin: EdgeInsets.only(right: 10.w),
                child: Row(
                  children: [
                    Assets.icons.coin.svg(width: 16.w),
                    SizedBox(width: 5.w),
                    Consumer<UserProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return Text('${provider.user.coins}', style: AppStyles.semiBold(fontSize: 12));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () => getIt<RouteService>().go(path: AppRoutes.settings),
          child: Container(
            decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(8.r)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            margin: EdgeInsets.only(right: 16.w),
            child: Assets.icons.settings.svg(width: 16.w),
          ),
        ),
      ],
    );
  }
}
