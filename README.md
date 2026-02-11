## Refleksi Penggunaan Single Responsibility Principle (SRP)

Penerapan prinsip Single Responsibility Principle (SRP) sangat membantu
saat menambahkan fitur History Logger pada aplikasi ini.

Karena sejak awal logika aplikasi dipisahkan ke dalam CounterController
dan tampilan berada di CounterView, penambahan fitur riwayat dapat
dilakukan hanya dengan memodifikasi Controller tanpa harus mengubah
struktur tampilan secara besar-besaran.

Controller bertanggung jawab penuh terhadap:
- Perhitungan nilai counter
- Penyimpanan step
- Pencatatan riwayat aktivitas

Sedangkan View hanya bertugas:
- Menampilkan data
- Menerima input user
- Memberikan feedback visual (warna, dialog, snackbar)

Dengan pemisahan ini, kode menjadi lebih mudah dipahami, dirawat,
dan dikembangkan. Jika aplikasi berkembang menjadi lebih besar,
pendekatan ini akan mengurangi bug dan mempermudah penambahan fitur baru.