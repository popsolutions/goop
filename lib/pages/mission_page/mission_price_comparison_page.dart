import 'dart:convert';
import 'dart:io';
import 'package:goop/pages/settings_page/preview_page.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/ClassConstants.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MissionPriceComparisionPage extends StatefulWidget {
  @override
  _MissionPriceComparisionPageState createState() => _MissionPriceComparisionPageState();
}

class _MissionPriceComparisionPageState extends State<MissionPriceComparisionPage> {
  ServiceNotifier serviceNotifier;
  @override
  String archive;
  double price = 0;
  final picker = ImagePicker();


  Future<void> showPreview(File file) async {
    file = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewPage(file)),
    );

    if (file != null) {
      setState(() {
        archive = base64Encode(file.readAsBytesSync());
      });
    }
  }

  Future<void> getFileFromGallery() async {
    final PickedFile file = await picker.getImage(source: ImageSource.gallery);
    File fileTmp = File(file.path);

    if (file != null) {
      setState(() {
        archive = base64Encode(fileTmp.readAsBytesSync());
      });
    }
  }

  Future<void> salvar(BuildContext context) async {
    await serviceNotifier.insert_Measurement_PriceComparisonLinesModel(price, archive);
    print('x');
  }


  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;

    final TextStyle theme = Theme.of(context).textTheme.headline2;
    //final MissionDto missionDto = ModalRoute.of(context).settings.arguments;
    serviceNotifier = Provider.of<ServiceNotifier>(context);
    Activity currentActivity = serviceNotifier.currentActivity;

    if ((currentActivity.measurementPriceComparisonLinesModel != null) && (archive == null))
      archive = currentActivity.measurementPriceComparisonLinesModel.photo;



    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 60,
          child: SvgPicture.asset(GoopImages.price_comparison),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'PRODUTOS',
                    style: theme,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Divider(color: Colors.deepPurple),
                  ),
                  Text(
                    currentActivity.name,
                    style: theme,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Preço',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 30),
                  GoopTextFormField(hintText: 'R\$ 100',
                  onChanged: (value){
                    price = (value == '') ? 0 : double.parse(value.replaceAll(',', '.'));
                    print(price);
                  },),
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
                      }
                    ,
                    child:
                  (archive == null)
                      ? Image.asset(
                    GoopImages.empty_profile,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  )
                      : Image.memory(
                    Base64Codec().decode(archive),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  )
                  ),
                ],
              ),
              Container(
                child: GoopButton(
                  text: 'Salvar',
                  action: () async {
                    await salvar(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
