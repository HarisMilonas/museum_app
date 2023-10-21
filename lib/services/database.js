import mysql from 'mysql2';
import dotenv from 'dotenv';

dotenv.config();

const pool = mysql.createPool({
    host:  process.env.MYSQL_HOST,
    user:  process.env.MYSQL_USER,
    password:  process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise();


export async function getExhibits(){
    var results = await pool.query('SELECT * from exhibits');
     return results[0];
}

export async function getExhibit(id){
    var result = await pool.query(
        'SELECT * FROM exhibits WHERE id = ? ',[id] )
}
