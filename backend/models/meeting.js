var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var Meeting = new Schema({
    docid: {
        type: String,
        require: true
    },
    patid: {
        type: String,
        require: true
    }
})

module.exports = mongoose.model('Meeting', Meeting)