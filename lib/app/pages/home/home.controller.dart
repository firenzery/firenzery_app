import 'package:firenzery/app/models/user.model.dart';
import 'package:flutter/cupertino.dart';

import '../../viewmodels/user.viewmodel.dart';

class HomeController {
    final UserViewModel viewModel;

    HomeController(this.viewModel);

    ValueNotifier<UserModel> get user => viewModel.userModel;

    getUser(id) {
      viewModel.getUser(id);
    }
}