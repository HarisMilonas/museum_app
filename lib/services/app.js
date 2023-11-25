


import bcrypt from 'bcryptjs';
import jwt from  'jsonwebtoken';

import express, { request } from 'express';

import { getExhibits, getExhibit, getUsers} from './database.js';





const app = express();


app.use(express.json());

app.get('/exhibits', async (req,res) =>
{
    
    try{
   var exhibits =  await getExhibits();
        res.send({
            "message": "Request Successful!",
            "exhibits": exhibits
        });  
    }catch(error){
        res.send({
            "message": error.toString(),
        }); 
    }
        // res.send('exhibits');  
}
)

app.get("/exhibits/:id", async (req,res) =>
{
    const id = req.params.id;
   var exhibit =  await getExhibit(id);
        res.send(exhibit);  
        // res.send('exhibits');  
}
)


app.post("/request-token", async (req, res) => {
    try{
    var users = await getUsers();
    let hashedPassword =  await bcrypt.hash(req.body['password'], 8);

    for (const user of users ) {
        console.log('hashed Password:'+ hashedPassword)
        console.log('db password:'+ user.password)
        if(user.username === req.body['username'] && bcrypt.compare(req.body['password'], hashedPassword)){
        return  res.send({
                "message" : "User authenticated!",
                "credentials": {
                "id" : user.id,
                "email" : user.email,
                "password": user.password,
                "username": user.username,
                "name": user.name
                }
            });
        }
    }
        return  res.status(404).send(
            {
              "message":'No user records found!'
            }
            );
    } catch(error){
        return  res.status().send({
            "message": error.toString()
        });
    }
   
}) ;




app.listen(80, () => {
    console.log('Listening to port 80')
})





app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke!')
  })