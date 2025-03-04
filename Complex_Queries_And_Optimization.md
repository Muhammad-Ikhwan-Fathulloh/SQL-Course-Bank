# **Complex Queries & Optimization**

## **1. Agregasi Data**

### **1.1 Fungsi Agregasi**
Fungsi agregasi digunakan untuk melakukan perhitungan pada sekumpulan data dan mengembalikan satu nilai hasil perhitungan.

- **COUNT:** Menghitung jumlah baris yang memenuhi kondisi tertentu.
  ```sql
  SELECT COUNT(*) FROM pelanggan;
  ```

- **SUM:** Menjumlahkan nilai dalam kolom tertentu.
  ```sql
  SELECT SUM(total_harga) FROM transaksi;
  ```

- **AVG:** Menghitung rata-rata nilai dalam kolom tertentu.
  ```sql
  SELECT AVG(harga) FROM produk;
  ```

- **MIN:** Menemukan nilai terkecil dalam kolom tertentu.
  ```sql
  SELECT MIN(harga) FROM produk;
  ```

- **MAX:** Menemukan nilai terbesar dalam kolom tertentu.
  ```sql
  SELECT MAX(harga) FROM produk;
  ```

### **1.2 GROUP BY dan HAVING**
- **GROUP BY:** Mengelompokkan baris yang memiliki nilai yang sama ke dalam baris ringkasan.
  ```sql
  SELECT kategori_id, AVG(harga) 
  FROM produk 
  GROUP BY kategori_id;
  ```

- **HAVING:** Digunakan untuk memfilter hasil agregasi (mirip dengan WHERE, tetapi untuk GROUP BY).
  ```sql
  SELECT kategori_id, AVG(harga) 
  FROM produk 
  GROUP BY kategori_id 
  HAVING AVG(harga) > 100000;
  ```

## **2. Tabel Joins**

### **2.1 Jenis Join**
- **INNER JOIN:** Mengembalikan baris yang memiliki nilai yang cocok di kedua tabel.
  ```sql
  SELECT pelanggan.nama, transaksi.total_harga 
  FROM transaksi 
  INNER JOIN pelanggan ON transaksi.pelanggan_id = pelanggan.id;
  ```

- **LEFT JOIN (LEFT OUTER JOIN):** Mengembalikan semua baris dari tabel kiri (tabel pertama) dan baris yang cocok dari tabel kanan (tabel kedua). Jika tidak ada yang cocok, hasilnya adalah NULL di sisi kanan.
  ```sql
  SELECT pelanggan.nama, transaksi.total_harga 
  FROM pelanggan 
  LEFT JOIN transaksi ON pelanggan.id = transaksi.pelanggan_id;
  ```

- **RIGHT JOIN (RIGHT OUTER JOIN):** Mengembalikan semua baris dari tabel kanan dan baris yang cocok dari tabel kiri. Jika tidak ada yang cocok, hasilnya adalah NULL di sisi kiri.
  ```sql
  SELECT pelanggan.nama, transaksi.total_harga 
  FROM transaksi 
  RIGHT JOIN pelanggan ON transaksi.pelanggan_id = pelanggan.id;
  ```

- **FULL JOIN (FULL OUTER JOIN):** Mengembalikan semua baris ketika ada kecocokan di salah satu tabel. Jika tidak ada yang cocok, hasilnya adalah NULL di sisi yang tidak memiliki kecocokan.
  ```sql
  SELECT pelanggan.nama, transaksi.total_harga 
  FROM pelanggan 
  FULL JOIN transaksi ON pelanggan.id = transaksi.pelanggan_id;
  ```

## **3. Subqueries**

### **3.1 Apa itu Subquery?**
Subquery adalah query di dalam query lain. Subquery dapat digunakan di dalam SELECT, INSERT, UPDATE, atau DELETE.

- **Contoh Subquery dalam SELECT:**
  ```sql
  SELECT nama 
  FROM pelanggan 
  WHERE id IN (SELECT pelanggan_id FROM transaksi WHERE total_harga > 500000);
  ```

- **Contoh Subquery dalam WHERE:**
  ```sql
  SELECT nama, harga 
  FROM produk 
  WHERE harga > (SELECT AVG(harga) FROM produk);
  ```

## **4. Window Functions**

### **4.1 Fungsi Analitik**
Window functions memungkinkan Anda melakukan perhitungan pada sekumpulan baris yang terkait dengan baris saat ini.

- **ROW_NUMBER():** Memberikan nomor urut untuk setiap baris dalam partisi.
  ```sql
  SELECT nama, harga, ROW_NUMBER() OVER (ORDER BY harga DESC) 
  FROM produk;
  ```

