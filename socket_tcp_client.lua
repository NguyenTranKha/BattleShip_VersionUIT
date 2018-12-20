print("ESP8266 Client")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION) 
wifi.sta.config("UIT_Guest","1denmuoi1") -- connecting to server
wifi.sta.connect() 
print("Looking for a connection")
uart.setup(0, 9600, 8, 0, 0, 1)
--print(uart.getconfig(0))
array = {1,2,3,3,1}
local pin = 7            --  GPIO13
local status = gpio.HIGH
-- Initialising pin
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, status)

uart.on("data", "\r",
  function(data)
    print("receive from uart:", data)
    cl:send(data)
    if (status == gpio.HIGH) then status = gpio.LOW
    else status = gpio.HIGH 
    end
    gpio.write(pin, status)
    if data=="quit\r" then
      uart.on("data") -- unregister callback function
    end
end, 0)

tmr.alarm(1, 2000, 1, function()
     if(wifi.sta.getip()~=nil) then
          tmr.stop(1)
          print("Connected!")
          print("Client IP Address:",wifi.sta.getip())
          cl=net.createConnection(net.TCP, 0)
          cl:connect(8000,"192.168.0.108")
          --tmr.alarm(2, 5000, 1, function() 
            --s = ""
            --for i = 1, 5 do
               -- s = s .. string.char(array[i]) -- '..' create new string. Expensive!!
            --end
            --cl:send(s) 
          --end)*/
      else
         print("Connecting...")
      end
end)


function bytestostring(array)
  local s = ""
  for i = 0, 4 do
    s = s .. strchar(array1[i]) -- '..' create new string. Expensive!!
  end
  return s
end
