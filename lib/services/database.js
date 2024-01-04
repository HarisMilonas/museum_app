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

export async function getNewsLetterPeople(){
    var results = await pool.query('SELECT * from newsletter_people');
     return results[0];
}

export async function insertNewsLetterPerson(personData) {
    try {
        const query = 'INSERT INTO newsletter_people SET ?';
        const result = await pool.query(query, personData);
        return result;
    } catch (error) {
        console.error("Error inserting into newsletter_people:", error);
        throw error;
    }
}

export async function getAllNewsLetterEmails(personData) {
    try {
        const query = 'SELECT email FROM newsletter_people';
        const result = await pool.query(query, personData);
        return result[0];
    } catch (error) {
        console.error("Error inserting into newsletter_people:", error);
        throw error;
    }
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