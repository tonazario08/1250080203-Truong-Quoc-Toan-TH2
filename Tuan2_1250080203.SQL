SHOW USER;

-- CAU 1: Ten va luong nhan vien co luong > 12000$
SELECT last_name,
       salary
FROM   employees
WHERE  salary > 12000;

-- CAU 2: Ten va luong nhan vien co luong < 5000$ hoac > 12000$
SELECT last_name,
       salary
FROM   employees
WHERE  salary < 5000
   OR  salary > 12000;

-- CAU 3: Ten, job_id, hire_date tu 20/02/1998 den 01/05/1998 sap xep tang dan theo ngay thue
SELECT last_name,
       job_id,
       hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('20/02/1998','DD/MM/YYYY')
                     AND TO_DATE('01/05/1998','DD/MM/YYYY')
ORDER BY hire_date;

-- CAU 4: Nhan vien phong 20 va 50, sap xep theo ten
SELECT last_name,
       department_id
FROM   employees
WHERE  department_id IN (20, 50)
ORDER BY last_name;

-- CAU 5: Nhan vien duoc thue nam 1994
SELECT last_name,
       hire_date
FROM   employees
WHERE  TO_CHAR(hire_date, 'YYYY') = '1994';

-- CAU 6: Ten, job_id cua nhan vien khong co nguoi quan ly
SELECT last_name,
       job_id
FROM   employees
WHERE  manager_id IS NULL;

-- CAU 7: Nhan vien duoc huong hoa hong, sap xep giam dan theo luong va hoa hong
SELECT last_name,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

-- CAU 8: Nhan vien co ky tu thu 3 trong ten la 'a'
SELECT last_name
FROM   employees
WHERE  SUBSTR(last_name, 3, 1) = 'a';

-- CAU 9: Nhan vien trong ten co ca chu 'a' va chu 'e'
SELECT last_name
FROM   employees
WHERE  LOWER(last_name) LIKE '%a%'
  AND  LOWER(last_name) LIKE '%e%';

-- CAU 10: Ten, job_id, luong cua nhan vien lam 'Sales Representative' hoac 'Stock Clerk' va luong khac 2500, 3500, 7000
SELECT last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id IN ('SA_REP', 'ST_CLERK')
  AND  salary NOT IN (2500, 3500, 7000);

-- CAU 11: Ma NV, ten, luong tang 15% lam tron den hang don vi dat ten cot la "New Salary"
SELECT employee_id,
       last_name,
       salary,
       ROUND(salary * 1.15, 0) AS "New Salary"
FROM   employees;

-- CAU 12: Ten nhan vien, chieu dai ten - ten bat dau bang J, A, L, M sap xep tang dan theo ten, chu dau viet hoa, con lai thuong
SELECT INITCAP(last_name)  AS "Ten nhan vien",
       LENGTH(last_name)   AS "Chieu dai"
FROM   employees
WHERE  SUBSTR(last_name, 1, 1) IN ('J', 'A', 'L', 'M')
ORDER BY last_name;

-- CAU 13: Ten nhan vien va so thang da lam viec (sap xep tang dan)
SELECT last_name,
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "So thang lam viec"
FROM   employees
ORDER BY 2;

-- CAU 14: Dinh dang: <last_name> earns <salary> monthly but wants <3*salary> Cot ten la "Dream Salaries"
SELECT last_name || ' earns '
       || TO_CHAR(salary, '99999')
       || ' monthly but wants '
       || TO_CHAR(salary * 3, '99999') AS "Dream Salaries"
FROM   employees;

-- CAU 15: Ten nhan vien va hoa hong - neu khong co thi hien thi 'No commission'
SELECT last_name,
       NVL(TO_CHAR(commission_pct), 'No commission') AS "Hoa hong"
FROM   employees;

-- CAU 16: Phan loai nhan vien theo job_id (DECODE / CASE)
SELECT job_id,
       DECODE(job_id,
              'AD_PRES',  'A',
              'ST_MAN',   'B',
              'IT_PROG',  'C',
              'SA_REP',   'D',
              'ST_CLERK', 'E',
                          '0') AS "GRADE"
FROM   employees;

-- CAU 17: Ten NV, ma phong, ten phong - lam viec o thanh pho Toronto
SELECT e.last_name,
       e.department_id,
       d.department_name
FROM   employees   e
JOIN   departments d ON e.department_id  = d.department_id
JOIN   locations   l ON d.location_id    = l.location_id
WHERE  LOWER(l.city) = 'toronto';

-- CAU 18: Ma NV, ten NV, ma quan ly, ten quan ly (Self Join)
SELECT e.employee_id     AS "Ma nhan vien",
       e.last_name       AS "Ten nhan vien",
       e.manager_id      AS "Ma quan ly",
       m.last_name       AS "Ten quan ly"
FROM   employees e
JOIN   employees m ON e.manager_id = m.employee_id;

-- CAU 19: Nhan vien lam viec cung phong (Self Join)
SELECT e1.last_name       AS "Nhan vien",
       e1.department_id   AS "Ma phong",
       e2.last_name       AS "Dong nghiep"
FROM   employees e1
JOIN   employees e2 ON  e1.department_id = e2.department_id
                    AND e1.employee_id   < e2.employee_id
ORDER BY e1.department_id, e1.last_name;

-- CAU 20: Nhan vien duoc thue sau nhan vien 'Davies'
SELECT last_name,
       hire_date
FROM   employees
WHERE  hire_date > (
           SELECT hire_date
           FROM   employees
           WHERE  last_name = 'Davies'
       )
ORDER BY hire_date;

-- CAU 21: Nhan vien duoc thue truoc nguoi quan ly cua ho
SELECT e.last_name        AS "Nhan vien",
       e.hire_date        AS "Ngay thue NV",
       m.last_name        AS "Quan ly",
       m.hire_date        AS "Ngay thue QL"
