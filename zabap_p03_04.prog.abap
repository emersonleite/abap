*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p03_04.

PARAMETERS :
pa_v1 TYPE i,
pa_v2 TYPE i,
pa_op TYPE c.

DATA resultante TYPE p LENGTH 10 DECIMALS 2.

CASE pa_op.
  WHEN '+'.
    resultante = pa_v1 + pa_v2.
  WHEN '-'.
    resultante = pa_v1 - pa_v2.
  WHEN '*'.
    resultante = pa_v1 * pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
*      WRITE 'Não é possível dividir por 0!'.
      MESSAGE i002(zmsg) WITH sy-uname.
    ELSE.
      resultante = pa_v1 / pa_v2.
    ENDIF.
  WHEN OTHERS.
*    WRITE 'Comando invalido!'.
    MESSAGE i001(zmsg) WITH pa_op.
ENDCASE.

*WRITE: 'Resultado:', resultante.
MESSAGE i003(zmsg) with resultante.