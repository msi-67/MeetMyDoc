var JwtStrategy = require('passport-jwt').Strategy
var ExtractJwt = require('passport-jwt').ExtractJwt

var User = require('../models/user')
var config = require('./dbconfig')

module.exports = function (passport) {
    var opts = {}

    opts.secretOrKey = config.secret
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt')

    passport.use(new JwtStrategy(opts, function (jwt_payload, done) {
        User.findOne({ id: jwt_payload.id })
            .then(function (user) {
                if (user) {
                    done(null, user);
                } else {
                    done(null, false);
                }
            })
            .catch(function (err) {
                done(err, false);
            });
    }));    
}