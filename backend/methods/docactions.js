var Doc = require('../models/doctor')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
const Meeting = require('../models/meeting')
const { query } = require('express')

var functions = {
    addNew: function (req, res) {
        console.log(req.body.name)
        console.log(req.body.username)
        console.log(req.body.mobile)
        console.log(req.body.speciality);
        console.log(req.body.password)
        if ((!req.body.name) || (!req.body.password) || (!req.body.mobile) || (!req.body.username) || (!req.body.speciality)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newUser = Doc({
                name: req.body.name,
                password: req.body.password,
                mobile: req.body.mobile,
                speciality: req.body.speciality,
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
            const user = await Doc.findOne({ username: req.body.username }).exec();
            if (!user) {
                return res.status(403).send({ success: false, msg: 'Authentication Failed, Doc not found' });
            }
            const isMatch = await user.comparePassword(req.body.password);
            console.log(isMatch);
            if (isMatch) {
                const token = jwt.encode(user, config.secret);
                return res.json({ success: true, token: token, _id:user._id });
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
    getAlldoc:  function (req, res) {
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

                        Doc.find({"_id":{$nin: idlist}}, {name: 1, speciality: 1}).then(docslist => res.json(docslist));

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
    removeLink: async function (req, res) {
        var docid = req.body.docid;
        var patid = req.body.patid;
        var query = {"docid": docid, "patid": patid}
        try{
        const result = await Meeting.deleteMany(query);
        if(result )
        console.log(`${result.deletedCount} document(s) deleted`);
        res.status(200).send({ success: true, msg: 'Pateint' });
        }
        catch(err)
        {
            res.status(403).send({ success: false, msg: 'Pateint cant be removed' });
        }
    }
}

module.exports = functions