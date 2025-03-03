-- Pastikan menggunakan database defaultdb
\c defaultdb;

-- Pastikan menggunakan skema public
SET search_path TO public;

-- 1. Membuat tabel pelanggan
CREATE TABLE IF NOT EXISTS public.pelanggan (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    kota VARCHAR(50) NOT NULL
);

-- Mengecek tabel yang sudah dibuat
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- 2. Membuat tabel kategori
CREATE TABLE IF NOT EXISTS public.kategori (
    id SERIAL PRIMARY KEY,
    nama_kategori VARCHAR(50) UNIQUE NOT NULL
);

-- Mengecek tabel yang sudah dibuat
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- 3. Membuat tabel produk (terkait dengan kategori)
CREATE TABLE IF NOT EXISTS public.produk (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL CHECK (harga >= 0),
    stok INT NOT NULL CHECK (stok >= 0),
    kategori_id INT REFERENCES public.kategori(id) ON DELETE CASCADE
);

-- Mengecek tabel yang sudah dibuat
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- 4. Membuat tabel transaksi (terkait dengan pelanggan dan produk)
CREATE TABLE IF NOT EXISTS public.transaksi (
    id SERIAL PRIMARY KEY,
    pelanggan_id INT REFERENCES public.pelanggan(id) ON DELETE CASCADE,
    produk_id INT REFERENCES public.produk(id) ON DELETE CASCADE,
    jumlah INT NOT NULL CHECK (jumlah > 0),
    total_harga DECIMAL(10,2) NOT NULL CHECK (total_harga >= 0),
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Mengecek tabel yang sudah dibuat
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
