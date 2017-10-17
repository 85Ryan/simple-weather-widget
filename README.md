# simple-weather-widget
A simple weather widget for [Übersicht](http://tracesof.net/uebersicht/)

## ScreenShot

![Screenshot](https://github.com/85Ryan/simple-weather.widget/blob/master/screenshot.png)

## Setup
1. Install [Übersicht](http://tracesof.net/uebersicht/)
2. Download and unzip this repo, rename the file with `simple-weather.widget`.
3. Put the `simple-weather.widget` file in your Übersicht widget folder.
4. This widget requires an API key from the [OpenWeatherMap API](https://openweathermap.org/api). Before you use this widget, open `index.coffee`, and change the variable apiKey to the key you got from OpenWeatherMap.
5. You can change the units format (metric or imperial) in `index.coffee`.
6. The widget uses the new Geolocation API to find your location automatically. Requires Übersicht 0.5 or later to work.

## DarkSky VERSION
If you want to use the DarkSky API, see this:
https://github.com/85Ryan/simple-weather-darksky.widget

## Credits
Icons by Erik Flowers: http://erikflowers.github.io/weather-icons/
