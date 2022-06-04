import 'package:flutter/material.dart';
import 'package:kelompok/bloc/produk_bloc.dart';
import 'package:kelompok/utils/class.dart';
import 'package:kelompok/utils/data.dart';
import 'package:kelompok/screens/home.dart';
import 'package:kelompok/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  Recipe? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _id = TextEditingController();
  final _name = TextEditingController();
  final _image = TextEditingController();
  final _steps = TextEditingController();
  final _ingredients = TextEditingController();
  final _nutrients = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _id.text = widget.produk!.id.toString();
        _name.text = widget.produk!.title;
        _image.text = widget.produk!.imageUrl;
        _steps.text = widget.produk!.steps.toString();
        _nutrients.text = widget.produk!.nutrients.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _idTextField(),
                _nameTextField(),
                _imageTextField(),
                _stepsTextField(),
                _nutrientsTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Produk
  Widget _idTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Id Produk"),
      keyboardType: TextInputType.text,
      controller: _id,
      validator: (value) {
        if (value!.isEmpty) {
          return "Id harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Produk
  Widget _nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Resep harus diisi";
        }
        return null;
      },
    );
  }

  Widget _imageTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Link Image"),
      keyboardType: TextInputType.number,
      controller: _image,
      validator: (value) {
        if (value!.isEmpty) {
          return "Gambar harus diisi";
        }
        return null;
      },
    );
  }

  Widget _stepsTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Langkah"),
      keyboardType: TextInputType.number,
      controller: _steps,
      validator: (value) {
        if (value!.isEmpty) {
          return "Steps harus diisi";
        }
        return null;
      },
    );
  }

  Widget _nutrientsTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nutrients"),
      keyboardType: TextInputType.number,
      controller: _nutrients,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nutrisi harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Recipe createProduk = Recipe(
        id: int.parse(_id.text),
        title: _name.text,
        imageUrl: _image.text,
        nutrients: [],
        ingredients: [],
        steps: []);

    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Recipe updateProduk = Recipe(
        id: widget.produk!.id,
        title: _name.text,
        imageUrl: _image.text,
        steps: [],
        nutrients: [],
        ingredients: []);

    setState(() {
      _isLoading = false;
    });
  }
}
