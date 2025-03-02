# **SQL Fundamentals**

### **1.1 Pengenalan SQL & Database**  
- **Apa itu SQL?** Bahasa untuk mengelola data di database.  
- **Perbedaan tabel, kolom, dan baris.**  
- **Fungsi Database dan SQL**  
- **Jenis Database:**  
  - **SQL:** PostgreSQL, MySQL, SQL Server.  
  - **NoSQL:** MongoDB, Elasticsearch.  
- **Mengapa menggunakan PostgreSQL?**  
  - Mendukung transaksi yang lebih kompleks.  
  - Open-source dengan fitur enterprise.  
  - Cocok untuk analisis data.  

### **1.2 Studi Kasus: Sistem Manajemen Toko Online**  
#### **Latar Belakang**  
Sebuah toko online ingin menyimpan data pelanggan, produk, dan transaksi penjualan. Mereka ingin bisa menampilkan daftar produk, mencari pelanggan berdasarkan lokasi, serta menganalisis jumlah transaksi berdasarkan kategori produk.  

### **1.3 Membuat Database di Aiven.io & Koneksi DBeaver**  
1. **Buat akun di [Aiven.io](https://aiven.io).**  
2. **Buat instance PostgreSQL.**  
3. **Dapatkan credential PostgreSQL.**  
4. **Hubungkan ke DBeaver:**  
   - Pilih PostgreSQL sebagai database.  
   - Masukkan host, username, password dari Aiven.  
   - Uji koneksi dan mulai eksekusi SQL.  

### **1.4 Membuat Tabel Database**  
#### **Struktur Database:**  
- **pelanggan** (id, nama, email, kota)  
- **produk** (id, nama, harga, stok, kategori_id)  
- **kategori** (id, nama_kategori)  
- **transaksi** (id, pelanggan_id, produk_id, jumlah, total_harga, tanggal)  

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

### **1.5 Memasukkan Data ke dalam Tabel**  
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

### **1.6 Basic Query dengan SELECT**  
```sql
SELECT nama, email FROM pelanggan;
SELECT * FROM produk WHERE harga > 100000;
```

### **1.7 Filtering Data**  
```sql
SELECT * FROM pelanggan WHERE kota = 'Jakarta';
SELECT * FROM produk WHERE nama LIKE '%Laptop%';
```

### **1.8 Sorting Data**  
```sql
SELECT * FROM produk ORDER BY harga DESC;
```
