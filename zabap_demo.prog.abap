*&---------------------------------------------------------------------*
*& Report  ZABAP_DEMO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_demo.
TABLES: zit_05.

DATA: it_tab LIKE STANDARD TABLE OF zit_05.

DATA: wa_estrutura TYPE zit_05,
      cpo TYPE zit_05-numped,
      cpoa TYPE znumped05.

SELECT-OPTIONS so_nump FOR cpo.

SELECT * FROM zit_05 " into wa_estrutura
  WHERE numped IN so_nump.
  WRITE:/ zit_05-numped,
         zit_05-itemped,
         zit_05-qtdemat,
         zit_05-unidmed,
         zit_05-preco,
         zit_05-codmat,
         zit_05-langu,
         zit_05-statusitem.


ENDSELECT.