*&---------------------------------------------------------------------*
*& Report  ZDIALOG_MESSAGES_03
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zdialog_messages_03.

*data dialog type string.

PARAMETERS dialog type c LENGTH 2.

*DATA dialog TYPE string VALUE 's'.

CASE dialog.
  WHEN 'I'.
    MESSAGE i000(zclass_message_03) WITH dialog.
  WHEN 'S'.
    MESSAGE s000(zclass_message_03) WITH dialog.
ENDCASE.