- **RANK():** Memberikan peringkat untuk setiap baris dalam partisi, dengan peringkat yang sama untuk nilai yang sama.
  ```sql
  SELECT nama, harga, RANK() OVER (ORDER BY harga DESC) 
  FROM produk;
  ```

- **OVER():** Menentukan partisi dan urutan untuk window function.
  ```sql
  SELECT nama, harga, AVG(harga) OVER (PARTITION BY kategori_id) 
  FROM produk;
  ```

## **5. Optimasi Query**

### **5.1 Indexing**
Indexing digunakan untuk mempercepat query dengan membuat struktur data yang memungkinkan database menemukan baris tertentu dengan cepat.

- **Membuat Index:**
  ```sql
  CREATE INDEX idx_pelanggan_nama ON pelanggan(nama);
  ```

- **Menghapus Index:**
  ```sql
  DROP INDEX idx_pelanggan_nama;
  ```

  Jika indeks `idx_pelanggan_nama` sudah dibuat pada tabel `pelanggan` dengan kolom `nama`, maka indeks ini akan digunakan oleh database untuk mempercepat pencarian data berdasarkan kolom `nama`.  

### **Cara Menggunakan Indeks dalam Query**
Indeks akan otomatis digunakan oleh database saat Anda menjalankan query yang memanfaatkan kolom `nama`, misalnya:

#### **1. Query Pencarian dengan WHERE**
```sql
SELECT * FROM pelanggan WHERE nama = 'Budi';
```
Karena kolom `nama` sudah diindeks, database akan menggunakan indeks untuk mempercepat pencarian `Budi` dalam tabel `pelanggan`.

#### **2. Query dengan LIKE (Tergantung Pola)**
Indeks akan digunakan jika pencarian tidak diawali dengan `%`:
```sql
SELECT * FROM pelanggan WHERE nama LIKE 'Bud%'; -- Indeks digunakan
SELECT * FROM pelanggan WHERE nama LIKE '%udi'; -- Indeks tidak digunakan
```
Pola dengan `%` di awal tidak dapat menggunakan indeks karena membutuhkan full table scan.

#### **3. Query dengan ORDER BY**
Jika query menggunakan `ORDER BY nama`, indeks dapat digunakan untuk menghindari sorting tambahan:
```sql
SELECT * FROM pelanggan ORDER BY nama;
```

#### **4. Query dengan JOIN**
Jika tabel `pelanggan` di-`JOIN` dengan tabel lain berdasarkan `nama`, indeks dapat mempercepat proses:
```sql
SELECT o.id, p.nama 
FROM orders o
JOIN pelanggan p ON o.nama_pelanggan = p.nama;
```

#### **5. Cek Apakah Indeks Digunakan dengan EXPLAIN**
Anda bisa mengecek apakah indeks digunakan dalam query dengan `EXPLAIN`:
```sql
EXPLAIN SELECT * FROM pelanggan WHERE nama = 'Budi';
```
Jika indeks digunakan, akan muncul `idx_pelanggan_nama` di kolom `possible_keys` atau `key`.

---  
### **Catatan**  
- Indeks mempercepat **pencarian** tetapi **memperlambat INSERT, UPDATE, dan DELETE** karena database harus memperbarui indeks.  
- Jika indeks tidak digunakan dalam query tertentu, pertimbangkan **menganalisis struktur indeks dan query**.  

### **5.2 Execution Plan**
Execution plan digunakan untuk menganalisis performa query dengan melihat bagaimana database akan mengeksekusi query tersebut.

- **Menggunakan EXPLAIN:**
  ```sql
  EXPLAIN SELECT * FROM pelanggan WHERE kota = 'Jakarta';
  ```

## **6. Best Practices**

### **6.1 Hindari SELECT ***
Gunakan kolom spesifik daripada `SELECT *` untuk mengurangi beban pada database.
```sql
SELECT nama, email FROM pelanggan;
```

### **6.2 Gunakan LIMIT**
Gunakan `LIMIT` untuk membatasi jumlah baris yang dikembalikan, terutama saat melakukan pengujian.
```sql
SELECT * FROM produk LIMIT 10;
```

### **6.3 Normalisasi Database**
Normalisasi adalah proses mengorganisasi data dalam database untuk mengurangi redundansi dan meningkatkan integritas data.

- **Bentuk Normal:**
  - **1NF (First Normal Form):** Setiap kolom berisi nilai atomik.
  - **2NF (Second Normal Form):** Memenuhi 1NF dan semua kolom non-kunci sepenuhnya bergantung pada primary key.
  - **3NF (Third Normal Form):** Memenuhi 2NF dan semua kolom non-kunci tidak bergantung pada kolom non-kunci lainnya.
