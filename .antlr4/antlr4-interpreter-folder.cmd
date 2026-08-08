@ECHO OFF
IF "%~1" == "" (
    ECHO.Missing required argument: script-folder-path
    GOTO :EOF
)
FOR %%A IN ("%~dp0antlr4-*-complete.jar") DO SET ANTLR4_JAR_FILE=%%~dpnxA
IF "%ANTLR4_JAR_FILE%" == "" (
    ECHO.No ANTLR4 JAR file found!
    GOTO :EOF
)

SET ANTLR4_JAR_INTERPRETER_COMMAND=java -cp "%ANTLR4_JAR_FILE%" org.antlr.v4.gui.Interpreter "%~dp0..\lib\FredrikHr.AuranGameScript.LanguageSyntax\GS.g4" program
MD "%~dp0..\out" 2> NUL
ECHO.%~dpnx0 > "%~dp0..\out\%~n0.log"
FOR %%S IN ("%~1\*.gs") DO (
    ECHO.$ %%~nxS: %ANTLR4_JAR_INTERPRETER_COMMAND% "%%~S" >> "%~dp0..\out\%~n0.log"
    %ANTLR4_JAR_INTERPRETER_COMMAND% "%%~S" 2>> "%~dp0..\out\%~n0.log"
)
ECHO.Done! >> "%~dp0..\out\%~n0.log"
