*----------------------------------------------------------------------*
***INCLUDE ZNOATEST1_PBO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH '보유원장 조회'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  START_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE START_ALV OUTPUT.
  IF go_con is INITIAL.
    CREATE OBJECT GO_CON
      EXPORTING
*        PARENT                      =
        CONTAINER_NAME              = 'CON'
*        STYLE                       =
*        LIFETIME                    = lifetime_default
*        REPID                       =
*        DYNNR                       =
*        NO_AUTODEF_PROGID_DYNNR     =
      EXCEPTIONS
        CNTL_ERROR                  = 1
        CNTL_SYSTEM_ERROR           = 2
        CREATE_ERROR                = 3
        LIFETIME_ERROR              = 4
        LIFETIME_DYNPRO_DYNPRO_LINK = 5
        others                      = 6.

    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  ENDIF.

 CREATE OBJECT GO_GRID
   EXPORTING
*     I_SHELLSTYLE      = 0
*     I_LIFETIME        =
     I_PARENT          = go_con
*     I_APPL_EVENTS     = space
*     I_PARENTDBG       =
*     I_APPLOGPARENT    =
*     I_GRAPHICSPARENT  =
*     I_NAME            =
*     I_FCAT_COMPLETE   = SPACE
   EXCEPTIONS
     ERROR_CNTL_CREATE = 1
     ERROR_CNTL_INIT   = 2
     ERROR_CNTL_LINK   = 3
     ERROR_DP_CREATE   = 4
     others            = 5.
 IF SY-SUBRC <> 0.
  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
             WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
 ENDIF.

PERFORM build_fieldcat_0100.

CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY
*  EXPORTING
*    I_BUFFER_ACTIVE               =
*    I_BYPASSING_BUFFER            =
*    I_CONSISTENCY_CHECK           =
*    I_STRUCTURE_NAME              = 'ZTCFMDD_BD'
*    IS_VARIANT                    =
*    I_SAVE                        =
*    I_DEFAULT                     = 'X'
*    IS_LAYOUT                     =
*    IS_PRINT                      =
*    IT_SPECIAL_GROUPS             =
*    IT_TOOLBAR_EXCLUDING          =
*    IT_HYPERLINK                  =
*    IT_ALV_GRAPHICS               =
*    IT_EXCEPT_QINFO               =
*    IR_SALV_ADAPTER               =
  CHANGING
    IT_OUTTAB                     = itab[]
    IT_FIELDCATALOG               = gt_fieldcat_0100
*    IT_SORT                       =
*    IT_FILTER                     =
  EXCEPTIONS
    INVALID_PARAMETER_COMBINATION = 1
    PROGRAM_ERROR                 = 2
    TOO_MANY_LINES                = 3
    others                        = 4
        .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GET_DATA  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE GET_DATA OUTPUT.
*  SELECT * from ztcfmdd_bd into CORRESPONDING FIELDS OF TABLE itab[].
*
*
*ENDMODULE.
