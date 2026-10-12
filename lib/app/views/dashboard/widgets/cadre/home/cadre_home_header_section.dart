import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CadreHomeHeaderSection extends StatelessWidget {
  const new({required this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const .only(left: 16, right: 16, top: 16),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                buildWhen: (previous, current) =>
                    previous.greetingMessage != current.greetingMessage,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        state.greetingMessage ?? '',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Halo,',
                        style: TextStyle(fontSize: 12, fontWeight: .w500),
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            previous.profileStatus != current.profileStatus,
                        builder: (context, state) {
                          return Text(
                            'Posyandu ${state.profile?.name?.capitalize()}',
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: .w600,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Material(
              elevation: 1,
              color: Colors.white,
              clipBehavior: .antiAlias,
              shape: const CircleBorder(),
              child: Padding(
                padding: const .all(6),
                child: BaseIconButton(
                  icon: RemixIcon.menu3Line,
                  color: Colors.black,
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
