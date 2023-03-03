const express = require('express')
const docactions = require('../methods/docactions')
const actions = require('../methods/actions')
const router = express.Router()

router.get('/', (req, res) => {
    res.send('Hello World')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

//@desc Adding new user
//@route POST /adduser
router.post('/adduser', actions.addNew)

//@desc Authenticate a user
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)

//@desc Get info on a user
//@route GET /getinfo
router.get('/getinfo', actions.getinfo)


//@desc Adding new user
//@route POST /adduser
router.post('/adddoc', docactions.addNew)

//@desc Authenticate a user
//@route POST /authenticate
router.post('/authenticatedoc', docactions.authenticate)

//@desc Get info on a user
//@route GET /getinfo
router.get('/getdocinfo', docactions.getinfo)

router.post('/getAlldoc', docactions.getAlldoc)

router.post('/setupMeeting', actions.setupMeeting)

router.post('/getmypateints', actions.getMyPateints)
router.post('/getmypateints/removeLink', docactions.removeLink)
router.post('/getMydoctors', actions.getMydoctors)
module.exports = router