const express = require('express');
const os = require('os');

const app = express();
const PORT = 80;

// Serves everything in the "public" folder automatically.
// A request for "/" will return public/index.html.
app.use(express.static('public'));

// API endpoint the frontend's fetch() call hits
app.get('/click', (req, res) => {
    const colors = ['#f4a261', '#2a9d8f', '#e76f51', '#264653', '#e9c46a'];
    const randomColor = colors[Math.floor(Math.random() * colors.length)];

    res.json({
        color: randomColor,
        timestamp: new Date().toISOString()
    });
});

// Status endpoint, useful for your PowerShell script or just checking health
app.get('/status', (req, res) => {
    res.json({
        status: 'ok',
        hostname: os.hostname(),
        uptime_seconds: process.uptime()
    });
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});