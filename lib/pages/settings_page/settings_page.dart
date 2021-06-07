import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/pages/settings_page/preview_page.dart';
import 'package:goop/pages/settings_page/settings_controller.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthenticationController authenticationController;
  final _controller = SettingsController(UserServiceImpl(Odoo()));
  ReactionDisposer _reactionDisposer;
  final picker = ImagePicker();
  File archive;

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
      _controller.imageProfile = user.image;
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

  Future<void> showPreview(File file) async {
    file = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewPage(file)),
    );

    if (file != null) {
      setState(() {
        archive = file;
      });
    }
  }

  Future<void> getFileFromGallery() async {
    final PickedFile file = await picker.getImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        archive = File(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final authenticationController =
        Provider.of<AuthenticationController>(context);
    final user = authenticationController.currentUser;

    if (archive != null) {
      setState(() {
        user.image = archive.path;
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
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 20,
                                        bottom: 10,
                                      ),
                                      height: 3,
                                      width: 60,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      width: mediaQuery * .5,
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.camera_alt),
                                        label: Text('Tire uma foto'),
                                        style: ElevatedButton.styleFrom(
                                          primary: GoopColors.redSplash,
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => CameraCamera(
                                                enableZoom: true,
                                                onFile: (file) async {
                                                  await showPreview(file);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: mediaQuery * .5,
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.attach_file_outlined),
                                        label: Text('Escolha um arquivo'),
                                        style: ElevatedButton.styleFrom(
                                          primary: GoopColors.redSplash,
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          getFileFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      height: 30,
                                      child:
                                          SvgPicture.asset(GoopImages.charisma),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: archive == null
                              ? SvgPicture.asset(
                                  GoopImages.avatar,
                                  height: 150,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    archive,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
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
