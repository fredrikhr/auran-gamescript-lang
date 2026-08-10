@ECHO OFF
FOR %%A IN ("%~dp0antlr4-*-complete.jar") DO SET ANTLR4_JAR_FILE=%%~dpnxA
IF "%ANTLR4_JAR_FILE%" == "" (
    ECHO.No ANTLR4 JAR file found!
    GOTO :EOF
)

@ECHO ON
java -cp "%ANTLR4_JAR_FILE%" org.antlr.v4.gui.Interpreter %*
