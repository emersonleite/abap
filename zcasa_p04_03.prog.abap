*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zcasa_p04_03.

* WRITE:/ 'Entre com os valores abaixo:'.

PARAMETERS: pa_v1 TYPE i,
            pa_v2 TYPE i,
            pa_op TYPE c LENGTH 1.


DATA result TYPE p LENGTH 4 DECIMALS 2.

CASE pa_op.
  WHEN '*'.
    result = pa_v1 * pa_v2.
  WHEN '/'.
    IF pa_v2 = 0.
      MESSAGE i002(zmsg) WITH sy-uname pa_v2. "mensagem divisão por 0
    ELSE.
      result = pa_v1 / pa_v2.
    ENDIF.
    EXIT.
  WHEN '+'.
    result = pa_v1 + pa_v2.
  WHEN '-'.
    result = pa_v1 - pa_v2.

  WHEN '%'.
    PERFORM calcperc
     USING pa_v1
           pa_v2
     CHANGING result.
  WHEN OTHERS.
    MESSAGE i001(zmsg) WITH pa_op. "mensagem de operador inválido
ENDCASE.

WRITE: 'o resultado é:', result.

*&---------------------------------------------------------------------*
*&      Form  CALCPERC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_PA_V1  text
*      -->P_PA_V2  text
*      <--P_RESULT  text
*----------------------------------------------------------------------*
FORM calcperc  USING    p_pa_v1 LIKE pa_v1
                        p_pa_v2 LIKE pa_v2
               CHANGING p_result LIKE result.

  p_result = p_pa_v2 / 100 * p_pa_v1.

ENDFORM.                    " CALCPERC