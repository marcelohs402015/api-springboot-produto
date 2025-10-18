@echo off
echo =====================================================
echo    RESET SENHA POSTGRESQL - SCRIPT AUTOMATICO
echo =====================================================
echo.

echo 1. Fazendo backup do pg_hba.conf...
copy "C:\Program Files\PostgreSQL\16\data\pg_hba.conf" "C:\Program Files\PostgreSQL\16\data\pg_hba.conf.backup" >nul 2>&1

echo 2. Alterando pg_hba.conf para permitir acesso sem senha...
powershell -Command "(Get-Content 'C:\Program Files\PostgreSQL\16\data\pg_hba.conf') -replace 'local   all             postgres                                md5', 'local   all             postgres                                trust' | Set-Content 'C:\Program Files\PostgreSQL\16\data\pg_hba.conf'"

echo 3. Reiniciando servico PostgreSQL...
sc stop postgresql-x64-16 >nul 2>&1
timeout /t 3 >nul
sc start postgresql-x64-16 >nul 2>&1
timeout /t 5 >nul

echo 4. Alterando senha do usuario postgres...
psql -U postgres -c "ALTER USER postgres PASSWORD 'admin';"

echo 5. Criando usuario admin...
psql -U postgres -c "CREATE USER admin WITH PASSWORD 'admin' SUPERUSER;"

echo 6. Criando banco mstechdb...
psql -U postgres -c "CREATE DATABASE mstechdb WITH OWNER admin;"

echo 7. Concedendo privilegios...
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE mstechdb TO admin;"

echo 8. Restaurando pg_hba.conf original...
copy "C:\Program Files\PostgreSQL\16\data\pg_hba.conf.backup" "C:\Program Files\PostgreSQL\16\data\pg_hba.conf" >nul 2>&1

echo 9. Reiniciando servico PostgreSQL novamente...
sc stop postgresql-x64-16 >nul 2>&1
timeout /t 3 >nul
sc start postgresql-x64-16 >nul 2>&1

echo.
echo =====================================================
echo    CONFIGURACAO CONCLUIDA!
echo =====================================================
echo Usuario postgres: senha 'admin'
echo Usuario admin: senha 'admin'
echo Banco: mstechdb
echo.
echo Teste a conexao:
echo psql -U admin -d mstechdb
echo =====================================================

pause