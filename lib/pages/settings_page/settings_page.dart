import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/pages/settings_page/settings_controller.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthenticationController authenticationController;
  final _controller = SettingsController(
      UserServiceImpl(Odoo())); //TODO: MUDAR INJEÇÃO DE DEPENDECIA

  ReactionDisposer _reactionDisposer;

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
      authenticationController = Provider.of<AuthenticationController>(
        context,
        listen: false,
      );

      final user = authenticationController.currentUser;
      _controller.id = user.partnerId;
      _controller.cpf = user.cnpjCpf ?? '';
      _controller.phone = user.phone ?? '';
      _controller.email = user.email ?? '';
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
    Navigator.pop(context);
  }

  void _onError() {
    print('Deu erro');
  }

  @override
  Widget build(BuildContext context) {
    final authenticationController =
        Provider.of<AuthenticationController>(context);
    final user = authenticationController.currentUser;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GoopBack(),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .8, //TODO: COLOCAR FOTO
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            GoopImages.avatar,
                            height: 150,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${user.name}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: GoopColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GoopTextFormField( //TODO: Atualizar os dados ao salvar 
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
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text(
                      'Termos de Uso',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => GoopAlert(
                          title: 'Termos de Uso',
                          contet: '''
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.
            Nunc viverra imperdiet enim. Fusce est. Vivamus a tellus.
            Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin pharetra nonummy pede. Mauris et orci.
            Aenean nec lorem. In porttitor. Donec laoreet nonummy augue.
            Suspendisse dui purus, scelerisque at, vulputate vitae, pretium mattis, nunc. Mauris eget neque at sem venenatis eleifend. Ut nonummy.
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa.
    ''',
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Desativar minha conta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onPressed: () {},
                  ),
                  Observer(
                    builder: (_) {
                      return Center(
                        child: GoopButton(
                          text: 'Salvar',
                          action:
                              _controller.canNext ? _controller.submit : null,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
