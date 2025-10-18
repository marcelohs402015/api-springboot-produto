@echo off
echo ==========================================
echo    TESTE DA API SPRING BOOT - PRODUTOS
echo ==========================================
echo.
echo Aguardando aplicacao inicializar...
timeout /t 10 /nobreak >nul

echo.
echo 1. Fazendo login para obter token JWT...
echo.
curl -X POST http://localhost:8080/auth/login -H "Content-Type: application/json" -d "{\"username\": \"admin\", \"password\": \"admin\"}" > token_response.json 2>nul

echo.
echo 2. Token obtido:
type token_response.json
echo.

echo.
echo 3. Extraindo token...
for /f "tokens=2 delims=:" %%a in ('type token_response.json ^| findstr "token"') do set TOKEN=%%a
set TOKEN=%TOKEN:"=%
set TOKEN=%TOKEN:}=%
set TOKEN=%TOKEN: =%

echo Token: %TOKEN%
echo.

echo 4. Testando listagem de produtos com autenticacao...
echo.
curl -X GET http://localhost:8080/api/produtos -H "Authorization: Bearer %TOKEN%" > produtos_response.json 2>nul

echo.
echo 5. Resposta da API de produtos:
type produtos_response.json
echo.

echo.
echo ==========================================
echo         TESTE CONCLUIDO
echo ==========================================
pause