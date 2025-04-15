import { execSync, spawn } from 'child_process';
import { setTimeout } from 'timers/promises';

import express from 'express';
const app = express();

app.use(express.json());

import cors from 'cors';
app.use(cors());

let lastKnownPosition;

console.log("👻 starting the terminal")
spawn("ghostty", ['--title=DevOxx 2025'])

let terminalWindowId;
function getTerminalWindowId(){
    if(terminalWindowId){
        return terminalWindowId
    }
    console.log("👻 getting terminal window id")
    terminalWindowId = execSync(`wmctrl -lx | grep "ghostty" | awk '{print $1}'`, { encoding: 'utf8' }).trimEnd();
    console.log(`👻 terminal window id : ${terminalWindowId}`)
    return terminalWindowId;
}

app.post('/show-window', async (req, res) => {
    console.log(`show window : ${JSON.stringify(req.body)}`)

    const {top,left,width, height} = req.body;
    execSync(`wmctrl -ir ${getTerminalWindowId()} -e 0,${top},${left},${width},${height}`);

    try{
        execSync(`wmctrl -i -a ${getTerminalWindowId()}`)
        res.sendStatus(200);
    }
    catch (e){
        res.sendStatus(500);
    }
});

app.post('/hide-window', (req, res) => {
    console.log('hide window');

    // show presentation slides

    execSync(`./streamdeck/show-window.sh 'Présentation'`);

    res.sendStatus(200);
});

function type(command){
    execSync(`setxkbmap fr && xdotool type --clearmodifiers --delay 100 '${command}'`);
}

const delay = ms => new Promise(resolve => setTimeout(resolve, ms))

app.post('/type', (req, res) => {
    console.log('type : ' + req.body.type);

    type(req.body.type);

    res.sendStatus(200);
});

app.listen(7000, () => {
    console.log(`gnome-server: listening on port ${7000}`);
});

