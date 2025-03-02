# **SQL Fundamentals**

## **1. Pengenalan SQL & Database**

### **1.1 Apa itu SQL?**
SQL (Structured Query Language) adalah bahasa pemrograman yang digunakan untuk mengelola dan memanipulasi data dalam database relasional. SQL memungkinkan pengguna untuk melakukan operasi seperti membuat, membaca, memperbarui, dan menghapus data (CRUD - Create, Read, Update, Delete).

### **1.2 Perbedaan Tabel, Kolom, dan Baris**
- **Tabel:** Struktur data yang terdiri dari baris dan kolom. Tabel digunakan untuk menyimpan data yang terkait dalam database.
- **Kolom:** Atribut atau field yang mendefinisikan jenis data yang disimpan dalam tabel. Misalnya, dalam tabel `pelanggan`, kolomnya bisa berupa `id`, `nama`, `email`, dan `kota`.
- **Baris:** Entri atau record dalam tabel yang berisi data aktual. Misalnya, satu baris dalam tabel `pelanggan` bisa berisi data seorang pelanggan dengan nama "Ali Sari", email "ali@example.com", dan kota "Jakarta".

### **1.3 Fungsi Database dan SQL**
- **Database:** Tempat penyimpanan data yang terorganisir, memungkinkan akses, pengelolaan, dan pembaruan data secara efisien.
- **SQL:** Bahasa yang digunakan untuk berinteraksi dengan database, memungkinkan pengguna untuk melakukan query, mengupdate, dan mengelola data.

### **1.4 Jenis Database**
- **SQL (Relational Database):**
  - **PostgreSQL:** Open-source, mendukung transaksi kompleks, cocok untuk analisis data.
  - **MySQL:** Populer untuk aplikasi web, mudah digunakan.
  - **SQL Server:** Dikembangkan oleh Microsoft, cocok untuk aplikasi enterprise.
- **NoSQL (Non-Relational Database):**
  - **MongoDB:** Berbasis dokumen, cocok untuk data yang tidak terstruktur.
  - **Elasticsearch:** Dirancang untuk pencarian dan analisis data real-time.

### **1.5 Mengapa Menggunakan PostgreSQL?**
- **Mendukung Transaksi Kompleks:** PostgreSQL mendukung ACID (Atomicity, Consistency, Isolation, Durability) yang penting untuk transaksi yang kompleks.
- **Open-source dengan Fitur Enterprise:** PostgreSQL adalah open-source tetapi memiliki fitur yang biasanya ditemukan di database enterprise.
- **Cocok untuk Analisis Data:** PostgreSQL memiliki dukungan yang kuat untuk analisis data, termasuk fungsi agregasi dan window functions.

## **2. Studi Kasus: Sistem Manajemen Toko Online**

### **2.1 Latar Belakang**
Sebuah toko online ingin menyimpan data pelanggan, produk, dan transaksi penjualan. Mereka ingin bisa menampilkan daftar produk, mencari pelanggan berdasarkan lokasi, serta menganalisis jumlah transaksi berdasarkan kategori produk.

## **3. Membuat Database di Aiven.io & Koneksi DBeaver**

