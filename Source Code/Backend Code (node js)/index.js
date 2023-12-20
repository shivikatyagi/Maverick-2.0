const express = require('express')
const responseRouter = require('./routers/response')
const axios = require('axios')
const app = express()
const port = process.env.PORT||3000
app.use(express.json())
const { SerialPort } = require('serialport');
const {ReadlineParser } = require('@serialport/parser-readline');
const buffer = Buffer.alloc(1024); 
const port1 = new SerialPort({
    path: 'COM4',
    baudRate: 9600,
    dataBits: 8,
    stopBits: 1,
    parity: 'none',
    });
const parser = port1.pipe(new ReadlineParser({ delimiter: '\r\n' }));

function sendDataToServer(dataArray) {
    const x=dataArray[dataArray.length-1]
    const y=dataArray[dataArray.length-2]
    var xx = x.replace(/(\w+)\s*:\s*([\d.]+)/, '{"$1":$2}');
    var yy = y.replace(/(\w+)\s*:\s*([\d.]+)/, '{"$1":$2}');
    xx = JSON.parse(xx);
    yy = JSON.parse(yy);
    const ress = Object.assign({}, xx, yy);
    return ress
}
var final_data
const dataArray = [];
let temp=1
parser.on('data', (line) => {
  console.log(`Received: ${line}`);
        // setTimeout(10000);
//   buffer.write(line.toString(), buffer.length, 'utf-8');
  dataArray.push(line);
    console.log(dataArray.length);
    if(dataArray.length%6==0){   
        final_data = sendDataToServer(dataArray);
        // temp=0
    }
});

app.post('/getResponse' ,async (req, res) => {
    
    try {
        const data = final_data
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

app.post('/recommendation', (req, res) => {
    try {
        const taste = req.body
        if(taste.sweet>taste.bitter&&taste.sweet>taste.sour){
            res.send("Anti-inflammatory, Anti-oxidant, manage diabetes, protect against cancer, Anti-bacterial, reduce cholestrol level, anti-fungal.")
        }
        else if(taste.sour>taste.bitter&&taste.sour>taste.sweet){
            res.send("Anti-oxidant , improve heart health, digestive health, lower oxidative stress.")
        }
        else{
            res.send("Anti-inflammatory, Anti-oxidant, helps with digestive problem, anti-microbial, kidney health, balance blood sugar level.")
        }
    } catch(e) {
        res.status(400).send(e)
    }
});

// app.post('/sensor_data', (req, res) => {
//     try {
//         console.log(final_data);
//         res.status(200).send(final_data);
//     } catch(e){
//         res.status(400).send("error");
//     }
    
// });
// parser.on('end', () => {
//     // All data has been read
//     console.log('Finished reading data.');
  
//     // Do something with the complete buffer, if needed
//     console.log('Complete buffer:', buffer.toString('utf-8'));
//   });

app.use(responseRouter)

app.listen(port, () => {
    console.log('Server is up on port ' + port)
})