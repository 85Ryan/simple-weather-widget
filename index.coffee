# TODO-1: Add OpenWeatherMap api key below
apiKey: 'YOUR OPENWEATHERMAP APIKEY'

# TODO-2: Add the units format (metric or imperial) below
units: 'metric'

# Refresh every 60 seconds
refreshFrequency: 60000

command: "echo {}"

render: (o) -> """
  <div class='weather'>
    <div class='icon'></div>
    <div class='temp'></div>
    <div class='summary'></div>
  </div>
"""

# Gets the location
afterRender: (domEl) ->
  geolocation.getCurrentPosition (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand("#{lat}", "#{lon}", @units, @apiKey)

    @refresh()

makeCommand: (lat, lon, units, apiKey) ->
  "curl -sS 'https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&units=#{units}&cnt=10&APPID=#{apiKey}'"

update: (output, domEl, unit) ->
  data  = JSON.parse(output)
  t = data.main
  return unless t?
  
  icon = data.weather[0].icon

  if @units != ''
    if @units == "metric"
      $(domEl).find('.temp').html """
        <span class='num'>#{Math.round(data.main.temp)}<span>&#xf03c;</span></span>
      """
    else if @units == "imperial"
      $(domEl).find('.temp').html """
        <span class='num'>#{Math.round(data.main.temp)}<span>&#xf045;</span></span>
      """
  else
    $(domEl).find('.temp').html """
      <span class='num'>#{Math.round(data.main.temp)}˚</span>
    """

  $(domEl).find('.summary').html """
    <p>#{data.weather[0].description} | #{data.name}, #{data.sys.country}</p>
  """
  $(domEl).find('.icon')[0].innerHTML = @getIcon(icon)

iconMapping:
  "01d"           :"&#xf00d;" # clear sky
  "01n"           :"&#xf02e;" # clear sky
  "02d"           :"&#xf00c;" # few clouds
  "02n"           :"&#xf081;" # few clouds
  "03d"           :"&#xf002;" # scattered clouds
  "03n"           :"&#xf086;" # scattered clouds
  "04d"           :"&#xf013;" # broken clouds
  "04n"           :"&#xf013;" # broken clouds
  "09d"           :"&#xf0B3;" # shower rain
  "09n"           :"&#xf0B4;" # shower rain
  "10d"           :"&#xf036;" # rain
  "10n"           :"&#xf028;" # rain
  "11d"           :"&#xf03b;" # thunderstorm
  "11n"           :"&#xf02d;" # thunderstorm
  "13d"           :"&#xf038;" # snow
  "13n"           :"&#xf067;" # snow
  "50d"           :"&#xf030;" # fog
  "50n"           :"&#xf023;" # fog
  "unknown"       :"&#xf03e;" # unknown
    
getIcon: (icon) ->
  return @iconMapping["unknown"] unless icon
  @iconMapping["#{icon}"]
      
style: """
  top: 30px
  left: 50px
  color: #fff
  text-shadow: 0 0 1px rgba(#000, 0.3)
  font-family: Helvetica Neue
  text-align: left
  width: 600px

  @font-face
    font-family Weather
    src url(simple-weather.widget/weathericons.svg) format('svg')

  .weather
    display: inline-block
    text-align: left
    position: relative
    width: 100%

  .icon
    font-family: Weather
    font-size: 60px
    line-height: 60px
    position: absolute
    left: 0
    vertical-align: middle

  .temp
    vertical-align: middle
    padding-left: 80px
    font-weight: 200
    font-size: 60px
    line-height: 60px
    position: relative

    .num
      position: relative

      span
        font-family: Weather
        font-size: 32px
        position: absolute
        top: 0
        right: -25px

  .summary
    display: inline-block
    text-transform: capitalize
    font-size: 12px
    line-height: 1.0
    color: #fff
    position: absolute
    left: 0
    top: 65px

    p
      margin-top: 2px
      margin-bottom: 2px
	  font-family: -apple-system, PingFang SC
"""
