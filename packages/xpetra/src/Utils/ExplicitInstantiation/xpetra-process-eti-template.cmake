FUNCTION(XPETRA_PROCESS_ETI_TEMPLATE ETI_CLASSES TEMPLATE_FILE PROCESSED_FILE SOURCES_LIST)
  SET(SRCS "")
  FOREACH(CLASS ${ETI_CLASSES})
    # find seperator of class name and (optional) conditions
    string(FIND ${CLASS} "-" DASHPOS)
    IF ('${DASHPOS}' STREQUAL '-1')
      string(SUBSTRING ${CLASS} 0 ${DASHPOS} CLASS_NAME)
      #MESSAGE("New class name = ${CLASS_NAME}")
      set (CONDITION_NAME "")
      set (CONDITION_NAME_END "")      
    ELSE()
      string(SUBSTRING ${CLASS} 0 ${DASHPOS} CLASS_NAME)
      #MESSAGE("New class name = ${CLASS_NAME}")
      string(SUBSTRING ${CLASS} ${DASHPOS} -1 CONDITION_NAME)
      string(REPLACE "[" "(" CONDITION_NAME ${CONDITION_NAME})
      string(REPLACE "]" ")" CONDITION_NAME ${CONDITION_NAME})
      string(REPLACE "." " " CONDITION_NAME ${CONDITION_NAME})
      string(REPLACE "-" "" CONDITION_NAME ${CONDITION_NAME})
      string(REPLACE "?" "#" CONDITION_NAME ${CONDITION_NAME})
      string(STRIP CONDITION_NAME ${CONDITION_NAME})
      #MESSAGE("New condition name = ${CONDITION_NAME}")
      set (CONDITION_NAME_END "#endif")
    ENDIF()
    
    string(REPLACE "::" "_" CLASS_FILE_NAME "${CLASS_NAME}")
    string(TOUPPER "${CLASS_FILE_NAME}" UPPER_CASE_CLASS)
    string(REPLACE "CLASS_FILE_NAME" "${CLASS_FILE_NAME}" FINAL_FILE_NAME "${PROCESSED_FILE}")
    
    # the following generates one cpp file for all instantiations and 
    # enabled configurations
    CONFIGURE_FILE(${TEMPLATE_FILE} ${FINAL_FILE_NAME})
    #MESSAGE("Configure file ${FINAL_FILE_NAME} using template ${TEMPLATE_FILE}")
    SET(SRCS ${SRCS} ${FINAL_FILE_NAME})
    
  ENDFOREACH()
  SET(${SOURCES_LIST} ${SRCS} PARENT_SCOPE)
ENDFUNCTION(XPETRA_PROCESS_ETI_TEMPLATE)