### **3.1 Langkah-langkah Membuat Database di Aiven.io**
1. **Buat Akun di [Aiven.io](https://aiven.io):** Daftar dan buat akun baru.
2. **Buat Instance PostgreSQL:** Setelah login, buat instance PostgreSQL baru.
3. **Dapatkan Credential PostgreSQL:** Setelah instance dibuat, Aiven akan memberikan credential seperti host, username, dan password.
4. **Hubungkan ke DBeaver:**
   - Buka DBeaver dan pilih PostgreSQL sebagai database.
   - Masukkan host, username, dan password yang diberikan oleh Aiven.
   - Uji koneksi dan mulai eksekusi SQL.

## **4. Membuat Tabel Database**

### **4.1 Struktur Database**
- **pelanggan** (id, nama, email, kota)
- **produk** (id, nama, harga, stok, kategori_id)
- **kategori** (id, nama_kategori)
- **transaksi** (id, pelanggan_id, produk_id, jumlah, total_harga, tanggal)

### **4.2 SQL untuk Membuat Tabel**
```sql
CREATE TABLE pelanggan (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100),
    email VARCHAR(100),
    kota VARCHAR(50)
);

CREATE TABLE kategori (
    id SERIAL PRIMARY KEY,
    nama_kategori VARCHAR(50)
);

CREATE TABLE produk (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100),
    harga DECIMAL(10,2),
    stok INT,
    kategori_id INT REFERENCES kategori(id)
);

CREATE TABLE transaksi (
    id SERIAL PRIMARY KEY,
    pelanggan_id INT REFERENCES pelanggan(id),
    produk_id INT REFERENCES produk(id),
    jumlah INT,
    total_harga DECIMAL(10,2),
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## **5. Memasukkan Data ke dalam Tabel**

### **5.1 SQL untuk Memasukkan Data**
```sql
INSERT INTO pelanggan (nama, email, kota) VALUES 
('Ali Sari', 'ali@example.com', 'Jakarta'),
('Budi', 'budi@example.com', 'Bandung');

INSERT INTO kategori (nama_kategori) VALUES 
('Elektronik'), ('Fashion'), ('Makanan');

INSERT INTO produk (nama, harga, stok, kategori_id) VALUES 
('Laptop', 7000000, 10, 1),
('Baju', 150000, 50, 2),
('Snack', 25000, 100, 3);

INSERT INTO transaksi (pelanggan_id, produk_id, jumlah, total_harga) VALUES 
(1, 1, 1, 7000000),
(2, 2, 3, 450000);
```

## **6. Basic Query dengan SELECT**

### **6.1 Sintaks Dasar SELECT**
```sql
SELECT nama, email FROM pelanggan;
```
- **SELECT:** Memilih kolom yang ingin ditampilkan.
- **FROM:** Menentukan tabel dari mana data akan diambil.

### **6.2 Contoh Query dengan WHERE**
```sql
SELECT * FROM produk WHERE harga > 100000;
```
- **WHERE:** Digunakan untuk memfilter data berdasarkan kondisi tertentu.

## **7. Filtering Data**

### **7.1 Operator Logika: AND, OR, NOT**
```sql
SELECT * FROM pelanggan WHERE kota = 'Jakarta' AND email LIKE '%example.com';
```
- **AND:** Menampilkan data yang memenuhi semua kondisi.
- **OR:** Menampilkan data yang memenuhi salah satu kondisi.
- **NOT:** Menampilkan data yang tidak memenuhi kondisi.

### **7.2 Wildcard: LIKE**
```sql
SELECT * FROM produk WHERE nama LIKE '%Laptop%';
```
- **LIKE:** Digunakan untuk pencarian berdasarkan pola. `%` adalah wildcard yang berarti "nol atau lebih karakter".

## **8. Sorting Data**

### **8.1 ORDER BY**
```sql
SELECT * FROM produk ORDER BY harga DESC;
```
- **ORDER BY:** Mengurutkan data berdasarkan kolom tertentu.
- **ASC:** Ascending (urutan naik).
- **DESC:** Descending (urutan turun).

## **9. Latihan Praktis SQL Fundamental**

### **9.1 Latihan 1: Menampilkan Data Pelanggan dari Kota Tertentu**
```sql
SELECT * FROM pelanggan WHERE kota = 'Bandung';
```

### **9.2 Latihan 2: Menampilkan Produk dengan Harga di Atas 1 Juta**
```sql
SELECT * FROM produk WHERE harga > 1000000;
```

### **9.3 Latihan 3: Menampilkan Transaksi dengan Total Harga Tertinggi**
```sql
SELECT * FROM transaksi ORDER BY total_harga DESC LIMIT 1;
```

### **9.4 Latihan 4: Menampilkan Produk dari Kategori Elektronik**
```sql
SELECT * FROM produk WHERE kategori_id = 1;
```

### **9.5 Latihan 5: Menampilkan Nama Pelanggan dan Produk yang Dibeli**
```sql
SELECT pelanggan.nama, produk.nama 
FROM transaksi 
JOIN pelanggan ON transaksi.pelanggan_id = pelanggan.id 
JOIN produk ON transaksi.produk_id = produk.id;
```
