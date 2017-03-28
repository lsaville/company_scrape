var request = require('request'),
    cheerio = require('cheerio'),
    url = 'http://www.techstars.com/companies/'

request(url, function (error, response, body) {
  if (!error) {
    var $ = cheerio.load(body)
    var blah = $('.batch'); 
    console.log(blah);
  } else {
    console.log("We’ve encountered an error: " + error);
  }
});
