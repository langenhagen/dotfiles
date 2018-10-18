local kb = libs.keyboard;


-- Documentation
-- http://www.unifiedremote.com/api

-- Keyboard Library
-- http://www.unifiedremote.com/api/libs/keyboard


--@help Up Arrow Key
actions.upcommand = function ()
	kb.stroke("up");
	kb.stroke("up");
	kb.stroke("up");
	kb.stroke("up");
	kb.stroke("up");
end


--@help Down Arrow Key
actions.downcommand = function ()
	kb.stroke("down");
	kb.stroke("down");
	kb.stroke("down");
	kb.stroke("down");
	kb.stroke("down");
end

