#!/bin/bash

# Variables de configuración

#Lista de nombres de base de datos por ser respaldadas
NOMBRES_BD=("DB_NAME_A" "DB_NAME_B" )
# Directorio donde se almacenaran los archivos Backup
DIRECTORIO=/opt/backup/
#UsusarioDB
USUARIO=Usuario_DB
#PasswordDB
PGPASSWORD=MY_CLAVE_SECRETA_DB
#Direccion del servidor
HOST=IP_O_URL_SERVIDOR

# Crear directorio si no existe
if [ ! -d "$DIRECTORIO" ]
then
    mkdir "$DIRECTORIO"
fi

# Respaldo de cada base de datos
for i in "${NOMBRES_BD[@]}"
do
    echo "Procesando DB $i ..."
    nombre_bd=$(echo $i )
	echo "$HOST:5432:$nombre_bd:$USUARIO:$PGPASSWORD" >> ~/.pgpass
	chmod 0600 ~/.pgpass
	# pg_dump -U "$USUARIO" -h "$HOST" -w -F t "$i" | gzip > "$DIRECTORIO$nombre_bd.tar.gz"
    pg_dump -h "$HOST" -U "$USUARIO"   $nombre_bd > "$DIRECTORIO$nombre_bd.sql"
	chmod 777 "$DIRECTORIO$nombre_bd.sql"
    echo "  - DB $i Respaldada!"

done

