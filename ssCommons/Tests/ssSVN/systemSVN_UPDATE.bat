
@SETLOCAL
@SET LOCAL_CURRENT_DIR=%CD%
@SET LOCAL_SCRIPT_PATH=%~dp0
@SET SCRIPT_FULLPATH=
@SET LOCAL_SCRIPT_NAME=%~n0
@SET LOCAL_SCRIPT_NAME_TO_FIND=cwRunScript.bat

@CD "%LOCAL_SCRIPT_PATH%"

:LABEL__GO_UP_DIR
@SET LOCAL_SCRIPT_PATH_TO_FIND=%CD%
@SET LOCAL_SCRIPT_FULLPATH_TO_FIND=%LOCAL_SCRIPT_PATH_TO_FIND%\%LOCAL_SCRIPT_NAME_TO_FIND%
@IF EXIST "%LOCAL_SCRIPT_FULLPATH_TO_FIND%" (
	@SET SCRIPT_FULLPATH=%LOCAL_SCRIPT_FULLPATH_TO_FIND%
	GOTO LABEL__OK
)
@CD ..
@IF "%LOCAL_SCRIPT_PATH_TO_FIND%"=="%CD%" GOTO LABEL__END
@GOTO LABEL__GO_UP_DIR

:LABEL__OK
@CD %LOCAL_CURRENT_DIR%
@CALL "%LOCAL_SCRIPT_FULLPATH_TO_FIND%" "%~dpn0.cws" %*

:LABEL__END
@CD %LOCAL_CURRENT_DIR%
@ENDLOCAL
