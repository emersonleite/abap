*&---------------------------------------------------------------------*
*& Report  ZTIPOS_DADOS_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ztipos_dados_03.

DATA: ty_date TYPE d,
      ty_time TYPE t,
      ty_integ TYPE i,
      ty_float TYPE f,
      ty_chara TYPE c.



TYPES: ty_c_type TYPE c LENGTH 8,
       ty_n_type TYPE n LENGTH 5.

WRITE: ty_date, ty_time, ty_chara .