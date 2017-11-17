*&---------------------------------------------------------------------*
*& Report  ZABAP_P01_05
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZABAP_P01_05.

* Declaração de variáveis
DATA gv_result type i.
PARAMETERS pa_num type i.

*Lógica
MOVE pa_num to gv_result.

do 10 TIMES.
  add 1 to gv_result.
ENDDO.

*saída de dados
WRITE: 'Sua entrada:', pa_num.

NEW-LINE.

WRITE: 'Resultado:        ', gv_result.