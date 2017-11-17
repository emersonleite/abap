*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p02_04.

PARAMETERS :
pa_v1 TYPE i,
pa_v2 TYPE i,
pa_op TYPE c.

DATA resultante TYPE p DECIMALS 2.

CASE pa_op.
  WHEN '+'.
    resultante = pa_v1 + pa_v2.
  WHEN '-'.
    resultante = pa_v1 - pa_v2.
  WHEN '*'.
    resultante = pa_v1 * pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
      WRITE 'Não é possível dividir por 0!'.
      exit.
    ELSE.
      resultante = pa_v1 / pa_v2.
    ENDIF.
  WHEN OTHERS.
    WRITE 'Comando invalido!'.
    exit.
ENDCASE.

WRITE: 'Resultado:', resultante.
*WRITE resultante.