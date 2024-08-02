import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/dashboard/widgets/dashboard_wrapper.dart';
import 'package:people/sevices/router/app_routes.dart';
import 'package:people/utils/app_textstyles.dart';
import 'package:people/widgets/loader.dart';

import '../../../generated/l10n.dart';
import '../../../sevices/router/app_router.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/state_status.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleStateStatus(BuildContext context, DashboardState state) {
    if (state.status == StateStatus.loading) {
      return const Loader();
    }
    if (state.status == StateStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.5), borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                    child: Text(
                  S.current.error_occured,
                  style: AppTextStyles.bold16,
                )),
              )),
          margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        return DashboardWrapper(
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    if (_tabController.index == 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.current.people,
                                  style: AppTextStyles.bold24.copyWith(color: AppColors.whiteColor),
                                ),
                                GestureDetector(
                                  onTap: () => context.read<AppRouter>().router.pushNamed(AppRoutes.createPerson),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(S.current.add_person,
                                          style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ...state.people.map((person) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                    onTap: () => context
                                        .read<AppRouter>()
                                        .router
                                        .pushNamed(AppRoutes.editPerson, extra: {'personId': person.id}),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      child: ListTile(
                                        title: Text('${person.firstName} ${person.lastName}',
                                            style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor)),
                                        subtitle: Text(
                                          person.address,
                                          style: AppTextStyles.normal14.copyWith(color: AppColors.redColor),
                                        ),
                                      ),
                                    ),
                                  ),
                            )),
                          ],
                        ),
                      ),
                    if (_tabController.index == 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.current.groups,
                                  style: AppTextStyles.bold24.copyWith(color: AppColors.whiteColor),
                                ),
                                GestureDetector(
                                  onTap: () => context.read<AppRouter>().router.pushNamed(AppRoutes.createGroup),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(S.current.add_group,
                                          style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ...state.groups.map((group) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                    onTap: () => context
                                        .read<AppRouter>()
                                        .router
                                        .pushNamed(AppRoutes.editGroup, extra: {'groupId': group.id}),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          group.name,
                                          style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor),
                                        ),
                                        subtitle: Text(
                                          '${S.current.amount_of_people} ${group.persons.length}',
                                          style: AppTextStyles.normal14.copyWith(color: AppColors.redColor),
                                        ),
                                      ),
                                    ),
                                  ),
                            )),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ]),
          bottomNavBar: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TabBar(
              tabs: [
                _tabElement(
                  S.current.people,
                  const Icon(Icons.person),
                ),
                _tabElement(
                  S.current.groups,
                  const Icon(Icons.people),
                ),
              ],
              controller: _tabController,
              labelColor: AppColors.whiteColor,
              unselectedLabelColor: Colors.white.withOpacity(0.6),
              indicatorColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  Widget _tabElement(String? text, Widget? icon) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: Tab(
        text: text,
        icon: icon,
        iconMargin: const EdgeInsets.only(bottom: 5),
      ),
    );
  }
}
