use sys;


/* ======================== ALIASES ===========================
   Aliases kodu ile tablo yazdirilirken, field isimleri sadece
   o cikti icin degistirilebilir.
===============================================================*/
CREATE TABLE employees
(
employee_id char(9),
employee_name varchar(50),
employee_birth_city varchar(50)
);
INSERT INTO employees VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO employees VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO employees VALUES(345678901, 'Mine Bulut', 'Izmir');
select* from employees;
SELECT employee_id AS id, employee_name AS name, employee_birth_city AS city
FROM employees;
/* ======================== GROUP BY CLAUSE ===========================
   Group By komutu sonuclari bir veya daha fazla sutuna gore
   gruplamak icin SELECT komutuyla birlikte kullanilir.
   
   GROUP BY komutu her grup basina bir satir dondurur.
   
   GROUP BY AGGREGATE fonksiyonlariyla birlikte kullanilir.
======================================================================*/  
CREATE TABLE manav (
    isim VARCHAR(50),
    urun_adi VARCHAR(50),
    urun_miktar INT
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);
INSERT INTO manav VALUES( 'Ali', null, 2);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 1);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 4);
INSERT INTO manav VALUES( 'Ayse', null, 3);
SELECT * FROM manav;
-- -----**********************************
-- 1 isme göre alınan urunlerin toplam kilosunu bulup,
--  isim sirasina gore siralayın.
select isim, sum(urun_miktar) as toplam_kg
from manav
group by isim
order by isim;

-- 2) Isme gore, alinan urunlerin toplam kilosunu bulup,
-- isim sirasina gore ters siralayin.
SELECT isim, SUM(urun_miktar) AS top_kg
FROM manav
GROUP BY isim
ORDER BY isim DESC;

-- 3) Bunlari bir de toplam kiloya gore ters sirali yapalim
SELECT isim, SUM(urun_miktar) AS top_kg
FROM manav
GROUP BY isim
ORDER BY top_kg DESC;

-- 4) Urun ismine gore, urunu alan toplam kisi sayisini,
-- kisi sayisina gore siralayiniz.
select urun_adi, count(isim) as urun_alan_top_kisi
from manav
group by urun_adi
order by urun_alan_top_kisi;

-- 5) Alinan kilo miktarina gore musteri sayisini listeleyiniz.
select urun_miktar, count(isim) musteri
from manav
group by urun_miktar;

-- 6) Satilan meyve turune (urun_adi) gore urun alan kisi sayisini
-- NATURAL ORDER'a gore gosteren QUERY yaziniz.
-- NULL olarak girilen meyveyi listelemesin.
select urun_adi, count(isim) kisi_sayisi
from manav
where urun_adi is not null
group by urun_adi
order by urun_adi;

-- 7) Satilan meyvenin 4 harfli olmasina (urun_adi) gore urun alan kisi sayisini,
-- urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz.
select urun_adi, count(isim) kisi_sayisi
from manav
where urun_adi like '____'
group by urun_adi
order by urun_adi;

-- 8) Satilan meyve turune (urun_adi) gore satilan (urun_miktari)
-- MIN ve MAX urun miktarlarini, MAX urun miktarina gore siralayarak
-- listeleyen OUERY yaziniz.
-- NULL olarak girilen meyveyi listelemesin.
select urun_adi, max(urun_miktar)urun_max,min(urun_miktar)urun_min
from manav
where urun_adi is not null
group by urun_adi
order by urun_max desc;


-- 8) Kisi ismine ve urun_adina gore satilan urunlerin toplamini
-- gruplandiran ve isime gore ters sirada listeleyen QUERY yaziniz.
