---@class Frameout
---@field frame integer 当前帧数
---@field left_count integer 剩余次数
---@field destroy fun() 销毁计时器
---@field pause fun() 暂停计时器
---@field resume fun() 恢复计时器

---@param interval integer 计时间隔（单位：帧）
---@param callback fun(frameout: Frameout) 回调函数
---@param count integer? 重复次数，-1为无限次
---@param immediately boolean? 是否立即执行回调
SetFrameOut = function(interval, callback, count, immediately)
    count = count or 1
    local frameout = {
        frame = 0,
        left_count = count,
        status = true
    }
    local decorator = function()
        frameout.frame = frameout.frame + interval
        if count > 0 then
            frameout.left_count = frameout.left_count - 1
        end
        callback(frameout)
        if frameout and count > 0 and (frameout.left_count == 0) then
            frameout.destroy()
        end
    end
    local handler = LuaAPI.global_register_trigger_event(
        { EVENT.REPEAT_TIMEOUT, math.tofixed(interval) / 30.0 }, decorator
    )
    ---销毁计时器
    frameout.destroy = function()
        LuaAPI.global_unregister_trigger_event(handler)
        frameout = nil
    end
    ---暂停计时器
    frameout.pause = function()
        LuaAPI.global_unregister_trigger_event(handler)
        frameout.status = false
    end
    ---恢复计时器
    frameout.resume = function()
        handler = LuaAPI.global_register_trigger_event(
            { EVENT.REPEAT_TIMEOUT, math.tofixed(interval) / 30.0 }, decorator
        )
        frameout.status = true
    end
    if immediately then
        decorator()
    end
    return frameout
end
