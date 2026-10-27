import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ParentHeaderSection extends StatelessWidget {
  const new({required this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const .only(left: 16, right: 16, top: 16),
        child: Row(
          children: [
            Expanded(
              child: BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    previous.profileStatus != current.profileStatus,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Text('Halo,', style: TextStyle(fontSize: 12)),
                      Text(
                        state.profile?.name ?? '',
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: const TextStyle(fontSize: 16, fontWeight: .w600),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            CupertinoButton(
              minimumSize: .zero,
              padding: const .all(2),
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: const Material(
                elevation: 1,
                color: Colors.white,
                clipBehavior: .antiAlias,
                shape: CircleBorder(),
                child: Padding(
                  padding: .all(6),
                  child: Icon(RemixIcon.menu3Line, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
