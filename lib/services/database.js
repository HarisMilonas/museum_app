import mysql from 'mysql2';
import dotenv from 'dotenv';



dotenv.config();

export const pool = mysql.createPool({
    host:  process.env.MYSQL_HOST,
    user:  process.env.MYSQL_USER,
    password:  process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise();


export async function getExhibits(){
    var results = await pool.query('SELECT * from exhibits LIMIT 30');
     return results[0];
}



export async function getExhibit(id){
    var result = await pool.query(
        'SELECT * FROM exhibits WHERE idexhibit = ? ',[id] )
}


export async function getUsers(){
    var results = await pool.query('SELECT * from users');
     return results[0];
}


// export async function getUser(email){
//     var results = await pool.query('SELECT * from users where email = ?', [email]);
//     console.log(results);  
// }

export async function getCategories(){
    
     var results = await pool.query(`
     WITH RankedExhibits AS (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY category ORDER BY pic1 IS NOT NULL DESC, idexhibit) AS rnk
        FROM exhibits
    )
    SELECT *
    FROM RankedExhibits
    WHERE rnk = 1;
 `);
 console.log("CATEGGORY ITEMS" + results.toString);
  return results[0];
}

export async function getCategoryExhibits(category){
    console.log(category)
    var results = await pool.query(`
    SELECT * FROM exhibits WHERE category = ? 
` , [category]);
console.log(results[0])
 return results[0];

}