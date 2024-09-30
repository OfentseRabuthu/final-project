// server.js

require('dotenv').config();
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());

// Set up API keys
const OPENWEATHER_API_KEY = process.env.OPENWEATHER_API_KEY;
const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;
const BASE_GOOGLE_URL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
const PLACE_DETAILS_URL = 'https://maps.googleapis.com/maps/api/place/details/json';

// Route for city search (Google Places API)
app.get('/searchCity', async (req, res) => {
    const input = req.query.input;
    const url = `${BASE_GOOGLE_URL}?input=${input}&types=(cities)&key=${GOOGLE_API_KEY}`;

    try {
        const response = await axios.get(url);
        res.json(response.data);
    } catch (error) {
        console.error('Error fetching data from Google Places API:', error);
        res.status(500).send('Error fetching data from Google Places API');
    }
});

// Route for fetching weather data (OpenWeather API)
app.get('/weather', async (req, res) => {
    const { lat, lon } = req.query;
    const url = `https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&appid=${OPENWEATHER_API_KEY}&units=metric`;

    try {
        const response = await axios.get(url);
        res.json(response.data);
    } catch (error) {
        console.error('Error fetching weather data from OpenWeather API:', error);
        res.status(500).send('Error fetching weather data from OpenWeather API');
    }
});

app.get('/placeDetails', async (req, res) => {
    const placeId = req.query.place_id;
    const url = `${PLACE_DETAILS_URL}?place_id=${placeId}&key=${GOOGLE_API_KEY}`;

    try {
        const response = await axios.get(url);
        res.json(response.data);
    } catch (error) {
        console.error('Error fetching place details from Google Places API:', error);
        res.status(500).send('Error fetching place details from Google Places API');
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
