APIS :

1. For Users:

   1. localhost:5000/signup
   2. localhost:5000/login

2. For searching:

   1. Localhost:5000/search
      desc: source, destination in the form of name

3. For Notification:

   1. /send-notification
   2. /notifications

4. For Vehicles:

   1. /addVehicle --bid,name,type,direction,route
   2. /vehicles--whole vehicle model
   3. /vehicelslist --only names of vehicle

5. For Fare:

   1. /addFare --starting, ending,rate, bus
   2. /Fares --whole fare model

6. For routes:

   1. /addroute --id, name,start, end, stops_list
   2. /routes ---whole route model
   3. /routeslist --routes name only
   4. routes/:id --- provide id and it returns that route name, stops data, starting stop and ending stop ----id as in shorter id

7. for stops:
   1. /addstop --- lat, long,name
   2. /stops ---whole stop model
   3. /stopsList --only stops name
   4. /stops/:id -- find stops by id