FROM   employees e
JOIN   employees m ON e.manager_id = m.employee_id
WHERE  e.hire_date < m.hire_date;

-- CAU 22: Luong thap nhat, cao nhat, trung binh, tong luong theo tung cong viec
SELECT job_id,
       MIN(salary)  AS "Luong thap nhat",
       MAX(salary)  AS "Luong cao nhat",
       ROUND(AVG(salary), 2) AS "Luong trung binh",
       SUM(salary)  AS "Tong luong"
FROM   employees
GROUP BY job_id
ORDER BY job_id;

-- CAU 23: Ma phong, ten phong, so nhan vien tung phong ban
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So nhan vien"
FROM   departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- Tong so nhan vien va tong NV thue tung nam 1995-1998
SELECT COUNT(*) AS "Tong so nhan vien",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = '1995' THEN 1 ELSE 0 END) AS "Nam 1995",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = '1996' THEN 1 ELSE 0 END) AS "Nam 1996",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = '1997' THEN 1 ELSE 0 END) AS "Nam 1997",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = '1998' THEN 1 ELSE 0 END) AS "Nam 1998"
FROM   employees;

-- CAU 25: Ten, ngay thue cua nhan vien cung phong voi 'Zlotkey'
SELECT last_name,
       hire_date
FROM   employees
WHERE  department_id = (
           SELECT department_id
           FROM   employees
           WHERE  last_name = 'Zlotkey'
       )
  AND  last_name <> 'Zlotkey';

-- CAU 26: Ten, ma phong, job_id cua NV o location_id = 1700
SELECT e.last_name,
       e.department_id,
       e.job_id
FROM   employees   e
JOIN   departments d ON e.department_id = d.department_id
WHERE  d.location_id = 1700;

-- CAU 27: Nhan vien co nguoi quan ly ten 'King'
SELECT last_name,
       manager_id
FROM   employees
WHERE  manager_id IN (
           SELECT employee_id
           FROM   employees
           WHERE  last_name = 'King'
       );

-- CAU 28: Nhan vien co luong cao hon TB va lam cung phong voi NV ten ket thuc bang 'n'
SELECT last_name,
       salary,
       department_id
FROM   employees
WHERE  salary > (SELECT AVG(salary) FROM employees)
  AND  department_id IN (
           SELECT department_id
           FROM   employees
           WHERE  LOWER(last_name) LIKE '%n'
       );

-- CAU 29: Ma phong, ten phong co it hon 3 nhan vien
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So nhan vien"
FROM   departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3
ORDER BY d.department_id;

-- CAU 30: Phong ban co dong nhan vien nhat va it nhan vien nhat
-- Phong dong nhat:
SELECT department_id,
       COUNT(*) AS "So nhan vien"
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM   employees
    GROUP BY department_id
);

-- Phong it nhat:
SELECT department_id,
       COUNT(*) AS "So nhan vien"
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (
    SELECT MIN(COUNT(*))
    FROM   employees
    GROUP BY department_id
);


-- CAU 31: Nhan vien duoc thue vao ngay co nhieu NV duoc thue nhat (dung TO_CHAR(hire_date, 'Day'))
-- CAU 31: Nhan vien duoc thue vao ngay co nhieu NV duoc thue nhat
SELECT last_name,
       hire_date,
       TO_CHAR(hire_date, 'Day') AS "Thu trong tuan"
FROM   employees
WHERE  TO_CHAR(hire_date, 'Day') IN (
    SELECT TO_CHAR(hire_date, 'Day')
    FROM   employees
    GROUP BY TO_CHAR(hire_date, 'Day')
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM   employees
        GROUP BY TO_CHAR(hire_date, 'Day')
    )
)
ORDER BY hire_date;

-- CAU 32: 3 nhan vien co luong cao nhat (Inline View + ROWNUM)
SELECT last_name,
       salary
FROM (
    SELECT last_name,
           salary
    FROM   employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 3;

-- CAU 33: Nhan vien lam viec o tieu bang 'California'
SELECT e.last_name,
       d.department_name,
       l.city,
       l.state_province
FROM   employees   e
JOIN   departments d ON e.department_id = d.department_id
JOIN   locations   l ON d.location_id   = l.location_id
WHERE  LOWER(l.state_province) = 'california';

-- CAU 34: Cap nhat ten nhan vien co ma 3 thanh 'Drexler'
UPDATE employees
SET    last_name = 'Drexler'
WHERE  employee_id = 3;

COMMIT;

-- Kiem tra:
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

-- CAU 35: Nhan vien co luong thap hon luong TB cua phong ban minh
SELECT last_name,
       salary,
       department_id
FROM   employees e1
WHERE  salary < (
           SELECT AVG(salary)
           FROM   employees e2
           WHERE  e2.department_id = e1.department_id
       )
ORDER BY department_id;

-- CAU 36: Tang them 100$ cho nhan vien co luong < 900$
UPDATE employees
SET    salary = salary + 100
WHERE  salary < 900;

COMMIT;

-- Kiem tra:
SELECT employee_id, last_name, salary
FROM   employees
WHERE  salary < 1000
ORDER BY salary;

-- CAU 37: Xoa phong ban 500
DELETE FROM departments
WHERE  department_id = 500;

COMMIT;

-- Kiem tra:
SELECT department_id, department_name
FROM   departments
WHERE  department_id = 500;

-- CAU 38: Xoa phong ban chua co nhan vien
DELETE FROM departments
WHERE  department_id NOT IN (
           SELECT DISTINCT department_id
           FROM   employees
           WHERE  department_id IS NOT NULL
       );

COMMIT;

-- Kiem tra:
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So nhan vien"
FROM   departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
