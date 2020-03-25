*&---------------------------------------------------------------------*
*& Report ZNOATEST1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZNOATEST1.

INCLUDE znoatest1_top.

INCLUDE znoatest1_pbo01.

INCLUDE znoatest1_pai01.

INCLUDE znoatest1_f01.

START-OF-SELECTION.

PERFORM get_data.

IF itab[] is NOT INITIAL.
  call SCREEN 100.
ENDIF.
