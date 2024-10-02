// redis is basically in memory cache where we power mongodb database while we dont need to go to mongodb everytime for query as if is static screen nothing changed we take it from cache
// import the redis package
const redis = require('redis');
// create a redis client
const redisClient = redis.createClient();
// handle redis client error events
redisClient.on('error', (err) => {
  console.log('Redis Client Error', err);
});

// define a function to get data from cache or set cache if not present  
const getOrSetCache = (key, cb) => { // promise is a object that will produce a single value sometime in the future
  return new Promise((resolve, reject) => {
    // attempt to get the cached data for the given key 
    redisClient.get(key, async (err, data) => {
      if (err) return reject(err);// reject the promise if error
      if (data != null) return resolve(JSON.parse(data));// if data exists in cache parse and return it
      // if data is not in cache call the provided callback function to fetch fresh data 
      const freshData = await cb();
      // store the fresh data in redis cache with an expiration time of 3600 seconds (1hour)
      redisClient.setEx(key, 3600, JSON.stringify(freshData));
      // resolve the promise with the fresh data
      resolve(freshData);
    });
  });
};

module.exports = { redisClient, getOrSetCache };