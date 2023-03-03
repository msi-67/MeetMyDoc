var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
var docSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    username: {
        type: String,
        require: true
    },
    mobile: {
        type: Number,
        require: true
    },
    speciality: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
    }
})

docSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                user.password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

docSchema.methods.comparePassword = async function (enteredPassword) {
    try {
      const isMatch = await bcrypt.compare(enteredPassword, this.password);
      return isMatch;
    } catch (error) {
      throw new Error(error);
    }
  };
  

module.exports = mongoose.model('Doc', docSchema)