import 'package:flutter/material.dart';
import 'package:my_flutter_project/Bloc/bloc_produk.dart';
import 'package:my_flutter_project/Model/Produk/model_produk.dart';
import 'package:my_flutter_project/Ui/Produk/Produk_detail.dart';
import 'package:my_flutter_project/Ui/Produk/Produk_page.dart';
import 'package:my_flutter_project/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String judul;
  late String tombolSubmit;

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  final _jenisProdukTextboxController = TextEditingController();
  final _stokProdukTextboxController = TextEditingController();
  final _tanggalProdukTextboxController = TextEditingController();
  final _warnaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      judul = "UBAH PRODUK";
      tombolSubmit = "UBAH";
      _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
      _namaProdukTextboxController.text = widget.produk!.namaProduk!;
      _hargaProdukTextboxController.text =
          widget.produk!.hargaProduk.toString();
      _jenisProdukTextboxController.text = widget.produk!.jenisProduk!;
      _stokProdukTextboxController.text = widget.produk!.stokProduk!;
      _tanggalProdukTextboxController.text =
          widget.produk!.tanggalProduk.toString();
      _warnaProdukTextboxController.text = widget.produk!.warnaProduk!;
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
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _jenisProdukTextField(),
                _stokProdukTextField(),
                _tanggalProdukTextField(),
                _warnaProdukTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jenisProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jenis Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _stokProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Stok Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Stok Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Produksi Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Produksi Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _warnaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Warna Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Warna Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) {
          if (widget.produk != null) {
            // Update produk
            ubah();
          } else {
            // Tambah produk
            simpan();
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: null);
    updateProduk.id = widget.produk!.id;
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
