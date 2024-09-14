#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "\nWelcome to My Salon, how can I help you?\n"

SALON_MENU(){
if [[ $1 ]]
then
  echo -e "\n$1" #print function string errors calls
fi
SERVICES=$($PSQL "SELECT * FROM services")
echo "$SERVICES" | while read SERVICE_ID NAME
do
  echo "$SERVICE_ID) $NAME"  | sed 's/ | / /g'
done

echo -e "\nWhat would you like? Choose a number\n"
read SERVICE_ID_SELECTED


if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then
  SALON_MENU "That is not a number. Insert a valid service number"

else
  GET_SERVICE=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_INFO=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_INFO_FORMATED=$(echo $SERVICE_INFO | sed 's/\s+ / /g')
  if [[ -z $GET_SERVICE ]]
  then
    SALON_MENU  "Choose an existent service"
  else
    echo -e "\nWhat's your phone number?\n"
    read CUSTOMER_PHONE
    LOOK_UP_CUSTOMER_NAME=$($PSQL "SELECT TRIM(name) FROM customers  WHERE phone='$CUSTOMER_PHONE'" | sed 's/\s+ / /g')
      if [[ -z $LOOK_UP_CUSTOMER_NAME ]]
        then
          echo -e "\nI don't have a record for that phone number, What's your name?\n"
          read CUSTOMER_NAME
          CUSTOMER_NAME_FORMATED=$(echo $CUSTOMER_NAME | sed 's/ //g')
          INSERT_CUSTOMER_DATA=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME_FORMATED', '$CUSTOMER_PHONE')")
      fi
      if [[ -z $CUSTOMER_NAME ]]
      then
       echo -e "\nWhat time would you like your $SERVICE_INFO_FORMATED service, $LOOK_UP_CUSTOMER_NAME?\n"
       read SERVICE_TIME
       echo -e "\nI have put you down for a $SERVICE_INFO_FORMATED at $SERVICE_TIME, $LOOK_UP_CUSTOMER_NAME.\n"
      else
       echo -e "\nWhat time would you like your $SERVICE_INFO_FORMATED service, $CUSTOMER_NAME_FORMATED?\n"
       read SERVICE_TIME
       echo -e "\nI have put you down for a $SERVICE_INFO_FORMATED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATED.\n"
      fi
  fi
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
INSERT_APPOINTMENT_DATA=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED','$SERVICE_TIME')")
}
SALON_MENU