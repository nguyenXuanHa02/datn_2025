import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/base_widget/formtextfield.dart';
import 'package:kichikichi/roles/account/controller.dart';
import 'package:kichikichi/roles/account/widget/user_info.dart';

import '../../core/imports/imports.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<AccountController>(
      init: AccountController(),
      (controller) {
        final manager = Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AccountUserInfo(
                          user: controller.accountData,
                        )
                      ],
                    ),
                  ),
                  RoundedButton.text(
                    'Đăng xuất',
                    () {
                      controller.dangXuat();
                    },
                  )
                ],
              ).safePad(),
            );
          },
        );
        final customer = Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AccountUserInfo(
                          user: controller.accountData,
                        )
                      ],
                    ),
                  ),
                  RoundedButton.text(
                    'Đăng xuất',
                    () {
                      controller.dangXuat();
                    },
                  )
                ],
              ).safePad(),
            );
          },
        );
        final staff = Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AccountUserInfo(
                          user: controller.accountData,
                        )
                      ],
                    ),
                  ),
                  RoundedButton.text(
                    'Đăng xuất',
                    () {
                      controller.dangXuat();
                    },
                  )
                ],
              ).safePad(),
            );
          },
        );
        if (controller.currentRole == AccountRole.customer) {
          return customer;
        }
        if (controller.currentRole == AccountRole.staff) {
          return staff;
        }
        if (controller.currentRole == AccountRole.manager) {
          return manager;
        }
        final guestPage = Builder(
          builder: (context) => Scaffold(
            body: DefaultTabController(
              length: 2,
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AppSize.h32,
                              AppSize.h32,
                              const Text(
                                'Đăng nhập',
                                style: AppTextStyles.heading1,
                              ).fadeInSlideUp(),
                              AppSize.h8,
                              const Text(
                                'Chưa có tài khoản vuốt sang để đăng kí ',
                                style: AppTextStyles.hintText,
                              ).fadeInSlideUp(),
                              AppSize.h64,
                              textFieldWith<AccountController>('username',
                                      label: 'Tên đăng nhập')
                                  .fadeInSlideUp(),
                              AppSize.h8,
                              textFieldWith<AccountController>('password',
                                      label: 'Mật khẩu', isPass: true)
                                  .fadeInSlideUp(),
                              AppSize.h8,
                            ],
                          ),
                        ),
                      ),
                      RoundedButton.text('Đăng nhập', () {
                        controller.dangNhap();
                      }).fadeInSlideUp()
                    ],
                  ).safePad(),
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AppSize.h32,
                              AppSize.h32,
                              const Text(
                                'Đăng ký',
                                style: AppTextStyles.heading1,
                              ).fadeInSlideUp(),
                              AppSize.h8,
                              const Text(
                                'Đăng kí tài khoản để nhận được nhiều ưu đãi dành riêng cho bạn',
                                style: AppTextStyles.hintText,
                              ).fadeInSlideUp(),
                              AppSize.h64,
                              textFieldWith<AccountController>('username',
                                      label: 'Tên đăng nhập')
                                  .fadeInSlideUp(),
                              AppSize.h8,
                              textFieldWith<AccountController>('password',
                                      label: 'Mật khẩu', isPass: true)
                                  .fadeInSlideUp(),
                            ],
                          ),
                        ),
                      ),
                      RoundedButton.text('Đăng ký', () {
                        controller.dangKy();
                      }).fadeInSlideUp()
                    ],
                  ).safePad(),
                ],
              ),
            ),
          ),
        );
        return guestPage;
      },
    );
  }
}
