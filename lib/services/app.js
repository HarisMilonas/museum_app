


import bcrypt from 'bcryptjs';
import jwt from  'jsonwebtoken';

import express, { request } from 'express';

import { getExhibits, getExhibit, getUsers , getCategories , getCategoryExhibits , getNewsLetterPeople , insertNewsLetterPerson , getAllNewsLetterEmails} from './database.js';

// to parse values to request body
import bodyParser from 'body-parser';




const app = express();


app.use(express.json());


app.use(bodyParser.json())

app.use(bodyParser.urlencoded({
    extended: true
  }));



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
            "message": 'Error: ' + res.statusCode + '\n'  + error.toString(),
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

app.get('/categories', async (req,res) =>
{
    
    try{
   var categories =  await getCategories();
  
        res.send({
            "message": "Request Successful!",
            "exhibits": categories
        });  
    }catch(error){
        res.send({
            "message": 'Error: ' + res.statusCode + '\n'  + error.toString(),
        }); 
    }
        
}
)

app.post("/exhibits-category", async (req, res) => {

    console.log(req.body);
    try{
        var results  = await getCategoryExhibits(req.body['category'])

        res.send({
            "message": "Request Successful!",
            "exhibits": results
        });  

    }catch(error){
        return  res.status(500).send({
            "message": 'Error: ' + res.statusCode + '\n'  + error.toString()
        });
    }
    
}) ;


app.post("/request-token", async (req, res) => {
    try{
         console.log(req.body);   

    var users = await getUsers();
    for (const user of users ) {
      
        let hashedPassword =  user.password;

        console.log("req.body['password']: ", req.body['password']);
        console.log("hashedPassword: ", hashedPassword);

        let isValid =  await bcrypt.compare(req.body['password'], hashedPassword)
        if(user.username === req.body['username'] && isValid ){
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
              "message":'Error: 404 \nNo user records found!'
            }
            );
    } catch(error){
        return  res.status(500).send({
            "message": 'Error: ' + res.statusCode + '\n'  + error.toString()
        });
    }
   
}) ;


app.post("/enlist-people", async (req, res) => {
    try {
        console.log(req.body);   

        const users = await getNewsLetterPeople();
        
        for (const user of users) {
            let dbEmail = user.email;
            console.log("req.body['email']: ", req.body['email']);
            console.log("dbEmail: ", dbEmail);

            if (dbEmail === req.body['email']) {
                // Email already exists in the database
                return res.status(401).send({
                    "message": "Το email υπάρχει ήδη!"
                });
            }
        }

        const personData = {
            email: req.body['email'],
        };
        
        await insertNewsLetterPerson(personData);  // Await the insertion
        
        res.send({
            "message": "Εγγραφή επιτυχής!",
            "credentials": {
                "email": req.body['email'],
            }
        });

    } catch(error) {
        return res.status(500).send({
            "message": 'Error: ' + res.statusCode + '\n' + error.toString()
        });
    }
});

app.get('/newsletter', async (req,res) =>
{
    try{
   var emails =  await getAllNewsLetterEmails();
            console.log(emails)
        res.send({
            "message": "Request Successful!",
            "emails": emails
        });  
    }catch(error){
        res.send({
            "message": 'Error: ' + res.statusCode + '\n'  + error.toString(),
        }); 
    }
        // res.send('exhibits');  
}
)






app.listen(80, () => {
    console.log('Listening to port 80')
})



app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke!')
  })