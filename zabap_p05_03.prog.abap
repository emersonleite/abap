*&---------------------------------------------------------------------*
*& Report  ZABAP_P02_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zabap_p05_03.

PARAMETERS: pa_v1 TYPE i,
            pa_v2 TYPE i,
            pa_op TYPE c LENGTH 1.


DATA result TYPE bc400_perc.
*data result type p length 4 decimals 2.

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

  WHEN 'E'.
    CALL FUNCTION 'Z_CALC_EXPO_03'
      EXPORTING
        im_v1               = pa_v1
        im_v2               = pa_v2
      IMPORTING
        ex_resu             = result
      EXCEPTIONS
        expo_maior_que_5    = 5
        expo_nao_informado  = 6
        valor_nao_informado = 7
        OTHERS              = 4.
    IF sy-subrc <> 0.
      IF sy-subrc = 5.
        MESSAGE i005(zmsg) WITH sy-subrc.
        elseif sy-subrc = 6.
          MESSAGE i006(zmsg) WITH sy-subrc.
          elseif sy-subrc = 7.
            MESSAGE i007(zmsg) WITH sy-subrc.
      ENDIF.
      exit.

      MESSAGE i004(zmsg) WITH sy-subrc.
    ENDIF.

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