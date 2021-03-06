import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/pages/settings_page/settings_controller.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:goop/utils/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends StateGoop<SettingsPage> {
  AuthenticationController authenticationController;
  final _controller = SettingsController(UserServiceImpl(Odoo()));
  ReactionDisposer _reactionDisposer;
  final picker = ImagePicker();
  ImageGoop archive = ImageGoop();

  final cpfFormatter = MaskTextInputFormatter(
    mask: '000.000.000-00',
    filter: {"0": RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(00) 0 0000-0000',
    filter: {"0": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _reactionDisposer = reaction(
      (_) => _controller.updateRequest.status,
      _onUpdateUser,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (authenticationController == null) {
      ServiceNotifier serviceNotifier =
          Provider.of<ServiceNotifier>(context, listen: false);
      AuthenticationController authenticationController =
          serviceNotifier.authenticationController;
      final user = authenticationController.currentUser;

      _controller.id = user.partnerId;
      _controller.cpf = user.cnpjCpf ?? '';
      _controller.phone = user.phone ?? '';
      _controller.email = user.email ?? '';
      _controller.imageProfile = user.image;
      archive.imageBase64 = user.image;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cpfFormatter.clear();
    phoneFormatter.clear();
    _reactionDisposer();
  }

  void _onUpdateUser(FutureStatus status) {
    switch (status) {
      case FutureStatus.fulfilled:
        _onSuccess();
        break;
      case FutureStatus.rejected:
        _onError();
        break;
      default:
    }
  }

  void _onSuccess() {
    navigatorPop();
  }

  void _onError() {
    printL('Deu erro');
  }

  submit() {
    if (_controller.canNext) {
      setState(() {
        _controller.imageProfile = archive.imageBase64;
      });

      serviceNotifier.authenticationController.currentUser.cnpjCpf = _controller.cpf;
      serviceNotifier.authenticationController.currentUser.phone = _controller.phone;
      serviceNotifier.authenticationController.currentUser.email = _controller.email;

      _controller.submit();
    } else {
      showMessage('Opss', 'Corrija os campos em vermelho');
    }
  }

  @override
  Widget build(BuildContext context) {

    AuthenticationController authenticationController =
        serviceNotifier.authenticationController;
    final user = authenticationController.currentUser;

    if (!archive.isNullOrEmpty()) {
      setState(() {
        user.image = archive.imageBase64;
      });
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GoopBack(),
        ),
        body: Center(
          child: Form(
            key: _controller.formKey,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .8,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          imagePhotoBase64(archive),
                          SizedBox(height: 20),
                          Text(
                            '${user.name}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: goopColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    GoopTextFormField(
                      //TODO: Atualizar os dados ao salvar
                      hintText: 'E-mail',
                      validator: Validators.validateEmail,
                      initialValue: _controller.email,
                      onChanged: (e) => _controller.email = e.trim(),
                    ),
                    GoopTextFormField(
                      hintText: 'Celular',
                      validator: Validators.validatePhone,
                      inputFormatters: [phoneFormatter],
                      initialValue: _controller.phone,
                      onChanged: (e) => _controller.phone = e.trim(),
                    ),
                    GoopTextFormField(
                      hintText: 'CPF',
                      validator: Validators.validateCPF,
                      inputFormatters: [cpfFormatter],
                      initialValue: _controller.cpf,
                      onChanged: (e) => _controller.cpf = e.trim(),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      child: Text(
                        'Sobre o GoOp',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Text(
                        'Termos de Uso',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              GoopAlert(
                                title: Text('Termos de Uso'),
                                contet: Text(
                                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna ',
                                ),
                              ),
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Desativar minha conta',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                      ),
                      onPressed: () {},
                    ),
                    Center(
                      child: GoopButton(
                        text: 'Salvar',
                        action: submit
                        // action: _controller.canNext ? submit : null,
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
