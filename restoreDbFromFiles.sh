#!/bin/bash

#Direccion de ubicacion Backups
DIRECTORIO=/opt/backup/
DIRECTORIO_BACKUP=/xxx
EXTENSION=.sql
USUARIO=USUARIO_SECRETO_DB
PGPASSWORD=CLAVE_SECRETA_DB
HOST=IP_O_URL_SERVIDOR_DB

echo "Archivos de respaldo en la ruta $DIRECTORIO:"
ARCHIVOS=$(ls $DIRECTORIO*$EXTENSION)
echo "$ARCHIVOS"
 
for i in "${DIRECTORIO}"*; do

  clear=${i%.sql}
  NOMBRE=${clear##*/}
  ARCHIVO=${i}
  echo "LOOP INI $ARCHIVO  "

#  DB_FILENAME="${ARCHIVO:12}"
#  NOMBRE=$(echo $DB_FILENAME | sed 's/.sql//g')

    # echo "Creando Base de datos $NOMBRE ..."
    echo "$HOST:5432:postgres:$USUARIO:$PGPASSWORD" >> ~/.pgpass
        chmod 0600 ~/.pgpass
        export PGPASSWORD=$PGPASSWORD

        echo "Creando Base de datos $NOMBRE ..."
    psql -U "$USUARIO"  -h "$HOST" -d "postgres" -c "CREATE DATABASE $NOMBRE "

    # Restore the database dump file
    echo "IMPORTANDO Base de datos $NOMBRE ..."
    psql -U $USUARIO -h $HOST -d $NOMBRE -f $ARCHIVO
    mv $ARCHIVO $DIRECTORIO_BACKUP$NOMBRE
# rm $ARCHIVO
# fi

done

