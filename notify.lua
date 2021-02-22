local urlevent = require'hs.urlevent'

urlevent.bind("task-completed", function(eventName, params)
  local message = params['message']
  local timeout = tonumber(params['timeout'])

  if not message or message:len() == 0 then
    message = "Long running command completed"
  end

  if not timeout then
    timeout = 20
  end

  local notification = hs.notify.new(function() end,
    {
      autoWithdraw = true,
      title = "Terminal Notification",
      informativeText = message,
      hasActionButton = false
    }
  )
  notification:send()

  if timeout > 0 then
    hs.timer.doAfter(timeout, function()
      notification:withdraw()
    end)
  end
end)
