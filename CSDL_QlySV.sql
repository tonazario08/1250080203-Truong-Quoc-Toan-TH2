-- ============================================================
--  CSDL_QlySV.sql
--  CSDL Quan ly Diem Sinh Vien
--  User: TruongQuocToan
--  Chay: @CSDL_QlySV.sql
-- ============================================================

-- Xoa bang cu neu ton tai (theo thu tu FK nguoc)
DROP TABLE KETQUA  CASCADE CONSTRAINTS PURGE;
DROP TABLE DMSV    CASCADE CONSTRAINTS PURGE;
DROP TABLE DMMH    CASCADE CONSTRAINTS PURGE;
DROP TABLE DMKHOA  CASCADE CONSTRAINTS PURGE;

-- ============================================================
-- TAO BANG
-- ============================================================

-- ---- Tao bang DMKHOA ----
CREATE TABLE DMKHOA (
    MAKHOA  CHAR(2)        CONSTRAINT dmkhoa_makhoa_pk PRIMARY KEY,
    TENKHOA NVARCHAR2(30)
);

-- ---- Tao bang DMMH ----
CREATE TABLE DMMH (
    MAMH   CHAR(2)        CONSTRAINT dmmh_mamh_pk PRIMARY KEY,
    TENMH  NVARCHAR2(35),
    SOTIET NUMBER(3)
);

-- ---- Tao bang DMSV ----
CREATE TABLE DMSV (
    MASV     CHAR(3)        CONSTRAINT dmsv_masv_pk PRIMARY KEY,
    HOSV     NVARCHAR2(30),
    TENSV    NVARCHAR2(10),
    PHAI     NVARCHAR2(3),
    NGAYSINH DATE,
    NOISINH  NVARCHAR2(25),
    MAKH     CHAR(2)        CONSTRAINT dmsv_makh_fk REFERENCES DMKHOA(MAKHOA),
    HOCBONG  NUMBER(10,0)
);

-- ---- Tao bang KETQUA ----
CREATE TABLE KETQUA (
    MASV   CHAR(3)     CONSTRAINT ketqua_masv_fk REFERENCES DMSV(MASV),
    MAMH   CHAR(2)     CONSTRAINT ketqua_mamh_fk REFERENCES DMMH(MAMH),
    DIEM   NUMBER(4,2),
    CONSTRAINT ketqua_pk PRIMARY KEY (MASV, MAMH)
);

-- ============================================================
-- NHAP DU LIEU
-- ============================================================

-- ---- DMKHOA ----
INSERT INTO DMKHOA VALUES ('TI', N'Công nghệ thông tin');
INSERT INTO DMKHOA VALUES ('KT', N'Kế toán');
INSERT INTO DMKHOA VALUES ('QT', N'Quản trị kinh doanh');
INSERT INTO DMKHOA VALUES ('AT', N'An toàn thông tin');
INSERT INTO DMKHOA VALUES ('MT', N'Mạng máy tính');

-- ---- DMMH ----
INSERT INTO DMMH VALUES ('C1', N'Cơ sở dữ liệu',    45);
INSERT INTO DMMH VALUES ('C2', N'Lập trình Oracle',  30);
INSERT INTO DMMH VALUES ('C3', N'Mạng máy tính',     45);
INSERT INTO DMMH VALUES ('C4', N'Lập trình Java',    60);
INSERT INTO DMMH VALUES ('C5', N'Toán rời rạc',      45);
INSERT INTO DMMH VALUES ('C6', N'Lập trình Python',  45);
INSERT INTO DMMH VALUES ('C7', N'An toàn mạng',      30);

