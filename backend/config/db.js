const mongoose = require('mongoose')
const { database } = require('./dbconfig')
const dbConfig = require('./dbconfig')

connectDB = async () => {
    try {
        const conn = await mongoose.connect(database, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        })
        console.log(`Connected to mongo db ${conn.connection.host}`)
    }
    catch (err) {
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB