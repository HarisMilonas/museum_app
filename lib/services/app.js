import express from 'express';

import { getExhibits, getExhibit } from './database.js';
const app = express();





app.get('/exhibits', async (req,res) =>
{
   var exhibits =  await getExhibits();
        res.send(exhibits);  
        // res.send('exhibits');  
}
)

app.listen(8080, () => {
    console.log('Listening to port 8080')
})



app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Something broke!')
  })