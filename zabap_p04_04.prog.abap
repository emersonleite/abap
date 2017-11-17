*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p04_04.

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
  WHEN '%'.
    PERFORM calcula_percentual
     USING
           pa_v1
           pa_v2
           CHANGING
             resultante.
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
MESSAGE i003(zmsg) WITH resultante.
*&---------------------------------------------------------------------*
*&      Form  CALCULA_PERCENTUAL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM calcula_percentual
USING
    valor1
    valor2
      CHANGING
        resultante.

  resultante = valor1 * valor2 / 100.
ENDFORM.                    " CALCULA_PERCENTUAL