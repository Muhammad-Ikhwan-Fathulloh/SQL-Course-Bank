-- Pastikan menggunakan database defaultdb
\c defaultdb;

-- Pastikan menggunakan skema public
SET search_path TO public;

-- 1. Membuat tabel nasabah
CREATE TABLE IF NOT EXISTS public.nasabah (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(200) NOT NULL,
    no_telepon VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Membuat tabel rekening
CREATE TABLE IF NOT EXISTS public.rekening (
    id SERIAL PRIMARY KEY,
    nasabah_id INT REFERENCES public.nasabah(id) ON DELETE CASCADE,
    no_rekening VARCHAR(20) UNIQUE NOT NULL,
    saldo DECIMAL(15,2) NOT NULL CHECK (saldo >= 0)
);

-- 3. Membuat tabel jenis_transaksi
CREATE TABLE IF NOT EXISTS public.jenis_transaksi (
    id SERIAL PRIMARY KEY,
    nama_transaksi VARCHAR(50) UNIQUE NOT NULL
);

-- 4. Membuat tabel transaksi
CREATE TABLE IF NOT EXISTS public.transaksi (
    id SERIAL PRIMARY KEY,
    rekening_id INT REFERENCES public.rekening(id) ON DELETE CASCADE,
    jenis_transaksi_id INT REFERENCES public.jenis_transaksi(id) ON DELETE CASCADE,
    jumlah DECIMAL(15,2) NOT NULL CHECK (jumlah > 0),
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Mengecek tabel yang sudah dibuat
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- Menyisipkan data nasabah
INSERT INTO public.nasabah (nama, alamat, no_telepon, email) VALUES 
('Ali Sari', 'Jl. Merdeka No. 1, Jakarta', '081234567890', 'ali@example.com'),
('Budi', 'Jl. Pahlawan No. 2, Bandung', '081234567891', 'budi@example.com'),
('Citra', 'Jl. Sudirman No. 3, Surabaya', '081234567892', 'citra@example.com');

-- Menyisipkan data rekening
INSERT INTO public.rekening (nasabah_id, no_rekening, saldo) VALUES 
(1, '1234567890', 10000000.00),
(2, '1234567891', 5000000.00),
(3, '1234567892', 7500000.00);

-- Menyisipkan data jenis_transaksi
INSERT INTO public.jenis_transaksi (nama_transaksi) VALUES 
('Setor Tunai'),
('Tarik Tunai'),
('Transfer');

-- Menyisipkan data transaksi
INSERT INTO public.transaksi (rekening_id, jenis_transaksi_id, jumlah) VALUES 
(1, 1, 2000000.00),  -- Setor Tunai
(2, 2, 1000000.00),  -- Tarik Tunai
(3, 3, 500000.00);   -- Transfer
