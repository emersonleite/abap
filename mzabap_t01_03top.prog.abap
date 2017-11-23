*&---------------------------------------------------------------------*
*& Include MZABAP_T01_03TOP                                  Module Pool      SAPMZABAP_T01_03
*&
*&---------------------------------------------------------------------*

PROGRAM  sapmzabap_t01_03.

TABLES: zped_03, zview1_03.


DATA: ok_code TYPE sy-ucomm,
      flag,

icone TYPE icons-text,
flg,
resp,
 "caracter de 1 byte. Não declaravel. Tamanho padrão.
tela type sy-dynnr.
CONTROLS : my_tab TYPE TABSTRIP.