-- ---- DMSV ----
INSERT INTO DMSV VALUES ('S01', N'Nguyễn Văn', N'An',     N'Nam', TO_DATE('15-03-2002','DD-MM-YYYY'), N'TP.HCM',    'TI', 1200000);
INSERT INTO DMSV VALUES ('S02', N'Trần Thị',   N'Bình',   N'Nữ',  TO_DATE('22-07-2001','DD-MM-YYYY'), N'Hà Nội',    'KT',  800000);
INSERT INTO DMSV VALUES ('S03', N'Lê Văn',     N'Cường',  N'Nam', TO_DATE('10-01-2002','DD-MM-YYYY'), N'Đà Nẵng',   'TI', 1500000);
INSERT INTO DMSV VALUES ('S04', N'Phạm Thị',   N'Dung',   N'Nữ',  TO_DATE('05-09-2001','DD-MM-YYYY'), N'Cần Thơ',   'QT',       0);
INSERT INTO DMSV VALUES ('S05', N'Hoàng Văn',  N'Em',     N'Nam', TO_DATE('30-11-2002','DD-MM-YYYY'), N'Huế',       'AT', 1000000);
INSERT INTO DMSV VALUES ('S06', N'Võ Thị',     N'Phương', N'Nữ',  TO_DATE('18-04-2002','DD-MM-YYYY'), N'Nha Trang', 'MT', 1200000);
INSERT INTO DMSV VALUES ('S07', N'Đặng Văn',   N'Giang',  N'Nam', TO_DATE('25-06-2001','DD-MM-YYYY'), N'TP.HCM',    'TI',       0);
INSERT INTO DMSV VALUES ('S08', N'Bùi Thị',    N'Hoa',    N'Nữ',  TO_DATE('12-02-2002','DD-MM-YYYY'), N'Hà Nội',    'KT',  800000);
INSERT INTO DMSV VALUES ('S09', N'Ngô Văn',    N'Inh',    N'Nam', TO_DATE('03-08-2001','DD-MM-YYYY'), N'Vinh',      'TI', 1500000);
INSERT INTO DMSV VALUES ('S10', N'Đinh Thị',   N'Kiều',   N'Nữ',  TO_DATE('20-10-2002','DD-MM-YYYY'), N'Hải Phòng', 'QT',       0);

-- ---- KETQUA ----
INSERT INTO KETQUA VALUES ('S01','C1', 8.5);
INSERT INTO KETQUA VALUES ('S01','C2', 7.0);
INSERT INTO KETQUA VALUES ('S01','C4', 9.0);
INSERT INTO KETQUA VALUES ('S02','C1', 6.5);
INSERT INTO KETQUA VALUES ('S02','C5', 7.5);
INSERT INTO KETQUA VALUES ('S03','C1', 9.5);
INSERT INTO KETQUA VALUES ('S03','C2', 8.0);
INSERT INTO KETQUA VALUES ('S03','C3', 7.5);
INSERT INTO KETQUA VALUES ('S04','C5', 5.0);
INSERT INTO KETQUA VALUES ('S04','C6', 6.0);
INSERT INTO KETQUA VALUES ('S05','C7', 8.0);
INSERT INTO KETQUA VALUES ('S05','C3', 7.0);
INSERT INTO KETQUA VALUES ('S06','C3', 9.0);
INSERT INTO KETQUA VALUES ('S06','C7', 8.5);
INSERT INTO KETQUA VALUES ('S07','C1', 4.5);
INSERT INTO KETQUA VALUES ('S07','C4', 5.5);
INSERT INTO KETQUA VALUES ('S08','C1', 7.0);
INSERT INTO KETQUA VALUES ('S08','C5', 6.5);
INSERT INTO KETQUA VALUES ('S09','C1', 9.0);
INSERT INTO KETQUA VALUES ('S09','C2', 8.5);
INSERT INTO KETQUA VALUES ('S10','C5', 6.0);
INSERT INTO KETQUA VALUES ('S10','C6', 7.0);

COMMIT;

-- ============================================================
-- KIEM TRA KET QUA
-- ============================================================
SELECT 'DMKHOA'  AS "Bang", COUNT(*) AS "So ban ghi" FROM DMKHOA  UNION ALL
SELECT 'DMMH',            COUNT(*) FROM DMMH    UNION ALL
SELECT 'DMSV',            COUNT(*) FROM DMSV    UNION ALL
SELECT 'KETQUA',          COUNT(*) FROM KETQUA;
