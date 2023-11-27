### 👨‍🦲 Nama Anggota Kelompok 
- Aggitya Yosafat Hutabarat (2206082902)
- Catur Wira Mukti Nugroho (2206083483)
- Dyandra Nadine Zahira (2206028264)
- Gina Afia (2206830334)
- Muhammad Hanif (2206029941)
---

### 📱 Tema Aplikasi: Perpustakaan Buku Lawas.apk
---

### 🍎 Nama Aplikasi: AncestralReads

[Referensi berdasarkan Web TK PTS](https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/)

---
### 💾 Cerita Aplikasi

🔈Latar Belakang:

Dalam era digital ini, kebiasaan membaca buku dibawah abad 21 semakin tergeser oleh buku modern. Buku-buku lawas yang memiliki nilai sejarah dan kebudayaan seringkali terlupakan. Oleh karena itu, proyek pembuatan website perpustakaan online buku lawas memiliki latar belakang yang penting, relevan untuk memicu bangkitnya minat membaca buku lawas, dan menyadarkan pentingnya membaca buku lawas karena buku-buku inilah sumber evolusi menuju peradaban buku modern. Beberapa alasan utama dibalik pemilihan proyek ini adalah meningkatkan minat baca, terutama buku yang sudah tua atau lawas agar tidak menghilang, melestarikan warisan buku yang sudah ada sedari dulu agar warisannya tidak terputus, mampu memahami perubahan pola penulisan buku dari zaman ke zaman, serta mendorong penelitian dan kreativitas.

📻 Manfaat:
Manfaat dari website ini adalah pembaca dapat mengakses buku-buku yang diterbitkan pada periode terdahulu jauh sebelum masa modern, yaitu sebelum abad ke-21. Dengan membaca buku-buku terdahulu, pembaca dapat memahami suatu infromasi atau pengetahuan dari sudut pandang masyarakat pada periode yang berbeda, mengetahui teknologi dan budaya pada masa tersebut, serta dapat memahami bentuk permasalahan yang dihadapi pada periode terdahulu sekaligus memahami cara berpikir masyarakatnya lewat problem solving yang dilakukan. Tak hanya itu, pembaca dapat memperluas pemahaman berbahasa, mengingat bahwa bahasa dan susunan kosakata terdahulu lebih kompleks. Manfaat lain dari membaca buku-buku terbitan lama yaitu pembaca turut melestarikan karya-karya sastra bersejarah yang bisa saja hilang atau terlupakan.

---
### 📓 Modul
:unlock:**Autentikasi dan Otorisasi** - Catur Wira Mukti Nugroho
Penjelasan:
- Mengatur registrasi, login, dan logout pengguna.
- engguna (member) memiliki otorisasi berupa dapat meminjam buku (bookmark), mengajukan request buku, memberi rating dan review buku, serta membuat booklist milik pribadi.
- Pustakawan (admin) memiliki otorisasi berupa melakukan pengelolaan buku, seperti menambah dan mengurangi stok buku.

:books:**Pengelolaan koleksi buku (Pustakawan)** - Catur Wira Mukti Nugroho
Penjelasan:
- Halaman ini berisi pilihan untuk menambahkan buku baru ke dalam perpustakaan, menghapus buku yang sudah ada dari daftar buku perpustakaan, serta mengubah deskripsi buku. Halaman ini hanya dapat digunakan oleh pustakawan.

:stars:**Rating dan Review Buku** - Dyandra Nadine Zahira
Penjelasan: 
- Halaman ini berisi Fitur rating & review dimana pembaca dapat memberi rating & review terhadap buku-buku dalam katalog. 

:ledger:**Halaman Bookmark Member** - Gina Afia
Penjelasan:
- Halaman ini berisi daftar judul-judul buku yang akan/ingin dibaca oleh pengguna. Judul buku akan hilang apabila pengguna menekan tombol ‘unbookmark’.

:hearts:**Booklist (Daftar shortlist buku yang disukai)** - Muhammad Hanif
Penjelasan: 
- Role member dapat membuat daftar buku yang disukai atau dalam antrean untuk dipinjam lalu dimasukkan ke dalam satu tabel dimana buku dari dataset default bisa di add dan di delete sesuai keinginan user member.
		
:sos:**Request Buku** - Aggitya Yosafat Hutabarat
Penjelasan:
- Halaman ini berisi request peminjam akan judul buku yang belum ada di perpustakaan.

:open_file_folder:---***Sumber dataset Katalog Buku***---:open_file_folder:

:paperclip: https://drive.google.com/file/d/17jiAwHx_68zUrolbTl75IoLRFK_JLYrx/view 


### 📛 Role

👦👧User Biasa (Member): Memasukkan judul buku yang ingin dibaca pada halaman bookmark, menghapus buku yang sudah tidak dibaca, memberi ulasan buku, mengajukan request pengadaan suatu buku.

👵Pustakawan (Admin): Menambahkan buku baru, menghapus buku, dan mengedit keterangan buku.

🙍Tamu (Guest): Melihat daftar buku yang ada pada aplikasi.

---
### Alur Integrasi dengan Web Service Aplikasi Web

Berikut adalah langkah-langkah yang akan dilakukan untuk mengintegrasikan aplikasi dengan server web:
- Membuat applikasi baru pada proyek tengah semester untuk melakukan pengolahan request dari aplikasi flutter yang akan dibuat agar dapat dilakukan proses create model, fetching data dalam bentuk JSON, serta otentikasi.
- Membuat model item yang akan digunakan pada flutter yang merupakan proses konversi data yang diterima dalam bentuk JSON.

- Mengimplementasikan sebuah wrapper class dengan menggunakan library http dan map untuk mendukung penggunaan cookie-based authentication pada aplikasi.
- Mengimplementasikan REST API pada Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer.
- Mengimplementasikan desain front-end untuk aplikasi berdasarkan desain website yang sudah ada sebelumnya.
- Melakukan integrasi antara front-end dengan back-end dengan menggunakan konsep asynchronous HTTP.
---
### 🔗:**Tautan Berita Acara**
[Berita Acara](https://docs.google.com/spreadsheets/d/1zmUzPm34MB2xwXZVjVh4mSuMAWh0hM1XZBRv8MRpI2g/edit?usp=sharing)
