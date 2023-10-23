import express from 'express';

import { getExhibits, getExhibit } from './database.js';
const app = express();


app.get('/exhibits', async (req,res) =>
{
   var exhibits =  await getExhibits();
        res.send({
            "message": "Request Successful!",
            "exhibits": exhibits
        });  
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


app.listen(80, () => {
    console.log('Listening to port 80')
})



app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke!')
  })