import 'package:flutter/material.dart';
import 'package:practice_ortalama_hesapla/costants/app_constants.dart';
import 'package:practice_ortalama_hesapla/helper/data_helper.dart';
import 'package:practice_ortalama_hesapla/model/ders.dart';
import 'package:practice_ortalama_hesapla/widget/ortalama_goster.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  List<DersModel> tumDersler = [];
  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = 'Ders Adı Girilmemiş';
  double krediDegeri = 1;
  double notDegeri = 4;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Ortalama Hesapla',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppConstants.anaRenk,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // color: Colors.red.shade100,
                  child: myForm(),
                ),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                  dersSayisi: tumDersler.length,
                  ortalama: ortalamaHesapla(),
                ),
              ),
            ],
          ),
          Expanded(
            child: tumDersler.length > 0
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        setState(() {
                          tumDersler.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Card(
                          child: ListTile(
                            title: Text(tumDersler[index].ad),
                            leading: CircleAvatar(
                              backgroundColor: AppConstants.anaRenk,
                              child: Text(
                                '' +
                                    (tumDersler[index].krediDegeri *
                                            tumDersler[index].harfDegeri)
                                        .toStringAsFixed(0),
                              ),
                            ),
                            subtitle: Text(
                              '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: tumDersler.length,
                  )
                : Container(
                    margin: EdgeInsets.all(24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Lütfen ders ekleyiniz')),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Form myForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildTextFormFiled(),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildHarfler(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildKrediler(),
              ),
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var eklenecekDers = DersModel(
                      ad: girilenDersAdi,
                      harfDegeri: secilen,
                      krediDegeri: secilenKredi,
                    );
                    tumDersler.insert(0, eklenecekDers);
                    ortalamaHesapla();
                    setState(() {});
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppConstants.anaRenk,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormFiled() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Boş bırakma ders adını';
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
          borderRadius: AppConstants.borderRadius,
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
        fillColor: AppConstants.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  Widget _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppConstants.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: AppConstants.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumKrediler(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenKredi = dd!;
            print(dd);
          });
        },
        value: secilenKredi,
      ),
    );
  }

  Widget _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppConstants.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        iconEnabledColor: AppConstants.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumDersHarfleri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilen = dd!;
            print(dd);
          });
        },
        value: secilen,
      ),
    );
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    tumDersler.forEach((element) {
      toplamNot = toplamNot + (element.krediDegeri * element.harfDegeri);
      toplamKredi = toplamKredi + element.krediDegeri;
    });
    return toplamNot / toplamKredi;
  }
}
