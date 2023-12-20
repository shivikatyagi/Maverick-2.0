const express = require('express')
const axios = require('axios')
const router = new express.Router()

router.post('/getResponse' ,async (req, res) => {
    
    try {
        const data = req.body
        console.log(data)
        const resp = await axios.post('http://127.0.0.1:5000',data );
        // console.log('ad')
        // {
        //     "ph_val": 7.9,
        //     "glu_level" : 46
        // }
        // console.log(resp.data.result)
        res.status(201).send(resp.data);
    } catch (e) {
        console.log(e)
        res.status(400).send(e)
    }
})

module.exports = router