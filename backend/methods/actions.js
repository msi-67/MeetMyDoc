var User = require('../models/user')
var jwt = require('jwt-simple')
var Doc = require('../models/doctor')
const Meeting = require('../models/meeting')
var config = require('../config/dbconfig')
var mongoose = require('mongoose')
var functions = {
    addNew: function (req, res) {
        console.log(req.body.name)
        console.log(req.body.username)
        console.log(req.body.mobile)
        console.log(req.body.password)
        if ((!req.body.name) || (!req.body.password) || (!req.body.mobile) || (!req.body.username)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newUser = User({
                name: req.body.name,
                password: req.body.password,
                mobile: req.body.mobile,
                username: req.body.username
            });
            newUser.save()
                .then((newUser) => {
                    res.json({ success: true, msg: 'Successfully saved' })
                })
                .catch((err) => {
                    res.json({ success: false, msg: 'Failed to save' })
                })

        }
    },
    authenticate: async function (req, res) {
        try {
            const user = await User.findOne({ username: req.body.username }).exec();
            if (!user) {
                return res.status(403).send({ success: false, msg: 'Authentication Failed, User not found' });
            }
            const isMatch = await user.comparePassword(req.body.password);
            console.log(isMatch);
            if (isMatch) {
                const token = jwt.encode(user, config.secret);
                return res.json({ success: true, token: token });
            } else {
                return res.status(403).send({ success: false, msg: 'Authentication failed, wrong password' });
            }
        } catch (err) {
            throw err;
        }
    },
    getinfo: function (req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            return res.json({success: true, msg: 'Hello ' + decodedtoken.name})
        }
        else {
            return res.json({success: false, msg: 'No Headers'})
        }
    },
    setupMeeting: async function(req, res) {
        console.log(req.body.docid);
        console.log(req.body.patid);
        var newMeeting = new Meeting({
            docid: req.body.docid,
            patid: req.body.patid
        });
        newMeeting.save()
                .then((newMeeting) => {
                    res.json({ success: true, msg: 'Successfully saved' })
                })
                .catch((err) => {
                    res.json({ success: false, msg: 'Failed to save' })
                }) 
    },    
    getMyPateints: async function(req, res){
        const _id = req.body._id;
        const response = await Meeting.distinct("patid", { "docid": _id });
        console.log(response)
        var data1 = []
        var obj = {}
        for(i = 0; i<response.length; i++)
        {
            var decodedtoken = jwt.decode(response[i], config.secret)
            obj = {name: decodedtoken.name, patid: response[i]};
            data1.push(obj)
        }
        console.log(data1)
        res.json(data1);
    },
    getMydoctors: function (req, res) {
        console.log(req.body.patid);
        Meeting.find(
            {
                patid: req.body.patid
            }, {docid:1}).then(
                    docs => {
                        let idlist = [];
                        for (doc of docs)
                        {
                            idlist.push(doc.docid);
                            console.log(doc.docid)
                        }

                        Doc.find({"_id":{$in: idlist}}, {name: 1, speciality: 1}).then(docslist => res.json(docslist));
                        //res.json(idlist)
                    }
        );
        // Doc.aggregate([{
        //     $lookup:
        //     {
        //         from: 'meetings',
        //         localField: '_id',
        //         foreignField: 'docid',
        //         as: 'docdetails'
        //     }
        // }]).then(
        //     data => {
        //         console.log(data); res.json(data);
        //     }
        // );






        //const data = await Doc.find({docid : req.body.docid}, { name: 1, speciality: 1}).exec();
        // data = data.toList();
        //console.log(data)
        //return res.json(data);
    },
}

module.exports = functions